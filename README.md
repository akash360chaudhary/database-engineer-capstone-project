# database-engineer-capstone-project
Setting up repository for database engineer capstone project

# Little Lemon Database

A relational database project for **Little Lemon**, a fictional restaurant, built with **MySQL**. The database organizes customers, staff, table bookings, menus, orders, and delivery tracking. It also demonstrates practical SQL techniques for routine restaurant operations and reporting, including views, joins, subqueries, stored procedures, prepared statements, and transaction control.

This project was built as part of the **Meta Database Engineer Capstone project**.

---

## Table of Contents

- [Project Overview](#project-overview)
- [Features](#features)
- [Tech Stack](#tech-stack)
- [Database Design](#database-design)
- [Repository Structure](#repository-structure)
- [Getting Started](#getting-started)
- [SQL Components](#sql-components)
- [Example Usage](#example-usage)
- [Execution Notes and Limitations](#execution-notes-and-limitations)
- [Concepts Demonstrated](#concepts-demonstrated)
- [Author](#author)
- [License](#license)

---

## Project Overview

The `littlelemondb` schema supports common restaurant data-management scenarios. It connects customer information to bookings and orders, relates menu entries to menu-item details, and associates delivery records with orders.

The SQL scripts demonstrate two broad use cases:

1. **Restaurant operations:** checking table availability and creating, updating, or canceling bookings and orders.
2. **Data retrieval and reporting:** summarizing order quantities, identifying higher-value orders, and querying related information across several tables.

## Features

- Relational schema containing **7 tables** with primary keys and foreign-key relationships.
- Referential-integrity rules using `ON DELETE CASCADE` and `ON UPDATE CASCADE` on the defined foreign keys.
- Booking procedures to check availability, add a reservation, update a booking date, and cancel a reservation.
- Transaction-control example using `START TRANSACTION`, `COMMIT`, and `ROLLBACK` during booking validation.
- `OrdersView` view for filtering orders with a quantity greater than two.
- Multi-table `JOIN` query for customer and menu details associated with higher-value orders.
- `ANY` subquery to find menu entries associated with orders whose quantity is greater than two.
- Reusable stored procedures for retrieving maximum order quantity and canceling an order.
- Parameterized prepared-statement example for retrieving order details by customer ID.
- Entity-relationship diagram and editable MySQL Workbench model.

## Tech Stack

- **Database:** MySQL 8.x
- **Database modeling:** MySQL Workbench
- **Language:** SQL (DDL, DML, joins, subqueries, views, stored procedures, prepared statements, and transactions)
- **Storage engine:** InnoDB

## Database Design

### Entity-Relationship Diagram

The ER diagram image is included in the repository as `LittleLemonDB ER-Diagram Image.png`. The image is referenced by its original filename here, but it is not embedded or displayed in this README.

### Tables

| Table | Purpose | Key relationships |
|---|---|---|
| `customers` | Stores customer name, email, and phone number. | Referenced by `bookings` and `orders`. |
| `staff` | Stores staff name, role, and salary. | Referenced by `bookings`. |
| `bookings` | Stores booking date, table number, customer, and assigned staff member. | References `customers` and `staff`; referenced by `orders`. |
| `menuitems` | Stores course, starter, dessert, and drink details. | Referenced by `menus`. |
| `menus` | Stores menu item name, cuisine, price, and associated menu-item record. | References `menuitems`; referenced by `orders`. |
| `orders` | Stores order date, quantity, total cost, customer, menu, and booking. | References `customers`, `menus`, and `bookings`; referenced by `deliverystatus`. |
| `deliverystatus` | Stores a delivery identifier, delivery date, status, and related order. | References `orders`. |

### Key Relationships

- One customer can have multiple bookings and multiple orders.
- One staff member can be assigned to multiple bookings.
- A menu record can reference a menu-item detail record.
- Each order references a customer, a menu, and a booking.
- An order can be associated with delivery-status records.

The schema defines primary keys to identify records and foreign keys to connect related tables. The SQL uses the `InnoDB` storage engine and the `utf8mb3` character set.

## Repository Structure

The repository contains the following project files. The names below match the files supplied for this project.

```text
LittleLemonDB/
├── LittleLemonDB.sql
├── LittleLemonDB ER Diagram.mwb
├── LittleLemonDB ER-Diagram Image.png
├── Create_a_virtual_table_to_summarize_data.sql
├── Create_optimized_queries_to_manage_and_analyze_data.sql
├── Create_SQL_queries_to_add_and_update_bookings.sql
├── Create_SQL_queries_to_check_available_bookings_based_on_user_input.sql
└── README.md
```

| File | Description |
|---|---|
| `LittleLemonDB.sql` | Creates the `littlelemondb` schema, seven tables, primary keys, indexes, and foreign-key constraints. |
| `Create_a_virtual_table_to_summarize_data.sql` | Defines `OrdersView` and includes join- and subquery-based reporting examples. |
| `Create_optimized_queries_to_manage_and_analyze_data.sql` | Defines `GetMaxQuantity` and `CancelOrder`, and demonstrates the `GetOrderDetail` prepared statement. |
| `Create_SQL_queries_to_add_and_update_bookings.sql` | Defines procedures for adding, updating, and canceling bookings. |
| `Create_SQL_queries_to_check_available_bookings_based_on_user_input.sql` | Includes booking seed inserts, the `CheckBooking` procedure, and the transaction-based `AddValidBooking` procedure. |
| `LittleLemonDB ER Diagram.mwb` | Editable MySQL Workbench model. |
| `LittleLemonDB ER-Diagram Image.png` | Exported ER diagram image used in this README. |

## Getting Started

### Prerequisites

- MySQL Server 8.0 or later
- MySQL Workbench or another MySQL client
- Git, if cloning the repository

### 1. Clone the repository

Replace the placeholders with your GitHub username and repository name.

```bash
git clone https://github.com/YOUR_USERNAME/YOUR_REPOSITORY.git
cd YOUR_REPOSITORY
```

### 2. Create the database and tables

From a terminal with the MySQL command-line client installed, run:

```bash
mysql -u root -p < LittleLemonDB.sql
```

Alternatively, open `LittleLemonDB.sql` in MySQL Workbench and execute it. This script creates the schema and tables; **it does not insert a complete sample dataset**.

### 3. Add sample data

Insert valid records into the parent tables before adding records that reference them. For example, insert customers and staff before bookings, insert menu-item records before menus, and create the required bookings and menus before orders. Ensure that every foreign-key value refers to an existing record.

### 4. Create and test the SQL objects

Review the [Execution Notes and Limitations](#execution-notes-and-limitations) before running the exercise scripts. After correcting the noted issues and preparing the required sample records, open each `.sql` file in MySQL Workbench and execute its statements. The scripts contain example procedure calls, so take care when rerunning statements that insert or delete records.

Suggested learning order:

1. `LittleLemonDB.sql` — create the schema and tables.
2. Prepare valid sample data for the tables.
3. `Create_SQL_queries_to_check_available_bookings_based_on_user_input.sql` — booking availability and transaction example.
4. `Create_SQL_queries_to_add_and_update_bookings.sql` — booking CRUD procedures.
5. `Create_a_virtual_table_to_summarize_data.sql` — view and reporting queries.
6. `Create_optimized_queries_to_manage_and_analyze_data.sql` — stored procedures and prepared statement.

> To inspect or edit the data model visually, open `LittleLemonDB ER Diagram.mwb` in MySQL Workbench.

## SQL Components

### Views and analytical queries

| Component | Purpose |
|---|---|
| `OrdersView` | Displays `OrderID`, `Quantity`, and `TotalCost` (aliased as `Cost`) for orders where `Quantity > 2`. |
| Multi-table `JOIN` | Retrieves customer details, order information, menu names, and selected menu-item details for orders where `TotalCost > 150`. |
| `ANY` subquery | Retrieves menu names associated with orders whose quantity is greater than two. |

### Stored procedures

| Procedure | Purpose |
|---|---|
| `GetMaxQuantity()` | Returns the maximum value in `orders.Quantity`. |
| `CancelOrder(o_order_id)` | Deletes the order matching the supplied order ID and returns a confirmation message. |
| `CheckBooking(bookDate, tableNo)` | Checks whether a table number appears in the bookings table for the specified date. |
| `AddValidBooking(bookDate, tableNo)` | Demonstrates transaction control by rolling back when the table is already booked or committing a new booking in the available-table branch. |
| `AddBooking(newbookid, newcustomerid, newbookdate, tablenum)` | Inserts a booking and selects a staff member for assignment. |
| `UpdateBooking(booking_id, newDate)` | Updates the date for an existing booking ID, or returns a message when it is not found. |
| `CancelBooking(cancelBookingID)` | Deletes a booking and uses `ROW_COUNT()` to report whether a record was removed. |

### Prepared statement

| Statement | Purpose |
|---|---|
| `GetOrderDetail` | Returns `OrderID`, `Quantity`, and `TotalCost` for a supplied `CustomerID` using a `?` parameter placeholder. The `PREPARE`, variable assignment, and `EXECUTE` operations must be run in the same database session. |

## Example Usage

The examples below assume that the schema, stored procedures, and suitable sample records have already been created. Use IDs that exist in your own data, and check the execution notes before calling the booking procedures.

```sql
USE littlelemondb;

-- Check whether table 3 is booked on this date
CALL CheckBooking('2022-11-12', 3);

-- Add a booking (requires an existing customer and available booking ID)
CALL AddBooking(7, 2, '2026-10-23', 3);

-- Update the date for booking 7
CALL UpdateBooking(7, '2026-10-24');

-- Cancel booking 7
CALL CancelBooking(7);

-- Return the largest order quantity
CALL GetMaxQuantity();
```

To try the prepared statement, execute the following in the same MySQL session:

```sql
PREPARE GetOrderDetail
FROM 'SELECT OrderID, Quantity, TotalCost FROM Orders WHERE CustomerID = ?';

SET @id = 1;
EXECUTE GetOrderDetail USING @id;
DEALLOCATE PREPARE GetOrderDetail;
```

## Execution Notes and Limitations

The project files are learning exercises and **some supplied statements need correction before the scripts can run end-to-end**. Check the following items against your schema and seed data:

- The booking seed insert uses `BookingsID`, while the schema column is named `BookingID`.
- One seed date is written as `'2022-10,13'`; use the valid date format `'YYYY-MM-DD'`.
- The schema defines `StaffID` as `VARCHAR(50)`, but the booking procedures declare staff-ID variables as `INT`. Align the variable types with the schema and your actual staff IDs.
- The schema creates the table as `bookings`, while some procedure scripts refer to `Bookings`. Table-name case sensitivity varies by MySQL operating system and configuration, so standardize the spelling/capitalization across scripts.
- `AddValidBooking` inserts a fixed `CustomerID` value, so that customer must exist before the procedure is called.
- Some example calls assume specific customer, staff, booking, and order IDs. The database creation script does not populate these records automatically.
- The booking check is an educational transaction example. By itself, a count-then-insert check does not guarantee that concurrent booking requests cannot reserve the same table; stronger concurrency protection may require additional constraints and transaction/locking design.
- `CancelOrder` returns a cancellation message after its `DELETE` statement without checking whether an order was actually deleted.

Review these points and test the procedures with valid data before describing the project as production-ready.

## Concepts Demonstrated

`CREATE SCHEMA` · `CREATE TABLE` · Primary and foreign keys · Indexes · Cascading constraints · `JOIN` · Subqueries · Views · Stored procedures · Prepared statements · `START TRANSACTION` · `COMMIT` · `ROLLBACK` · `ROW_COUNT()` · Data modeling in MySQL Workbench

## Author

**Akash Chaudhary**  
GitHub: [akash360chaudhary](https://github.com/akash360chaudhary) · LinkedIn: [ak-chaudhary](https://www.linkedin.com/in/ak-chaudhary/)

## License

This project is intended for learning and portfolio purposes. No license file is currently included.
