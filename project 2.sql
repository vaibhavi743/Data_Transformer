create database Data_Transformer;

Query OK, 1 row affected

use Data_Transformer;

Database changed

create table Customers(
    CustomerId int primary key,
    FirstName varchar(30),
    LastName varchar(30),
    Email varchar(30),
    Registration_date DATE
);

Query OK, 0 rows affected

insert into Customers values
(1,'John','Doe','john.doe@email.com','2022-03-15'),
(2,'Jane','Smith','jane.smith@email.com','2021-11-02');

Query OK, 2 rows affected (0.833 sec)
Records: 2  Duplicates: 0  Warnings: 0

select * from Customers;

+------------+-----------+----------+----------------------+-------------------+
| CustomerId | FirstName | LastName | Email                | Registration_date |
+------------+-----------+----------+----------------------+-------------------+
|          1 | John      | Doe      | john.doe@email.com   | 2022-03-15        |
|          2 | Jane      | Smith    | jane.smith@email.com | 2021-11-02        |
+------------+-----------+----------+----------------------+-------------------+
2 rows in set.

create table Orders(
    OrderId int primary key,
    CustomerId int,
    OrderDate DATE,
    TotalAmount decimal(10,2)
);

Query OK, 0 rows affected

insert into Orders values
(101,1,'2023-07-01',150.00),
(102,2,'2023-07-03',200.75);

Query OK, 2 rows affected (0.237 sec)
Records: 2  Duplicates: 0  Warnings: 0

select * from Orders;

+---------+------------+------------+-------------+
| OrderId | CustomerId | OrderDate  | TotalAmount |
+---------+------------+------------+-------------+
|     101 |          1 | 2023-07-01 |      150.00 |
|     102 |          2 | 2023-07-03 |      200.75 |
+---------+------------+------------+-------------+
2 rows in set

create table Employees(
    EmployeeId int primary key,
    FirstName varchar(30),
    LastName varchar(30),
    Department varchar(30),
    HireDate DATE,
    Salary int
);

Query OK, 0 rows affected

insert into Employees values
(1,'Mark','Johnson','Sales','2020-01-15',50000.00),
(2,'Susan','Lee','HR','2021-03-20',55000.00);

Query OK, 2 rows affected (0.370 sec)
Records: 2  Duplicates: 0  Warnings: 0

select * from Employees;
+------------+-----------+----------+------------+------------+--------+
| EmployeeId | FirstName | LastName | Department | HireDate   | Salary |
+------------+-----------+----------+------------+------------+--------+
|          1 | Mark      | Johnson  | Sales      | 2020-01-15 |  50000 |
|          2 | Susan     | Lee      | HR         | 2021-03-20 |  55000 |
+------------+-----------+----------+------------+------------+--------+
2 rows in set

--- 1)

select o.OrderId,
o.CustomerId,
o.OrderDate,
o.TotalAmount, 
c.FirstName,
c.LastName,
c.Email
from Orders o
inner join Customers c
on o.CustomerId=c.CustomerId;

+---------+------------+------------+-------------+-----------+----------+----------------------+
| OrderId | CustomerId | OrderDate  | TotalAmount | FirstName | LastName | Email                |
+---------+------------+------------+-------------+-----------+----------+----------------------+
|     101 |          1 | 2023-07-01 |      150.00 | John      | Doe      | john.doe@email.com   |
|     102 |          2 | 2023-07-03 |      200.75 | Jane      | Smith    | jane.smith@email.com |
+---------+------------+------------+-------------+-----------+----------+----------------------+
2 rows in set

---2)

select 
o.OrderId,
o.OrderDate,
o.TotalAmount, 
c.CustomerId,
c.FirstName,
c.LastName,
c.Email
from Customers c
left join Orders o
on c.CustomerId=o.CustomerId;

+---------+------------+-------------+------------+-----------+----------+----------------------+
| OrderId | OrderDate  | TotalAmount | CustomerId | FirstName | LastName | Email                |
+---------+------------+-------------+------------+-----------+----------+----------------------+
|     101 | 2023-07-01 |      150.00 |          1 | John      | Doe      | john.doe@email.com   |
|     102 | 2023-07-03 |      200.75 |          2 | Jane      | Smith    | jane.smith@email.com |
+---------+------------+-------------+------------+-----------+----------+----------------------+
2 rows in set

---3)

select o.OrderId,
o.CustomerId,
o.OrderDate,
o.TotalAmount, 
c.FirstName,
c.LastName,
c.Email
from Customers c 
right join Orders o
on c.CustomerId=o.CustomerId;

+---------+------------+------------+-------------+-----------+----------+----------------------+
| OrderId | CustomerId | OrderDate  | TotalAmount | FirstName | LastName | Email                |
+---------+------------+------------+-------------+-----------+----------+----------------------+
|     101 |          1 | 2023-07-01 |      150.00 | John      | Doe      | john.doe@email.com   |
|     102 |          2 | 2023-07-03 |      200.75 | Jane      | Smith    | jane.smith@email.com |
+---------+------------+------------+-------------+-----------+----------+----------------------+
2 rows in set

---4)

select o.OrderId,
o.OrderDate,
o.TotalAmount, 
c.CustomerId,
c.FirstName,
c.LastName,
c.Email
from Customers c
left join Orders o
on c.CustomerId=o.CustomerId


union

select o.OrderId,
o.OrderDate,
o.TotalAmount, 
c.CustomerId,
c.FirstName,
c.LastName,
c.Email
from Customers c
right join Orders o 
on c.CustomerId=o.CustomerId;

+---------+------------+-------------+------------+-----------+----------+----------------------+
| OrderId | OrderDate  | TotalAmount | CustomerId | FirstName | LastName | Email                |
+---------+------------+-------------+------------+-----------+----------+----------------------+
|     101 | 2023-07-01 |      150.00 |          1 | John      | Doe      | john.doe@email.com   |
|     102 | 2023-07-03 |      200.75 |          2 | Jane      | Smith    | jane.smith@email.com |
+---------+------------+-------------+------------+-----------+----------+----------------------+
2 rows in set


---5)

select DISTINCT
c.CustomerId,
c.FirstName,
c.LastName,
o.TotalAmount
from Customers c
inner join Orders o
on c.CustomerId=o.CustomerId
where o.TotalAmount > (select avg(TotalAmount)
FROM Orders
);

+------------+-----------+----------+-------------+
| CustomerId | FirstName | LastName | TotalAmount |
+------------+-----------+----------+-------------+
|          2 | Jane      | Smith    |      200.75 |
+------------+-----------+----------+-------------+
1 row in set

---6)

select  
EmployeeId,
FirstName,
LastName,
Department,
Salary
from Employees
where 
salary > (select avg(salary) from Employees);

+------------+-----------+----------+------------+--------+
| EmployeeId | FirstName | LastName | Department | Salary |
+------------+-----------+----------+------------+--------+
|          2 | Susan     | Lee      | HR         |  55000 |
+------------+-----------+----------+------------+--------+
1 row in set

---7)

select 
OrderId,
OrderDate,
year(OrderDate) as OrderYear,
month(OrderDate) as OrderMonth
from Orders;

+---------+------------+-----------+------------+
| OrderId | OrderDate  | OrderYear | OrderMonth |
+---------+------------+-----------+------------+
|     101 | 2023-07-01 |      2023 |          7 |
|     102 | 2023-07-03 |      2023 |          7 |
+---------+------------+-----------+------------+
2 rows in set

---8)

select 
OrderId,
OrderDate,
CURDATE() as CurrentDate,
DATEDIFF(CURDATE(),OrderDate)as DaysDifference
from Orders;

+---------+------------+-------------+----------------+
| OrderId | OrderDate  | CurrentDate | DaysDifference |
+---------+------------+-------------+----------------+
|     101 | 2023-07-01 | 2026-10-07  |           1194 |
|     102 | 2023-07-03 | 2026-10-07  |           1192 |
+---------+------------+-------------+----------------+
2 rows in set

---9)

select 
OrderId,
OrderDate,
date_format(OrderDate,"%d-%b-%Y")as formattedorderdate
from Orders;

+---------+------------+--------------------+
| OrderId | OrderDate  | formattedorderdate |
+---------+------------+--------------------+
|     101 | 2023-07-01 | 01-Jul-2023        |
|     102 | 2023-07-03 | 03-Jul-2023        |
+---------+------------+--------------------+
2 rows in set (0.097 sec)

---10)

select 
CustomerId,
concat(FirstName,' ',LastName) as FullName
from Customers;

+------------+------------+
| CustomerId | FullName   |
+------------+------------+
|          1 | John Doe   |
|          2 | Jane Smith |
+------------+------------+
2 rows in set

---11)

select 
CustomerId,
FirstName,
REPLACE(FirstName,'John','Jonathan') as Updatedfirstname
from Customers;

+------------+-----------+------------------+
| CustomerId | FirstName | Updatedfirstname |
+------------+-----------+------------------+
|          1 | John      | Jonathan         |
|          2 | Jane      | Jane             |
+------------+-----------+------------------+
2 rows in set

---12)

select 
CustomerId,
upper(FirstName)as UPPER_Name,
lower(LastName)as LOWER_Name
from Customers;

+------------+------------+------------+
| CustomerId | UPPER_Name | LOWER_Name |
+------------+------------+------------+
|          1 | JOHN       | doe        |
|          2 | JANE       | smith      |
+------------+------------+------------+
2 rows in set

---13)

select 
CustomerId,
Email,
TRIM(Email) as email_field
from Customers;

+------------+----------------------+----------------------+
| CustomerId | Email                | email_field          |
+------------+----------------------+----------------------+
|          1 | john.doe@email.com   | john.doe@email.com   |
|          2 | jane.smith@email.com | jane.smith@email.com |
+------------+----------------------+----------------------+
2 rows in set

---14)

select
OrderId,
OrderDate,
TotalAmount,
SUM(TotalAmount) over(
    ORDER BY OrderDate,OrderId
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
) as RunningTotal
from Orders
ORDER BY OrderDate,OrderId;

+---------+------------+-------------+--------------+
| OrderId | OrderDate  | TotalAmount | RunningTotal |
+---------+------------+-------------+--------------+
|     101 | 2023-07-01 |      150.00 |       150.00 |
|     102 | 2023-07-03 |      200.75 |       350.75 |
+---------+------------+-------------+--------------+
2 rows in set

---15)

sELECT 
    OrderId,  
    OrderDate,
    TotalAmount, 
    RANK() OVER (
        ORDER BY TotalAmount desc
    )  as AmountRank 
FROM Orders;

+---------+------------+-------------+------------+
| OrderId | OrderDate  | TotalAmount | AmountRank |
+---------+------------+-------------+------------+
|     102 | 2023-07-03 |      200.75 |          1 |
|     101 | 2023-07-01 |      150.00 |          2 |
+---------+------------+-------------+------------+
2 rows in set

---16)

select 
OrderId,
TotalAmount,
CASE
    WHEN TotalAmount > 1000 THEN '10% Discount'
    WHEN TotalAmount > 500 THEN '5% Discount'
   ELSE 'NoDiscount'
END as Discount
from Orders;

+---------+-------------+------------+
| OrderId | TotalAmount | Discount   |
+---------+-------------+------------+
|     101 |      150.00 | NoDiscount |
|     102 |      200.75 | NoDiscount |
+---------+-------------+------------+
2 rows in set.

---17)

SELECT 
    EmployeeId,
    FirstName,
    LastName
    Salary,
    CASE
        WHEN Salary >= 55000 THEN 'High'
        WHEN Salary >= 50000 THEN 'Medium'
        ELSE 'Low'
    END AS SalaryCategory
FROM Employees;

+------------+-----------+---------+----------------+
| EmployeeId | FirstName | Salary  | SalaryCategory |
+------------+-----------+---------+----------------+
|          1 | Mark      | Johnson | Medium         |
|          2 | Susan     | Lee     | High           |
+------------+-----------+---------+----------------+
2 rows in set (0.062 sec)
