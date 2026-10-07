# Data_Transformer

Overview

Data Transformer is a practical MySQL project that demonstrates how SQL can be used to retrieve, transform, analyze, and present relational data.

The project works with customer, order, and employee data and covers JOINs, subqueries, date functions, string functions, window functions, ranking, and conditional logic.

Objectives

Combine data from multiple related tables.

Retrieve matching and non-matching records using JOINs.

Use subqueries with aggregate functions.

Extract and format dates.

Transform and clean text data.

Calculate running totals and rankings.

Apply business rules using CASE.

Build practical SQL queries for reporting and analysis.

Database Tables

customers

Column

Purpose

CustomerID

Unique customer identifier

FirstName

Customer first name

LastName

Customer last name

Email

Customer email

RegistrationDate

Registration date

orders

Column

Purpose

OrderID

Unique order identifier

CustomerID

Related customer identifier

OrderDate

Date of order

TotalAmount

Total order value

employees

Column

Purpose

EmployeeID

Unique employee identifier

FirstName

Employee first name

LastName

Employee last name

Department

Employee department

HireDate

Joining date

Salary

Employee salary

SQL Concepts Covered

JOINs

INNER JOIN

LEFT JOIN

RIGHT JOIN

FULL OUTER JOIN simulation using UNION

Subqueries

Orders above average order amount

Employees above average salary

Date Functions

YEAR()

MONTH()

DATEDIFF()

DATE_FORMAT()

String Functions

CONCAT()

REPLACE()

UPPER()

LOWER()

TRIM()

Window Functions

Running total using SUM() OVER()

Ranking using RANK() OVER()

Conditional Logic

Discount and salary categories are created using CASE.

CASE
    WHEN TotalAmount > 1000 THEN '10% Discount'
    WHEN TotalAmount > 500 THEN '5% Discount'
    ELSE 'No Discount'
END

Important MySQL Note

MySQL does not support FULL OUTER JOIN directly. Therefore, the project simulates it using LEFT JOIN + UNION + RIGHT JOIN.

Technologies Used

MySQL

SQL

MySQL Command Line Client

MySQL Workbench (optional)

How to Run

Open MySQL Command Line Client or MySQL Workbench.

Select your database:

USE your_database_name;

Check the tables:

SHOW TABLES;

Expected tables:

customers
orders
employees

Verify their structures:

DESC customers;
DESC orders;
DESC employees;

Execute the queries from project2_data_transformer.sql.

Run each query separately and verify the output.

Recommended Repository Structure

Project-2-Data-Transformer/
│
├── project2_data_transformer.sql
├── README.md
│
└── screenshots/
    ├── inner-join.png
    ├── left-join.png
    ├── right-join.png
    ├── full-outer-join.png
    ├── subquery.png
    ├── date-functions.png
    ├── string-functions.png
    ├── window-functions.png
    └── case-when.png

Query Summary

No.

Concept

SQL Feature

1

Matching records

INNER JOIN

2

All customers

LEFT JOIN

3

All orders

RIGHT JOIN

4

Both-sided records

UNION + JOINs

5

Average order comparison

Subquery + AVG()

6

Average salary comparison

Subquery + AVG()

7

Extract date parts

YEAR(), MONTH()

8

Date difference

DATEDIFF()

9

Date formatting

DATE_FORMAT()

10

Full customer name

CONCAT()

11

Text replacement

REPLACE()

12

Case conversion

UPPER(), LOWER()

13

Text cleaning

TRIM()

14

Running total

SUM() OVER()

15

Ranking

