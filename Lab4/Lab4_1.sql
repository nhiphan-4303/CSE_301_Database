create database SaleManagement;
use SaleManagement;

create table clients(
	Client_Number varchar(10),
    Client_Name varchar(25) not null,
    Address varchar(30),
    City varchar(30),
    Pincode int not null,
    Province char(25),
    Amount_Paid decimal(15,4),
    Amount_Due decimal(15,4),
    check(Client_Number like 'C%'),
    primary key(Client_Number)
);

create table product(
	Product_Number varchar(15),
    Product_Name varchar(25) not null unique,
    Quantity_On_Hand int not null,
    Quantity_Sell int not null,
    Sell_Price decimal(15,4) not null,
    Cost_Price decimal(15,4) not null,
    check(Product_Number like 'P%'),
    check(Cost_Price<>0),
    primary key(Product_Number)
);

create table Salesman(
	Salesman_Number varchar(15),
    Salesman_Name varchar(25) not null,
    Address varchar(30),
    City varchar(30),
    Pincode int not null,
    Province char(25) default('Viet Nam'),
    Salary decimal(15,4) not null,
    Sales_Target int not null,
    Target_Achieved int,
    Phone char(10) not null unique,
    check(Salesman_Number like 'S%'),
    check(Salary<>0),
    check(Sales_Target<>0),
    primary key(Salesman_Number)
);

create table SalesOrder(
	Order_Number varchar(15),
    Order_Date date,
    Client_Number varchar(15),
    Salesman_Number varchar(15),
    Delivery_Status char(15),
    Delivery_Date date,
    Order_Status varchar(15),
    primary key (Order_Number),
    foreign key (Client_Number) references clients(Client_Number),
    foreign key (Salesman_Number) references salesman(Salesman_Number),
    check (Order_Number like 'O%'),
    check (Client_Number like 'C%'),
    check (Salesman_Number like 'S%'),
    check (Delivery_Status in ('Delivered', 'On Way', 'Ready to Ship')),
    check (Delivery_Date>Order_Date),
    check (Order_Status in ('In Process', 'Successful', 'Cancelled'))
);

create table SalesOrderDetails(
	Order_Number varchar(15),
    Product_Number varchar(15),
    Order_Quantity int,
    Discount_Rate int,
    check (order_number like 'O%'),
    check (Product_Number like 'P%'),
    foreign key (Order_Number)
    references salesorder(Order_Number),
    foreign key (Product_Number)
    references product (Product_Number)
);

INSERT INTO `clients`(`Client_Number`, `Client_Name`, `Address`, `City`, `Pincode`, `Province`, `Amount_Paid`, `Amount_Due`) VALUES
('C101','Mai Xuan','Phu Hoa','Dai An',700001,'Binh Duong',10000,5000),
('C102','Le Xuan','Phu Hoa','Thu Dau Mot',700051,'Binh Duong',18000,3000),
('C103','Trinh Huu','Phu Loi','Da Lat',700051,'Lam Dong ',7000,3200),
('C104','Tran Tuan','Phu Tan','Thu Dau Mot',700080,'Binh Duong',8000,0),
('C105','Ho Nhu','Chanh My','Hanoi',700005,'Hanoi',7000,150),
('C106','Tran Hai','Phu Hoa','Ho Chi Minh',700002,'Ho Chi Minh',7000,1300),
('C107','Nguyen Thanh','Hoa Phu','Dai An',700023,'Binh Duong',8500,7500),
('C108','Nguyen Sy','Tan An','Da Lat',700032,'Lam Dong ',15000,1000),
('C109','Duong Thanh','Phu Hoa','Ho Chi Minh',700011,'Ho Chi Minh',12000,8000),
('C110','Tran Minh','Phu My','Hanoi',700005,'Hanoi',9000,1000);

INSERT INTO `product`(`Product_Number`, `Product_Name`, `Quantity_On_Hand`, `Quantity_Sell`, `Sell_Price`, `Cost_Price`) VALUES
('P1001','TV',10,30,1000,800),
('P1002','Laptop',12,25,1500,1100),
('P1003','AC',23,10,400,300),
('P1004','Modem',22,16,250,230),
('P1005','Pen',19,13,12,8),
('P1006','Mouse',5,10,100,105),
('P1007','Keyboard',45,60,120,90),
('P1008','Headset',63,75,50,40);

INSERT INTO `salesman` VALUES
('S001','Huu','Phu Tan','Ho Chi Minh',700002,'Ho Chi Minh',15000,50,35,'0902361123'),
('S002','Phat','Tan An','Hanoi',700005,'Hanoi',25000,100,110,'0903216542'),
('S003','Khoa','Phu Hoa','Thu Dau Mot',700051,'Binh Duong',17500,40,30,'0904589632'),
('S004','Tien','Phu Hoa','Dai An',700023,'Binh Duong',16500,70,72,'0908654723'),
('S005','Deb','Hoa Phu','Thu Dau Mot',700051,'Binh Duong',13500,60,48,'0903213659'),
('S006','Tin','Chanh My','Da Lat',700032,'Lam Dong',20000,80,55,'0907853497');

INSERT INTO `SalesOrder` VALUES
('O20001','2022-01-15','C101','S003','Delivered','2022-02-10','Successful'),
('O20002','2022-01-25','C102','S003','Delivered','2022-02-15','Cancelled'),
('O20003','2022-01-31','C103','S002','Delivered','2022-04-03','Successful'),
('O20004','2022-02-10','C104','S003','Delivered','2022-04-23','Successful'),
('O20005','2022-02-18','C101','S003','On Way',null,'Cancelled'),
('O20006','2022-02-22','C105','S005','Ready to Ship',null,'In Process'),
('O20007','2022-04-03','C106','S001','Delivered','2022-05-08','Successful'),
('O20008','2022-04-16','C102','S006','Ready to Ship',null,'In Process'),
('O20009','2022-04-24','C101','S004','On Way',null,'Successful'),
('O20010','2022-04-29','C106','S006','Delivered','2022-05-08','Successful'),
('O20011','2022-05-08','C107','S005','Ready to Ship',null,'Cancelled'),
('O20012','2022-05-12','C108','S004','On Way',null,'Successful'),
('O20013','2022-05-16','C109','S001','Ready to Ship',null,'In Process'),
('O20014','2022-05-16','C110','S001','On Way',null,'Successful');

INSERT INTO `SalesOrderDetails` VALUES
('O20001','P1001',5),
('O20001','P1002',4),
('O20002','P1007',10),
('O20003','P1003',12),
('O20004','P1004',3),
('O20005','P1001',8),
('O20005','P1008',15),
('O20005','P1002',14),
('O20006','P1002',5),
('O20007','P1005',6),
('O20008','P1004',8),
('O20009','P1008',2),
('O20010','P1006',11),
('O20010','P1001',9),
('O20011','P1007',6),
('O20012','P1005',3),
('O20012','P1001',2),
('O20013','P1006',10),
('O20014','P1002',20);

ALTER TABLE SalesOrderDetails
DROP COLUMN Discount_Rate;

show tables;

-- 1.	Show the all-clients details who lives in “Binh Duong”.
select *
from clients 
where province like 'Binh Duong';

-- 2.	Find the client’s number and client’s name who do not live in “Hanoi”.
select Client_Number, Client_Name
from clients
where province <> 'Ha Noi';

-- 3.	Identify the names of all products with less than 25 in stock.
select *
from product
where Quantity_On_hand < 25;

-- 4.	Find the product names where company making losses. 
select Product_Name
from product
where Sell_Price < Cost_Price;

-- 5.	Find the salesman’s details who are able achieved their target.
select *
from salesman
where Target_Achieved >= Sales_Target;

-- 6.	Select the names and city of salesman who are not received salary between 10000 and 17000.
select Salesman_Name, City
from salesman
where salary not between 10000 and 17000;

-- 7.	Show order date and the clients_number of who bought the product between '2022-01-01' and '2022-02-15'.
select Order_Date, Client_Number
from salesorder
where Order_Date between '2022-01-01' and '2022-02-15';

-- 8.	Find the names of cities in clients table where city name starts with "N"
select *
from clients 
where City like 'N%';

-- 9.	Display clients’ information whose names have "u" in third position.
select *
from clients 
where client_name like '__u%';

-- 10.	Find the details of clients whose names have "u" in second last position.
select *
from clients 
where client_name like '%u_';

-- 11.	Find the names of cities in clients table where city name starts with "D" and ends with “n”.
select City
from clients
where City like 'D%n';

-- 12.	Select all clients details who belongs from Ho Chi Minh, Hanoi and Da Lat.
select *
from clients
where City in ('Ho Chi Minh', 'Hanoi','Da Lat');

-- 13.	Choose all clients data who do not reside in Ho Chi Minh, Hanoi and Da Lat.
select *
from clients
where City not in ('Ho Chi Minh', 'Hanoi','Da Lat');

-- 14.	Find the average salesman’s salary.
select AVG(salary) 
as average_salary
from salesman;

-- 15.	Find the name of the highest paid salesman.
-- Cách 1
select Salesman_Name
from salesman
where salary in (select max(salary) from salesman);

-- Cách 2
select Salesman_Name
from salesman
order by salary desc
limit 1;

-- 16.	Find the name of the salesman who is paid the lowest salary.
-- Cach 1
select Salesman_Name
from salesman
where salary in (select min(salary) from salesman);

-- Cach 2
select Salesman_Name
from salesman
order by salary asc
limit 1;

-- 17.	Determine the total number of salespeople employed by the company.
select COUNT(Salesman_Number)
as number_of_salespeople
from salesman;

-- 18.	Compute the total salary paid to the company's salesman.
select SUM(salary)
as sum_of_salary
from salesman;

-- 19.	Select the salesman’s details sorted by their salary.
select * 
from salesman
order by salary ASC;

-- 20.	Display salesman names and phone numbers based on their target achieved (in ascending order) and their city (in descending order).
select Salesman_Name, Phone
from salesman
order by Target_Achieved ASC, city DESC;

-- 21.	Display 3 first names of the salesman table and the salesman’s names in descending order.
SELECT salesman_name
FROM Salesman
ORDER BY salesman_name DESC
limit 3;

-- 22.	Find salary and the salesman’s names who is getting the highest salary.
select salary, salesman_name
from salesman
where salary in (select max(salary) from salesman)
order by salary desc
limit 1;

-- 23.	Find salary and the salesman’s names who is getting second lowest salary.
select salary, salesman_name
from salesman
order by salary asc
limit 1,1;

-- 24.	Display the first five sales orders information from the sales order table.
SELECT *
FROM Salesorder
ORDER BY order_number
limit 10;

-- 25.	Display next ten sales order information from sales order table except first five sales order.
SELECT *
FROM Salesorder
ORDER BY order_number
limit 5,10;

-- 26.	If there are more than one client, find the name of the province and the number of clients in each province, ordered high to low.
select Province, count(Province) as Quantity_Province
from clients 
group by Province
having count(Province)>1
order by Quantity_Province desc;

-- 27.	Display information clients have number of sales order more than 1.
select * 
from salesorder;
select *
from clients
where Client_Number in (select Client_Number
						from salesorder
						group by Client_Number
						having count(Client_Number)>1);
                        
select Clients.*
from clients, salesorder
where clients.Client_Number = salesorder.Client_Number
group by clients.Client_Number
having count(clients.Client_Number)>1;
                        
select Clients.*
from clients natural join salesorder
group by Client_Number
having count(Client_Number)>1;
-- ----------------------------------------------------------------------------------------------------------------------------

-- 28. Display the name and due amount of those clients who lives in “Hanoi”.
SELECT Client_Name, Amount_Due
FROM clients
WHERE City = 'Hanoi';

-- 29.	Find the clients details who has due more than 3000.
SELECT * 
FROM clients
WHERE Amount_Due > 3000;

-- 30.	Find the clients name and their province who has no due.
SELECT Client_Name, Province
FROM clients
WHERE Amount_Due = 0;

-- 31.	Show details of all clients paying between 10,000 and 13,000.
SELECT *
FROM clients
WHERE Amount_Paid BETWEEN 10000 AND 13000;

-- 32.	Find the details of clients whose name is “Dat”.
SELECT *
FROM clients
WHERE Client_Name = 'Dat';

-- 33.	Display all product name and their corresponding selling price.
SELECT Product_Name, Sell_Price
FROM product;

-- 34.	How many TVs are in stock?
SELECT Quantity_On_Hand
FROM product
WHERE Product_Name = 'TV';

-- 35.	Find the salesman’s details who are not able achieved their target.
SELECT *
FROM Salesman
WHERE Target_Achieved < Sales_Target;

-- 36.	Show all the product details of product number ‘P1005’.
SELECT *
FROM product
WHERE Product_Number = 'P1005';

-- 37.	Find the buying price and sell price of a Mouse.
SELECT Cost_Price, Sell_Price
FROM product
WHERE Product_Name = 'Mouse';

-- 38.	Find the salesman names and phone numbers who lives in Thu Dau Mot.
SELECT Salesman_Name, Phone
FROM Salesman
WHERE City = 'Thu Dau Mot';

-- 39.	Find all the salesman’s name and salary.
SELECT Salesman_Name, Salary
FROM Salesman;

-- 40.	Select the names and salary of salesman who are received between 10000 and 17000.
SELECT Salesman_Name, Salary
FROM Salesman
WHERE Salary BETWEEN 10000 AND 17000;

-- 41.	Display all salesman details who are received salary between 10000 and 20000 and achieved their target. 
SELECT *
FROM Salesman
WHERE Salary BETWEEN 10000 AND 20000
AND Target_Achieved >= Sales_Target;

-- 42.	Display all salesman details who are received salary between 20000 and 30000 and not achieved their target.
SELECT *
FROM Salesman
WHERE Salary BETWEEN 20000 AND 30000
AND Target_Achieved < Sales_Target;
 
-- 43.	Find information about all clients whose names do not end with "h".
SELECT *
FROM clients
WHERE Client_Name NOT LIKE '%h';

-- 44.	Find client names whose second letter is 'r' or second last letter 'a'.
select Client_Name
from clients
where Client_Name like '_r%' 
or Client_Name like '%a_';

-- 45.	Select all clients where the city name starts with "D" and at least 3 characters in length.
select *
from clients 
where City like 'D___%';

-- 46.	Select the salesman name, salaries and target achieved sorted by their target_achieved in descending order.
SELECT Salesman_Name, Salary, Target_Achieved
FROM salesman
ORDER BY Target_Achieved DESC;

-- 47.	Select the salesman’s details sorted by their sales_target and target_achieved in ascending order.
SELECT *
FROM Salesman
ORDER BY Sales_Target ASC, Target_Achieved ASC;

-- 48.	Select the salesman’s details sorted ascending by their salary and descending by achieved target.
SELECT *
FROM Salesman
ORDER BY Salary ASC, Target_Achieved DESC;

-- 49.	Display salesman names and phone numbers in descending order based on their sales target.
SELECT Salesman_Name, Phone
FROM Salesman
ORDER BY Sales_Target DESC;

-- 50.	Display the product name, cost price, and sell price sorted by quantity in hand.
SELECT Product_Name, Cost_Price, Sell_Price
FROM product
ORDER BY Quantity_On_Hand;

-- 51.	Retrieve the clients’ names in ascending order.
SELECT Client_Name
FROM clients
ORDER BY Client_Name ASC;

-- 52.	Display client information based on order by their city.
SELECT *
FROM clients
ORDER BY City;

-- 53.	Display client information based on order by their address and city.
SELECT *
FROM clients
ORDER BY Address, City; 

-- 54.	Display client information based on their city, sorted high to low based on amount due.
SELECT *
FROM clients
ORDER BY City, Amount_Due DESC;

-- 55.	Display the data of sales orders depending on their delivery status from the current date to the old date.
SELECT *
FROM SalesOrder
ORDER BY Delivery_Date DESC;

-- 56.	Display last five sales order information from sales order table.
SELECT *
FROM SalesOrder
ORDER BY Order_Number DESC
LIMIT 5;

-- 57.	Count the pincode in client table.
SELECT COUNT(DISTINCT Pincode)
AS Number_Of_Pincode
FROM clients;

-- 58.	How many clients are living in Binh Duong?
SELECT COUNT(*) 
AS Binh_Duong_Clients
FROM clients
WHERE Province like 'Binh Duong';

-- 59.	Count the clients for each province.
SELECT Province, COUNT(*)
AS Number_Of_Clients
FROM clients
GROUP BY Province;

-- 60.	If there are more than three clients, find the name of the province and the number of clients in each province.
SELECT Province, COUNT(*)
AS Number_Of_Clients
FROM clients
GROUP BY Province
HAVING COUNT(*) > 3;

-- 61.	Display product number and product name and count number orders of each product more than 1 (in ascending order).
SELECT p.Product_Number, p.Product_Name, COUNT(so.Order_Number)
AS Order_Count
FROM product p
JOIN SalesOrderDetails so ON p.Product_Number = so.Product_Number
GROUP BY p.Product_Number, p.Product_Name
HAVING COUNT(so.Order_Number) > 1
ORDER BY Order_Count ASC;

-- 62.	Find products which have more quantity on hand than 20 and less than average of quantity on hand.
SELECT *
FROM product
WHERE Quantity_On_Hand > 20 
AND Quantity_On_Hand < (SELECT AVG(Quantity_On_Hand) FROM product);



