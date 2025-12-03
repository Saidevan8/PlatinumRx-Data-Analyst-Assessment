-- Q1: Last booked room for every user
-- Description: find the most recent booking_date per user and return that booking's room_no.
SELECT b.user_id,
       b.room_no,
       b.booking_date
FROM bookings b
JOIN (
    SELECT user_id, MAX(booking_date) AS last_booking
    FROM bookings
    GROUP BY user_id
) last_bk
  ON b.user_id = last_bk.user_id
 AND b.booking_date = last_bk.last_booking
ORDER BY b.user_id;

-- Q2: Booking totals for bookings created in November 2021
-- Description: sum(item_quantity * item_rate) per booking where booking_date is in Nov 2021.
SELECT b.booking_id,
       b.user_id,
       COALESCE(SUM(bc.item_quantity * i.item_rate), 0) AS total_billing_amount
FROM bookings b
LEFT JOIN booking_commercials bc ON bc.booking_id = b.booking_id
LEFT JOIN items i ON i.item_id = bc.item_id
WHERE b.booking_date BETWEEN '2021-11-01 00:00:00' AND '2021-11-30 23:59:59'
GROUP BY b.booking_id, b.user_id
ORDER BY total_billing_amount DESC;


-- Q3: Bills in Oct 2021 with amount > 1000
-- Description: group commercial lines by bill_id (and bill_date) and filter sums > 1000 for Oct 2021.
SELECT bc.bill_id,
       DATE(bc.bill_date) AS bill_date,
       SUM(bc.item_quantity * i.item_rate) AS bill_amount
FROM booking_commercials bc
JOIN items i ON i.item_id = bc.item_id
WHERE bc.bill_date BETWEEN '2021-10-01 00:00:00' AND '2021-10-31 23:59:59'
GROUP BY bc.bill_id, DATE(bc.bill_date)
HAVING SUM(bc.item_quantity * i.item_rate) > 1000
ORDER BY bill_amount DESC;


-- Q4 (single-winner): Most and least ordered item per month (2021)
WITH monthly_item_qty AS (
  SELECT
    DATE_FORMAT(bc.bill_date, '%Y-%m-01') AS month_start,
    i.item_id,
    i.item_name,
    SUM(bc.item_quantity) AS total_qty
  FROM booking_commercials bc
  JOIN items i ON i.item_id = bc.item_id
  WHERE YEAR(bc.bill_date) = 2021
  GROUP BY month_start, i.item_id, i.item_name
),
most AS (
  SELECT month_start, item_name AS most_item, total_qty,
         ROW_NUMBER() OVER (PARTITION BY month_start ORDER BY total_qty DESC, item_name) AS rn
  FROM monthly_item_qty
),
least AS (
  SELECT month_start, item_name AS least_item, total_qty,
         ROW_NUMBER() OVER (PARTITION BY month_start ORDER BY total_qty ASC, item_name) AS rn
  FROM monthly_item_qty
)
SELECT m.month_start,
       m.most_item, m.total_qty AS most_qty,
       l.least_item, l.total_qty AS least_qty
FROM (SELECT * FROM most WHERE rn = 1) m
LEFT JOIN (SELECT * FROM least WHERE rn = 1) l USING (month_start)
ORDER BY m.month_start;


-- Q5 (booking-level): second highest booking total per month in 2021
WITH booking_totals AS (
  SELECT
    b.booking_id,
    b.user_id,
    DATE_FORMAT(b.booking_date, '%Y-%m-01') AS month_start,
    COALESCE(SUM(bc.item_quantity * i.item_rate), 0) AS booking_total
  FROM bookings b
  LEFT JOIN booking_commercials bc ON bc.booking_id = b.booking_id
  LEFT JOIN items i ON i.item_id = bc.item_id
  WHERE YEAR(b.booking_date) = 2021
  GROUP BY b.booking_id, b.user_id, month_start
),
ranked AS (
  SELECT bt.*,
         DENSE_RANK() OVER (PARTITION BY month_start ORDER BY booking_total DESC) AS dr
  FROM booking_totals bt
)
SELECT r.month_start, r.booking_id, r.user_id, u.name AS user_name, r.booking_total
FROM ranked r
JOIN users u ON u.user_id = r.user_id
WHERE r.dr = 2
ORDER BY r.month_start;
