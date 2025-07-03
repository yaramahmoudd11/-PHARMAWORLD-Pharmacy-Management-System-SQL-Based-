# -PHARMAWORLD-Pharmacy-Management-System-SQL-Based-

# 💊 PHARMAWORLD — Pharmacy Management System (SQL-Based)

A fully structured SQL database system designed for **PHARMAWORLD**, a veterinary pharmacy. This system simulates real-world business operations including employees, departments, products, clients, inventory, transactions, day-off management, and financial analytics.

## 📦 Database Features

- **Normalized Schema:** 10+ interrelated tables with appropriate data types and constraints.
- **Data Integrity:** Extensive use of primary keys, foreign keys, checks, and default values.
- **Views:**
  - `SalesSalary`: Calculates dynamic salaries for sales agents.
  - `PersonalInfo`: Combines personal and department info with salary logic.
  - `Offers1/2/3`: Generates dynamic offers based on price, expiration, and stock.
- **Advanced Queries:**
  - Monthly profit calculation.
  - Most active client/product/salesperson.
  - Inventory summary and low-stock alerts.
- **DML Operations:**
  - Insert, update, and delete operations for all major tables.
  - Auto-ID generation for new entries.

## 🗂️ Schema Overview

- **company_info** – Company metadata  
- **Department** – Department roles and base salaries  
- **empolyee** – Employee personal and work info  
- **Daysoff** – Leave tracking with approval states  
- **products** – Veterinary products  
- **Stock** – Inventory with price, quantity, and expiration  
- **clients** – Business clients and financial status  
- **transactions** – Buy/sell records with payment tracking  
- **FINANCIAL_INFO** – Financial obligations and credit status

## 🧪 Example Use Cases

- Fetch all products expiring in 20 days and offer a discount.
- Determine highest selling product and best salesperson.
- Track department-wise approved days off.
- Calculate net monthly profit based on transaction types.

## ⚙️ How to Use

1. Open SQL Server Management Studio or your preferred tool.
2. Execute `Data and tables.sql` to create and populate the database.
3. Execute `SQLQuery2project.sql` to create views and run analytics.


