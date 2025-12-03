-- USERS
CREATE TABLE users (
    user_id        VARCHAR(64) PRIMARY KEY,
    name           VARCHAR(150) NOT NULL,
    phone_number   VARCHAR(32),
    mail_id        VARCHAR(200),
    billing_address TEXT
);

-- ITEMS
CREATE TABLE items (
    item_id    VARCHAR(64) PRIMARY KEY,
    item_name  VARCHAR(200) NOT NULL,
    item_rate  DECIMAL(12,2) NOT NULL
);

-- BOOKINGS
CREATE TABLE bookings (
    booking_id    VARCHAR(64) PRIMARY KEY,
    booking_date  DATETIME NOT NULL,
    room_no       VARCHAR(64),
    user_id       VARCHAR(64),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- BOOKING COMMERCIALS
CREATE TABLE booking_commercials (
    id             VARCHAR(64) PRIMARY KEY,
    booking_id     VARCHAR(64),
    bill_id        VARCHAR(64),
    bill_date      DATETIME,
    item_id        VARCHAR(64),
    item_quantity  DECIMAL(10,2) NOT NULL DEFAULT 1,
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),
    FOREIGN KEY (item_id)       REFERENCES items(item_id)
);


/* ========================== USERS ========================== */

INSERT INTO users (user_id, name, phone_number, mail_id, billing_address) VALUES
('21wrcxuy-67erfn', 'John Doe', '97XXXXXXXX', 'john.doe@example.com', '123 Main Street, Mumbai'),
('84mxp9ue-p3k29d', 'Asha Reddy', '98XXXXXXXX', 'asha.r@example.com', 'Hyderabad, Telangana'),
('pq94mdke-228ssk', 'Ravi Kumar', '99XXXXXXXX', 'ravi.k@example.com', 'Bangalore, Karnataka');


/* ========================== ITEMS ========================== */

INSERT INTO items (item_id, item_name, item_rate) VALUES
('itm-a9e8-q8fu', 'Tawa Paratha', 18),
('itm-a07vh-aer8', 'Mix Veg', 89),
('itm-p0q2k-11ut', 'Paneer Butter Masala', 150),
('itm-pp93k-kd92', 'Mineral Water', 20);


/* ========================== BOOKINGS ========================== */

INSERT INTO bookings (booking_id, booking_date, room_no, user_id) VALUES
('bk-09f3e-95hj', '2021-09-23 07:36:48', 'rm-bhf9-aerjn', '21wrcxuy-67erfn'),
('bk-q034-q40o',  '2021-09-23 09:10:10', 'rm-kk39-ppw2h', '84mxp9ue-p3k29d'),
('bk-11af-9ld2',  '2021-09-24 10:55:00', 'rm-mm20-zz22k', 'pq94mdke-228ssk');

/* ========================== BOOKING_COMMERCIALS ========================== */

INSERT INTO booking_commercials (id, booking_id, bill_id, bill_date, item_id, item_quantity) VALUES
('q34r-3q4o8-q34u', 'bk-09f3e-95hj', 'bl-0a87y-q340', '2021-09-23 12:03:22', 'itm-a9e8-q8fu', 3),
('q304-ahf32-o2u4', 'bk-09f3e-95hj', 'bl-0a87y-q340', '2021-09-23 12:03:22', 'itm-a07vh-aer8', 1),
('134lr-oyfo8-3qk4', 'bk-q034-q40o', 'bl-34ghd-r7h8', '2021-09-23 12:05:37', 'itm-a9e8-q8fu', 0.5),
('1pl0p-39dke-22lm', 'bk-q034-q40o', 'bl-34ghd-r7h8', '2021-09-23 12:05:37', 'itm-p0q2k-11ut', 2),
('88ka0-2kdk2-ppw9', 'bk-11af-9ld2', 'bl-8adje-pp98', '2021-09-24 13:22:10', 'itm-a07vh-aer8', 1),
('9adk3-22kdk-wl20', 'bk-11af-9ld2', 'bl-8adje-pp98', '2021-09-24 13:22:10', 'itm-pp93k-kd92', 2);