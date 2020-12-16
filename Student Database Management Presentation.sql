-- Create and use database
create database PVFC;
use PVFC;

-- Create Product table
create table Product_t
(ProductID integer not null,
ProductDescription varchar(50),
ProductFinish varchar(20)
check (ProductFinish in ('Cherry', 'Natural Ash', 'White Ash', 'Red Oak', 'Natural Oak', 'Walnut')),
ProductStandardPrice decimal(6,2),
ProductLineID integer,
constraint Product_PK primary key (ProductID));

-- Create Customer table
create table Customer_t
(CustomerID integer not null,
CustomerName varchar(25) not null,
CustomerAddress varchar(30),
CustomerCity varchar(20),
CustomerState char(2),
CustomerPostalCode varchar(9),
constraint Customer_PK primary key (CustomerID));

-- Create Order table
create table Order_t
(OrderID integer not null,
OrderDate date,
CustomerID integer,
constraint Order_PK primary key (OrderID),
constraint Order_FK foreign key (CustomerID) references Customer_t(CustomerID));

-- Create OrderLine table
create table OrderLine_t
(OrderID integer not null,
ProductID integer not null,
OrderedQuantity integer,
constraint OrderLine_PK primary key (OrderID, ProductID),
constraint OrderLine_FK1 foreign key (OrderID) references Order_t(OrderID),
constraint OrderLine_FK2 foreign key (ProductID) references Product_t(ProductID));

-- Insert into table
insert into Customer_t values
(1,'Contemporary Casuals','1355 S Hines Blvd','Gainesville','FL','326012871'),
(2,'Value Furniture','15145 S.W. 17th St.','Plano','TX','750947743'),
(3,'Home Furnishings','1900 Allard Ave.','Albany','NY','122091125'),
(4,'Eastern Furniture','1925 Beltline Rd.','Carteret','NJ','070083188'),
(5,'Impressions','5585 Westcott Ct.','Sacramento','CA','942064056'),
(6,'Furniture Gallery','325 Flatiron Dr.','Boulder','CO','805144432'),
(7,'Period Furniture','394 Rainbow Dr.','Seattle','WA','979545589'),
(8,'Calfornia Classics','816 Peach Rd.','Santa Clara','CA','969157754'),
(9,'M and H Casual Furniture','3709 First Street','Clearwater','FL','346202314'),
(10,'Seminole Interiors','2400 Rocky Point Dr.','Seminole','FL','346464423'),
(11,'American Euro Lifestyles','2424 Missouri Ave N.','Prospect Park','NJ','075085621'),
(12,'Battle Creek Furniture','345 Capitol Ave. SW','Battle Creek','MI','490153401'),
(13,'Heritage Furnishings','66789 College Ave.','Carlisle','PA','170138834'),
(14,'Kaneohe Homes','112 Kiowai St.','Kaneohe','HI','967442537'),
(15,'Mountain Scenes','4132 Main Street','Ogden','UT','844034432');

insert into Product_t values
(1,'End Table','Cherry',$175.00,1),
(2,'Coffe Table','Natural Ash',$200.00,2),
(3,'Computer Desk','Natural Ash',$375.00,2),
(4,'Entertainment Center','Natural Oak',$650.00,3),
(5,'Writers Desk','Cherry',$325.00,1),
(6,'8-Drawer Desk','White Ash',$750.00,2),
(7,'Dining Table','Natural Ash',$800.00,2),
(8,'Computer Desk','Walnut',$250.00,3);

insert into Order_t values
(1001,'10-21-2008',1),
(1002,'10-21-2008',8),
(1003,'10-22-2008',15),
(1004,'10-22-2008',5),
(1005,'10-24-2008',3),
(1006,'10-24-2008',2),
(1007,'10-27-2008',11),
(1008,'10-30-2008',12),
(1009,'11-5-2008',4),
(1010,'11-5-2008',1);

insert into OrderLine_t values
(1001,1,2),
(1001,2,2),
(1001,4,1),
(1002,3,5),
(1003,3,3),
(1004,6,2),
(1004,8,2),
(1005,4,4),
(1006,4,1),
(1006,5,2),
(1006,7,2),
(1007,1,3),
(1007,2,2),
(1008,3,3),
(1008,8,3),
(1009,4,2),
(1009,7,3),
(1010,8,10);

--Insert multiple rows of data from another table
--Step 1. Create CACustmer table with same schema as Customer table.
create table CACustomer_t
(CustomerID integer not null,
CustomerName varchar(25) not null,
CustomerAddress varchar(30),
CustomerCity varchar(20),
CustomerState char(2),
CustomerPostalCode varchar(9),
constraint CACustomer_PK primary key (CustomerID));

--Step 2. Insert customer data who are residing in CA in CACustmer from Customer table
insert into CACustomer_t
select * from Customer_t
where CustomerState = 'CA';

--Use UPDATE to alter values of a field
update product_t
set ProductStandardPrice = ProductStandardPrice * 1.1
where ProductID = 8;

--Use comparison operators =, <, >, <=, >=, <>, !=
select ProductDescription, ProductStandardPrice
from Product_t
where ProductStandardPrice <275;

--Use IN to select a range
select CustomerName, CustomerState
from CUSTOMER_t
where CustomerState in ('FL', 'TX', 'CA');

--Use * to select all
select * 
from Customer_t
where CustomerState <> 'TX';

--Use wildcard % to find any sequence of characters
select ProductDescription, ProductStandardPrice
from Product_t
where ProductDescription like '%Desk';

--Use wildcard _ to find exactly one character
select CustomerID, CustomerState
from Customer_t
where CustomerState not like 'N_';

--Boolean operators OR, AND with LIKE/NOT LIKE
select ProductDescription, ProductFinish, ProductStandardPrice
from Product_t
where ProductDescription like '%Desk'
or ProductDescription like '%Table'
and ProductStandardPrice > 300;

--Use Paranthesis () to override the normal precedence of boolean operators
select ProductDescription, ProductFinish, ProductStandardPrice
from Product_t
where (ProductDescription like '%Desk'
or ProductDescription like '%Table')
and ProductStandardPrice > 300;

--Use BETWEEN...AND to select a range
select OrderID, OrderDate
from Order_t
where OrderDate between '2008-10-24' and '2008-10-30';

-- Use IS NULL to check empty fileds
select * from Customer_t
where CustomerState is null;

-- Create alias with AS
select ProductDescription, ProductStandardPrice, ProductStandardPrice * 0.9 as DiscountPrice
from Product_t
where ProductDescription like '%Desk';

-- Aggregate functions: COUNT, SUM, MAX, MIN, AVG
select count(*) as TotalNumber
from OrderLine_t
where OrderID = 1004;

SELECT COUNT(ProductID) AS TotalNumber 
   FROM ORDERLINE_T;

SELECT COUNT(Distinct ProductID) AS TotalNumber 
   FROM ORDERLINE_T;

SELECT SUM(OrderedQuantity) AS SumTotal 
   FROM ORDERLINE_T
   WHERE OrderID = 1004;

SELECT AVG(OrderedQuantity) AS AvgNumber 
   FROM ORDERLINE_T;

SELECT MAX(OrderedQuantity) AS MAXNumber 
   FROM ORDERLINE_T;

--Use ORDER BY to sort the result
SELECT CustomerName, CustomerState
        FROM CUSTOMER_T
	    WHERE CustomerState IN ('FL', 'TX', 'CA')
		ORDER BY CustomerState, CustomerName;

SELECT CustomerName, CustomerState
        FROM CUSTOMER_T
	    WHERE CustomerState IN ('FL', 'TX', 'CA')
		ORDER BY CustomerState, CustomerName DESC;

--Use GROUP BY to categorize the result
SELECT CustomerState, COUNT(CustomerState) AS Total
        FROM CUSTOMER_T
		GROUP BY CustomerState;

--Use HAVING in the GROUP BY clause to meet a criterion in the group
SELECT CustomerState, COUNT(CustomerState) AS Total
        FROM CUSTOMER_T
		GROUP BY CustomerState
		HAVING COUNT(CustomerState) > 1;

--Create VIEW
CREATE VIEW [Products Above Average Price] AS
SELECT ProductDescription, ProductStandardPrice
FROM Product_t
WHERE ProductStandardPrice > (SELECT AVG(ProductStandardPrice) FROM Product_t);

--Inner Join
SELECT Customer_T.CustomerID, CustomerName, OrderID
FROM Customer_T , Order_T
WHERE Customer_T.CustomerID = Order_T.CustomerID
ORDER BY ORDER_t.OrderID;

--Inner Join without WHERE clause
SELECT Customer_T.CustomerID, CustomerName, OrderID
FROM Customer_T , Order_T
ORDER BY ORDER_t.OrderID;

--Inner Join...On
SELECT Customer_T.CustomerID, CustomerName, OrderID
FROM Customer_T INNER JOIN Order_T ON
 Customer_T.CustomerID = Order_T.CustomerID
ORDER BY ORDER_t.OrderID;

--Left Outer Join
SELECT Customer_T.CustomerID, CustomerName, OrderID
FROM Customer_T LEFT OUTER JOIN Order_T ON
 Customer_T.CustomerID = Order_T.CustomerID;

--Right Outer Join
SELECT Customer_T.CustomerID, CustomerName, OrderID
FROM Customer_T RIGHT OUTER JOIN Order_T ON
 Customer_T.CustomerID = Order_T.CustomerID;

--Full Outer Join
SELECT Customer_T.CustomerID, CustomerName, OrderID
FROM Customer_T FULL OUTER JOIN Order_T ON
 Customer_T.CustomerID = Order_T.CustomerID;

--Join with AND clause
SELECT CustomerName, CustomerAddress, CustomerCity, CustomerState, CustomerPostalCode
FROM Customer_T, Order_T
WHERE Customer_T.CustomerID = Order_T.CustomerID AND OrderID = 1008;

--Join with multiple tables
SELECT Customer_t.CustomerID, CustomerName, Order_t.OrderID, OrderDate, OrderedQuantity, ProductDescription, ProductStandardPrice, (OrderedQuantity*ProductStandardPrice) AS 'Total Sales'
FROM Customer_t, Order_t, Product_t, OrderLine_t
WHERE Customer_t.CustomerID = Order_t.CustomerID
AND Order_t.OrderID = OrderLine_t.OrderID
AND OrderLine_t.ProductID = Product_t.ProductID
AND Order_t.OrderID = 1006;

--Subquery
SELECT CustomerName, CustomerAddress, CustomerCity, CustomerState, CustomerPostalCode
FROM Customer_T
WHERE CustomerID = 
(SELECT CustomerID FROM Order_T WHERE OrderID = 1008);
select
--Subquery using IN operator
SELECT CustomerName, CustomerAddress, CustomerCity, CustomerState, CustomerPostalCode
FROM Customer_T
WHERE CustomerID IN 
(SELECT CustomerID FROM Order_T);

--Subquery using NOT IN operator
SELECT CustomerID, CustomerName, CustomerAddress, CustomerCity, CustomerState, CustomerPostalCode
FROM Customer_T
WHERE CustomerID NOT IN 
(SELECT CustomerID FROM Order_T, OrderLine_t, Product_t
	WHERE Order_t.OrderID = OrderLine_t.OrderID
	AND OrderLine_t.ProductID = Product_t.ProductID
	AND ProductDescription = 'Computer Desk'
);

--Subquery using > operator
SELECT ProductDescription, ProductStandardPrice
FROM Product_t
WHERE ProductStandardPrice > 
(SELECT AVG(ProductStandardPrice) FROM Product_t);

--Subquery using Derived Tables
SELECT ProductDescription, ProductStandardPrice, AvgPrice
FROM
(SELECT AVG(ProductStandardPrice) FROM Product_t) Derived_t (AvgPrice), Product_t
WHERE ProductStandardPrice > AvgPrice;

--Practice queries
update Order_t
set OrderDate = '10-21-2008'
where OrderID = 1004;

select OrderID, OrderedQuantity
from OrderLine_t
where ProductID = 4;

select *
from OrderLine_t
where OrderedQuantity IN (1, 3, 5);

select ProductID, ProductDescription, ProductFinish
from Product_t
where ProductFinish like '%Ash';

select *
from Order_t
where CustomerID <> 1;

select *
from Order_t
where CustomerID = 1
or OrderDate > '10-22-2008';

select *
from Order_t
where CustomerID not in (1,3,5)
and OrderDate > '10-24-2008';

select * from OrderLine_t
where OrderedQuantity between 3 and 5;

select count(ProductID) as [More than 375]
from Product_t
where ProductStandardPrice > 375;

select avg(ProductStandardPrice) as [Avg price]
from Product_t

select * from OrderLine_t
order by ProductID, OrderedQuantity desc;

select ProductID, sum(OrderedQuantity) as [Total Ordered]
from OrderLine_t
group by ProductID;

select OrderID, count(OrderedQuantity) as [Total Ordered]
from OrderLine_t
group by OrderID
having count(OrderedQuantity)>1;

--Number of products ordered in each order
select OrderID, count(ProductID) as 'Products Ordered'
from OrderLine_t
group by OrderID;

--Customers who submitted more than one order
select CustomerID, count(OrderID) as [Total Orders]
from Order_t
group by CustomerID
having count(OrderID) >1;

--Joins and Subqueries
--1.	Display ProductID, Description, OrderID, and Ordered Quantity. Sort by ProductID
select Product_t.ProductID, ProductDescription, OrderID, OrderedQuantity
from Product_t, OrderLine_t
where Product_t.ProductID = OrderLine_t.ProductID
Order by ProductID;

--2.	Display the CustmerID and the sum of total quantity ordered by each customer. Name the sum as ‘Total Quantity’
select Customer_t.CustomerID, sum(OrderedQuantity) as 'Total Quantity'
from Customer_t, OrderLine_t, Order_t
where Customer_t.CustomerID = Order_t.CustomerID
and Order_t.OrderID = OrderLine_t.OrderID
Group by Customer_t.CustomerID;

--3.	Display the CustmerID and the total amount spend by each customer. Name the sum as ‘Total Value’
select CustomerID, sum(OrderedQuantity*ProductStandardPrice) as 'Total Value'
from OrderLine_t, Order_t, Product_t
where Order_t.OrderID = OrderLine_t.OrderID
and OrderLine_t.ProductID = Product_t.ProductID
Group by CustomerID;

--4.	Display the ProductID and the number of customers who purchased that product.
select ProductID, count(CustomerID) as [Total Customers]
from OrderLine_t, Order_t
where Order_t.OrderID = OrderLine_t.OrderID
Group by ProductID;

--5.	Display the CustomerID, and name of all customers who submitted more than 1 order.
SELECT CustomerID, CustomerName
FROM Customer_t
WHERE CustomerID in 
(SELECT Order_t.CustomerID from Order_t
group by Order_t.CustomerID
having count(OrderID) > 1);

--6.	Display the ProductID, product description, and standard price for all products which are part of more than 2 orders.
SELECT ProductID, ProductDescription, ProductStandardPrice
FROM Product_t
WHERE ProductID in 
(SELECT ProductID from OrderLine_t
group by ProductID
having count(ProductID) > 2);

--7.	Display the OrderID and OrderDate of the orders which does not contain product with product finish ‘Ash’.
SELECT OrderID, OrderDate
FROM Order_t
WHERE OrderID NOT IN
(SELECT OrderID
	FROM OrderLine_t, Product_t
	WHERE OrderLine_t.ProductID = Product_t.ProductID
	AND ProductFinish LIKE '%Ash');

--8.	Display OrderID, Ordered quantity, and average quantity for all orders with ordered quantity more than the average.
SELECT DISTINCT OrderID, OrderedQuantity, AvgQty
FROM OrderLine_t,
(SELECT AVG(OrderedQuantity) FROM OrderLine_t) Temp_t (AvgQty)
WHERE OrderedQuantity - AvgQty > 0;

--9.	Display the OrderID, OrderDate of the order which has the maximum ordered quantity. Your query should also display the Maximum ordered quantity.
select Order_t.OrderID, OrderDate, sum(OrderedQuantity) as 'Max Quantity Ordered'
from Order_t, OrderLine_t
where OrderLine_t.OrderID = Order_t.OrderID
group by Order_t.OrderID, OrderDate
Having sum(OrderedQuantity) =
(select Max(TotalQuantity)
FROM
(select sum(OrderedQuantity) from OrderLine_t
group by OrderID) Temp_t (TotalQuantity));

