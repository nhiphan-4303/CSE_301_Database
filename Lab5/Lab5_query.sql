SELECT *
FROM Clients NATURAL JOIN Salesorder;

SELECT c.*, s.*
FROM Clients c INNER JOIN Salesorder s ON c.client_number = s.client_number;

select distinct c.Client_Name, s.Salesman_Name, c.city, s.city
from clients c inner join salesman s on c.city = s.city;

-- 1.	Display the clients (name) who lives in same city.
-- 2.	Display city, the client names and salesman names who are lives in “Thu Dau Mot” city.

-- 3.	Display client name, client number, order number, salesman number, and product number for each order.
select c.Client_Number, c.Client_Name, s.Order_Number, s.Salesman_Number
from clients c inner join salesorder s on c.Client_Number = s.Client_Number
inner join salesorderdetails so on s.Order_Number = so.Order_Number;

-- 4.	Find each order (client_number, client_name, order_number) placed by each client.
select client_number, client_name, order_number
from clients natural join salesorder;
 
-- 5.	Display the details of clients (client_number, client_name) and the number of orders which is paid by them.
select c.Client_Number, c.Client_Name, count(so.order_number) as NumberOfOrder
FROM clients c JOIN salesorder so ON c.Client_Number = so.Client_Number
group by c.client_number
having count(so.order_number);

-- 6.	Display the details of clients (client_number, client_name) who have paid for more than 2 orders.
select s.Salesman_Name, SUM(sod.Order_Quantity)
from salesman s inner join salesorder so on s.Salesman_Number = so.Salesman_Number
inner join salesorderdetails sod on so.Order_Number = sod.Order_Number
group by s.Salesman_Name;

-- 7.	Display details of clients who have paid for more than 1 order in descending order of client_number.

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

-- 12.	Find product numbers that were ordered by more than two clients then order in descending by product number.

-- 13.	Find the salesman’s names who is getting the second highest salary.
select Salesman_Name
from salesman
where salary = (select distinct salary
				from salesman
				order by salary
				limit 0,1);
                
-- 14.	Find the salesman’s names who is getting second lowest salary.
select Salesman_Name
from salesman
where salary = (select distinct salary
				from salesman
				order by salary desc
				limit 1,1);

-- 15.	Write a query to find the name and the salary of the salesman who have a higher salary than the salesman whose salesman number is S001.


-- 16.	Write a query to find the name of all salesman who sold the product has number: P1002.
-- 17.	Find the name of the salesman who sold the product to client C108 with delivery status is “delivered”.
-- 18.	Display lists the ProductName in ANY records in the sale Order Details table has Order Quantity equal to 5.


-- 19.	Write a query to find the name and number of the salesman who sold pen or TV or laptop.
-- 20.	Lists the salesman’s name sold product with a product price less than 800 and Quantity_On_Hand more than 50.
-- 21.	Write a query to find the name and salary of the salesman whose salary is greater than the average salary.
-- 22.	Write a query to find the name and Amount Paid of the clients whose amount paid is greater than the average amount paid.
-- 23.	Find the product price that was sold to Le Xuan.
-- 24.	Determine the product name, client name and amount due that was delivered.
-- 25.	Find the salesman’s name and their product name which is cancelled.
-- 26.	Find product names, prices and delivery status for those products purchased by Nguyen Thanh.
-- 27.	Display the product name, sell price, salesperson name, delivery status, and order quantity information for each customer.
-- 28.	Find the names, product names, and order dates of all sales staff whose product order status has been successful but the items have not yet been delivered to the client.
-- 29.	Find each clients’ product which in on the way.
-- 30.	Find salary and the salesman’s names who is getting the highest salary.
-- 31.	Find salary and the salesman’s names who is getting second lowest salary.
-- 32.	Display lists the ProductName in ANY records in the sale Order Details table has Order Quantity more than 9.
-- 33.	Find the name of the customer who ordered the same item multiple times.
-- 34.	Write a query to find the name, number and salary of the salemans who earns less than the average salary and works in any of Thu Dau Mot city.
-- 35.	Write a query to find the name, number and salary of the salemans who earn a salary that is higher than the salary of all the salesman have (Order_status = ‘Cancelled’). Sort the results of the salary of the lowest to highest.
-- 36.	Write a query to find the 4th maximum salary on the salesman’s table.
-- 37.	Write a query to find the 3th minimum salary in the salesman’s table.
