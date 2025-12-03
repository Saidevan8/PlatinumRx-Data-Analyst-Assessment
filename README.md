# 📊 PlatinumRx – Data Analyst Assessment

This repository contains my complete submission for the **PlatinumRx Data Analyst Assignment**, covering SQL proficiency, spreadsheet analysis, and Python scripting. The goal of this project is to demonstrate skills across data modeling, querying, analytical logic, Excel formulas, and basic Python programming.

---

## 📁 Repository Structure

```
Data_Analyst_Assignment/
│
├── SQL/
│   ├── 01_hotel_schema.sql
│   ├── 02_hotel_sample_data.sql
│   ├── 03_hotel_queries.sql
│   ├── 11_clinic_schema.sql
│   ├── 12_clinic_sample_data.sql
│   └── 13_clinic_queries.sql
│
├── Spreadsheets/
│   └── ticket_analysis.xlsx
│
├── Python/
│   ├── 01_time_converter.py
│   └── 02_remove_duplicates.py
│
└── README.md
```

---

# 🧩 Assignment Overview

The assignment is divided into three parts:

---

# 1️⃣ SQL Proficiency

The SQL section includes **two independent systems**:

## 🏨 A. Hotel Management System

Schema includes:

* `users`
* `bookings`
* `items`
* `booking_commercials`

Tasks completed in `03_hotel_queries.sql`:

1. Retrieve each user’s **last booked** room.
2. Calculate **total billing amount** per booking for November 2021.
3. Retrieve bills from October 2021 with billing amount > 1000.
4. Identify the **most and least ordered item** for each month in 2021.
5. Find customers with the **second-highest bill value** each month.

---

## 🏥 B. Clinic Management System

Schema includes:

* `clinics`
* `customer`
* `clinic_sales`
* `expenses`

Tasks completed in `13_clinic_queries.sql`:

1. Revenue by each **sales channel** for a given year.
2. Top 10 **most valuable customers** for a given year.
3. Month-wise **revenue, expense, profit**, and profitability status.
4. Most profitable clinic per **city** for a selected month.
5. Second least profitable clinic per **state** for a selected month.

Both schemas and sample datasets are included in the `SQL/` folder.

---

# 2️⃣ Spreadsheet Proficiency

Located in:
📁 `Spreadsheets/ticket_analysis.xlsx`

Sheets include:

* `ticket`
* `feedbacks`
* `summary` (Pivot/COUNTIFS-based)

Tasks completed:

1. **Populate** `ticket_created_at` in the `feedbacks` sheet using lookup logic referencing `ticket.cms_id`.

   * Implemented using **XLOOKUP / INDEX-MATCH** (depending on compatibility).
2. Compute outlet-wise counts for:

   * Tickets created **and closed on the same day**.
   * Tickets created and closed in the **same hour**.
     Implemented using helper columns + Pivot Table or `COUNTIFS`.

The Excel file contains:
✔ Helper columns
✔ Lookup formulas
✔ Summary table
✔ Pivot table (optional)

---

# 3️⃣ Python Proficiency

Located in `Python/` folder.

### 01_time_converter.py

Converts minutes into human-readable format:

* Example:

  * `130 → "2 hrs 10 minutes"`
  * `110 → "1 hr 50 minutes"`

### 02_remove_duplicates.py

Removes duplicate characters from a string using loops while preserving order.

---

# 🛠 Tools & Environment

* **SQL:** MySQL 8.0 (Queries compatible with MySQL window functions)
* **Spreadsheet:** Microsoft Excel / Google Sheets
* **Python:** Python 3.x

---

# 🚀 How to Run

### ▶ SQL

1. Load schema files (`01_*.sql`, `11_*.sql`) into MySQL.
2. Insert sample data (`02_*.sql`, `12_*.sql`).
3. Run query files (`03_*.sql`, `13_*.sql`).

### ▶ Spreadsheet

Open `ticket_analysis.xlsx` and review formulas + pivot summaries.

### ▶ Python

Run:

```bash
python3 01_time_converter.py
python3 02_remove_duplicates.py
```

---

# 📌 Notes & Assumptions

* Billing computation is derived from `item_quantity * item_rate`.
* All date comparisons assume uniform timezone.
* Window functions (`ROW_NUMBER`, `DENSE_RANK`) require MySQL 8+.
* Excel functions used are compatible with both Excel 365 and Google Sheets.

---

# 📧 Contact

For any queries related to this assignment or for review discussions, feel free to reach out.

