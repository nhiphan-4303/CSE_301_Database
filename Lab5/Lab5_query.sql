use SaleManagement;

SELECT *
FROM Clients NATURAL JOIN Salesorder;

SELECT c.*, s.*
FROM Clients c INNER JOIN Salesorder s ON c.client_number = s.client_number;

select distinct c.Client_Name, s.Salesman_Name, c.city, s.city
from clients c inner join salesman s on c.city = s.city;

-- 1.	Display the clients (name) who lives in same city.
SELECT DISTINCT LEAST(c1.client_name, c2.client_name) AS Client1,
                GREATEST(c1.client_name, c2.client_name) AS Client2,
                c1.City
FROM clients c1
JOIN clients c2 ON c1.city = c2.city AND c1.client_name < c2.client_name
ORDER BY c1.city, Client1, Client2;

-- 2.	Display city, the client names and salesman names who are lives in “Thu Dau Mot” city.
SELECT DISTINCT c.Client_Name, s.Salesman_Name, c.City
FROM clients c
INNER JOIN Salesman s ON c.City = s.City
WHERE c.City = 'Thu Dau Mot';

-- 3.	Display client name, client number, order number, salesman number, and product number for each order.
SELECT c.Client_Name, c.Client_Number, so.Order_Number, so.Salesman_Number, sod.Product_Number
FROM clients c
INNER JOIN SalesOrder so ON c.Client_Number = so.Client_Number
INNER JOIN SalesOrderDetails sod ON so.Order_Number = sod.Order_Number;

-- 4.	Find each order (client_number, client_name, order_number) placed by each client.
select client_number, client_name, order_number
from clients natural join salesorder;
 
-- 5.	Display the details of clients (client_number, client_name) and the number of orders which is paid by them.
select c.Client_Number, c.Client_Name, count(so.order_number) as NumberOfOrder
FROM clients c JOIN salesorder so ON c.Client_Number = so.Client_Number
group by c.client_number
having count(so.order_number);

-- 6.	Display the details of clients (client_number, client_name) who have paid for more than 2 orders.
SELECT c.Client_Number, c.Client_Name, COUNT(so.Order_Number) AS Number_of_Orders
FROM clients c
JOIN SalesOrder so ON c.Client_Number = so.Client_Number
GROUP BY c.Client_Number, c.Client_Name
HAVING COUNT(so.Order_Number) > 2;

-- 7.	Display details of clients who have paid for more than 1 order in descending order of client_number.
SELECT c.*, COUNT(so.Order_Number) AS Number_of_Orders
FROM clients c
JOIN SalesOrder so ON c.Client_Number = so.Client_Number
GROUP BY c.Client_Number, c.Client_Name
HAVING COUNT(so.Order_Number) > 1
ORDER BY c.Client_Number DESC;

-- 8.	Find the salesman names who sells more than 20 products.
select s.Salesman_Name
from salesman s inner join salesorder so on s.Salesman_Number = so.Salesman_Number
inner join salesorderdetails sod on so.Order_Number = sod.Order_Number
group by s.Salesman_Name
having SUM(sod.Order_Quantity)>20;

-- 9.	Display the client information (client_number, client_name) and order number of those clients who have order status is cancelled.
select c.Client_Number, c.Client_Name, so.Order_Number, so.Order_Status
from clients c
join salesorder so on c.Client_Number = so.Client_Number
where so.Order_Status = 'Cancelled';

-- 10.	Display client name, client number of clients C101 and count the number of orders which were received “successful”.
SELECT c.client_number, c.client_name, count(so.Order_Status)
FROM clients c
JOIN salesorder so ON c.Client_Number = so.Client_Number
WHERE so.Order_Status = 'successful' and c.Client_Number = 'C101';

-- 11.	Count the number of clients orders placed for each product.
SELECT p.Product_Number, p.Product_Name, COUNT(p.Product_Number)
FROM product p
INNER JOIN SalesOrderDetails sod ON sod.Product_Number = p.Product_Number
GROUP BY p.Product_Number;

-- 12.	Find product numbers that were ordered by more than two clients then order in descending by product number.
SELECT p.Product_Number, p.Product_Name, COUNT(p.Product_Number)
FROM product p
INNER JOIN SalesOrderDetails sod ON sod.Product_Number = p.Product_Number
GROUP BY p.Product_Number, p.Product_Name
HAVING COUNT(p.Product_Number) > 2
ORDER BY p.Product_Number DESC;

-- 13.	Find the salesman’s names who is getting the second highest salary.
select Salesman_Name
from salesman
where salary = (select distinct salary
				from salesman
				order by salary desc
				limit 1,1);
                
-- 14.	Find the salesman’s names who is getting second lowest salary.
SELECT Salesman_Name
FROM Salesman
WHERE Salary = (
    SELECT DISTINCT Salary
    FROM Salesman
    ORDER BY Salary ASC
    LIMIT 1,1
);

-- 15.	Write a query to find the name and the salary of the salesman who have a higher salary than the salesman whose salesman number is S001.
SELECT Salesman_Name, Salary
FROM Salesman
WHERE Salary > (SELECT Salary FROM Salesman WHERE Salesman_Number = 'S001');

-- 16.	Write a query to find the name of all salesman who sold the product has number: P1002.
SELECT DISTINCT s.Salesman_Name
FROM Salesman s
JOIN SalesOrder so ON s.Salesman_Number = so.Salesman_Number
JOIN SalesOrderDetails sod ON so.Order_Number = sod.Order_Number
WHERE sod.Product_Number = 'P1002';

-- 17.	Find the name of the salesman who sold the product to client C108 with delivery status is “delivered”.
SELECT DISTINCT s.Salesman_Name
FROM Salesman s
JOIN SalesOrder so ON s.Salesman_Number = so.Salesman_Number
WHERE so.Client_Number = 'C108'
	AND so.Delivery_Status = 'Delivered';

-- 18.	Display lists the ProductName in ANY records in the sale Order Details table has Order Quantity equal to 5.
SELECT DISTINCT p.Product_Name
FROM product p
JOIN SalesOrderDetails sod ON p.Product_Number = sod.Product_Number
WHERE sod.Order_Quantity = 5;

-- 19.	Write a query to find the name and number of the salesman who sold pen or TV or laptop.
SELECT DISTINCT s.Salesman_Name, s.Salesman_Number
FROM Salesman s
JOIN SalesOrder so ON s.Salesman_Number = so.Salesman_Number
JOIN SalesOrderDetails sod ON so.Order_Number = sod.Order_Number
JOIN product p ON sod.Product_Number = p.Product_Number
WHERE p.Product_Name IN ('Pen', 'TV', 'Laptop');

-- 20.	Lists the salesman’s name sold product with a product price less than 800 and Quantity_On_Hand more than 50.
SELECT DISTINCT s.Salesman_Name
FROM Salesman s
JOIN SalesOrder so ON s.Salesman_Number = so.Salesman_Number
JOIN SalesOrderDetails sod ON so.Order_Number = sod.Order_Number
JOIN product p ON sod.Product_Number = p.Product_Number
WHERE p.Sell_Price < 800 AND p.Quantity_On_Hand > 50;

-- 21.	Write a query to find the name and salary of the salesman whose salary is greater than the average salary.
SELECT Salesman_Name, Salary
FROM Salesman
WHERE Salary > (SELECT AVG(Salary) FROM Salesman);

-- 22.	Write a query to find the name and Amount Paid of the clients whose amount paid is greater than the average amount paid.
SELECT Client_Name, Amount_Paid
FROM clients
WHERE Amount_Paid > (SELECT AVG(Amount_Paid) FROM clients);

-- 23.	Find the product price that was sold to Le Xuan.
SELECT p.Product_Name, p.Sell_Price
FROM SalesOrder so
JOIN clients c ON so.Client_Number = c.Client_Number
JOIN SalesOrderDetails sod ON so.Order_Number = sod.Order_Number
JOIN product p ON sod.Product_Number = p.Product_Number
WHERE c.Client_Name = 'Le Xuan';

-- 24.	Determine the product name, client name and amount due that was delivered.
SELECT p.Product_Name, c.Client_Name, c.Amount_Due
FROM SalesOrder so
JOIN clients c ON so.Client_Number = c.Client_Number
JOIN SalesOrderDetails sod ON so.Order_Number = sod.Order_Number
JOIN product p ON sod.Product_Number = p.Product_Number
WHERE so.Delivery_Status = 'Delivered';

-- 25.	Find the salesman’s name and their product name which is cancelled.
SELECT s.Salesman_Name, p.Product_Name
FROM SalesOrder so
JOIN Salesman s ON so.Salesman_Number = s.Salesman_Number
JOIN SalesOrderDetails sod ON so.Order_Number = sod.Order_Number
JOIN product p ON sod.Product_Number = p.Product_Number
WHERE so.Order_Status = 'Cancelled';

-- 26.	Find product names, prices and delivery status for those products purchased by Nguyen Thanh.
SELECT p.Product_Name, p.Sell_Price, so.Delivery_Status
FROM product p
INNER JOIN SalesOrderDetails sod ON p.Product_Number = sod.Product_Number
INNER JOIN SalesOrder so ON so.Order_Number = sod.Order_Number
INNER JOIN clients c ON c.Client_Number = so.Client_Number
WHERE c.Client_Name LIKE 'Nguyen Thanh ';

-- 27.	Display the product name, sell price, salesperson name, delivery status, and order quantity information for each customer.
SELECT p.Product_Name, p.Sell_Price, s.Salesman_Name, so.Delivery_Status, sod.Order_Quantity
FROM product p
JOIN SalesOrderDetails sod ON p.Product_Number = sod.Product_Number
JOIN SalesOrder so ON sod.Order_Number = so.Order_Number
JOIN Salesman s ON so.Salesman_Number = s.Salesman_Number;

-- 28.	Find the names, product names, and order dates of all sales staff whose product order status has been successful but the items have not yet been delivered to the client.
SELECT s.Salesman_Name, p.Product_Name, so.Order_Date
FROM Salesman s
JOIN SalesOrder so ON s.Salesman_Number = so.Salesman_Number
JOIN SalesOrderDetails sod ON so.Order_Number = sod.Order_Number
JOIN product p ON sod.Product_Number = p.Product_Number
WHERE so.Order_Status = 'Successful' AND so.Delivery_Status != 'Delivered';

-- 29.	Find each clients’ product which in on the way.
SELECT c.Client_Name, p.Product_Name
FROM clients c
JOIN SalesOrder so ON c.Client_Number = so.Client_Number
JOIN SalesOrderDetails sod ON so.Order_Number = sod.Order_Number
JOIN product p ON sod.Product_Number = p.Product_Number
WHERE so.Delivery_Status = 'On Way';

-- 30.	Find salary and the salesman’s names who is getting the highest salary.
SELECT Salary, Salesman_Name
FROM Salesman
WHERE Salary = (SELECT MAX(Salary) FROM Salesman);

-- 31.	Find salary and the salesman’s names who is getting second lowest salary.
SELECT Salary, Salesman_Name
FROM Salesman
WHERE Salary = (
    SELECT DISTINCT Salary
    FROM Salesman
    ORDER BY Salary ASC
    LIMIT 1 OFFSET 1
);

-- 32.	Display lists the ProductName in ANY records in the sale Order Details table has Order Quantity more than 9.
SELECT DISTINCT p.Product_Name
FROM product p
JOIN SalesOrderDetails sod ON p.Product_Number = sod.Product_Number
WHERE sod.Order_Quantity > 9;

-- 33.	Find the name of the customer who ordered the same item multiple times.
SELECT c.Client_Name
FROM clients c
JOIN SalesOrder so ON c.Client_Number = so.Client_Number
JOIN SalesOrderDetails sod ON so.Order_Number = sod.Order_Number
GROUP BY c.Client_Name, sod.Product_Number
HAVING COUNT(sod.Product_Number) > 1;

-- 34.	Write a query to find the name, number and salary of the salemans who earns less than the average salary and works in any of Thu Dau Mot city.
SELECT Salesman_Name, Salesman_Number, Salary
FROM Salesman
WHERE Salary < (SELECT AVG(Salary) FROM Salesman)
  AND City = 'Thu Dau Mot';

-- 35.	Write a query to find the name, number and salary of the salemans who earn a salary that is higher than the salary of all the salesman have (Order_status = ‘Cancelled’). Sort the results of the salary of the lowest to highest.
SELECT Salesman_Name, Salesman_Number, Salary
FROM Salesman
WHERE Salary > ALL (
    SELECT Salary
    FROM Salesman s
    JOIN SalesOrder so ON s.Salesman_Number = so.Salesman_Number
    WHERE so.Order_Status = 'Cancelled'
)
ORDER BY Salary ASC;

-- 36.	Write a query to find the 4th maximum salary on the salesman’s table.
SELECT Salary
FROM Salesman
ORDER BY Salary DESC
LIMIT 3,1;

-- 37.	Write a query to find the 3th minimum salary in the salesman’s table.
SELECT Salary
FROM Salesman
ORDER BY Salary ASC
LIMIT 2,1;