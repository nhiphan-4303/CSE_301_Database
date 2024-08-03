use SaleManagement;

-- 1.	SQL statement returns the cities (only distinct values) from both the "Clients" and the "salesman" table.
SELECT City, 'Clients' AS Type
FROM Clients
UNION
SELECT City, 'Salesman' AS Type
FROM Salesman;

-- 2.	SQL statement returns the cities (duplicate values also) both the "Clients" and the "salesman" table.
SELECT City, 'Clients' AS Type
FROM Clients
UNION ALL
SELECT City, 'Salesman' AS Type
FROM Salesman;

-- 3.	SQL statement returns the Ho Chi Minh cities (only distinct values) from the "Clients" and the "salesman" table.
SELECT Client_Number AS ID, Client_Name AS Name, City, 'Client' AS Type
FROM Clients
WHERE City = 'Ho Chi Minh'
UNION
SELECT Salesman_Number AS ID, Salesman_Name AS Name, City, 'Salesman' AS Type
FROM Salesman
WHERE City = 'Ho Chi Minh';

-- 4.	SQL statement returns the Ho Chi Minh cities (duplicate values also) from the "Clients" and the "salesman" table.
SELECT Client_Number AS ID, Client_Name AS Name, City, 'Client' AS Type
FROM Clients
WHERE City = 'Ho Chi Minh'
UNION ALL
SELECT Salesman_Number AS ID, Salesman_Name AS Name, City, 'Salesman' AS Type
FROM Salesman
WHERE City = 'Ho Chi Minh';

-- 5.	SQL statement lists all Clients and salesman.
SELECT Client_Number AS ID, Client_Name AS Name, Address, City, Pincode, Province, 'Client' AS Type
FROM Clients
UNION ALL
SELECT Salesman_Number AS ID, Salesman_Name AS Name, Address, City, Pincode, Province, 'Salesman' AS Type
FROM Salesman;

-- 6.	Write a SQL query to find all salesman and clients located in the city of Ha Noi on a table with information: ID, Name, City and Type.
SELECT Client_Number AS ID, Client_Name AS Name, City, 'Client' AS Type
FROM Clients
WHERE City = 'HaNoi'
UNION
SELECT Salesman_Number AS ID, Salesman_Name AS Name, City, 'Salesman' AS Type
FROM Salesman
WHERE City = 'HaNoi';

-- 7.	Write a SQL query to find those salesman and clients who have placed more than one order. Return ID, name and order by ID.
SELECT s.Salesman_Number AS ID, s.Salesman_Name AS Name, COUNT(Order_Number) AS Number
FROM Salesman s
JOIN Salesorder o ON s.Salesman_Number = o.Salesman_Number
GROUP BY s.Salesman_Number, s.Salesman_Name
HAVING COUNT(o.Order_Number) > 1
UNION
SELECT c.Client_Number AS ID, c.Client_Name AS Name, COUNT(Order_Number) AS Number
FROM Clients c
JOIN Salesorder o ON c.Client_Number = o.Client_Number
GROUP BY c.Client_Number, c.Client_Name
HAVING COUNT(o.Order_Number) > 1;

-- 8.	Retrieve Name, Order Number (order by order number) and Type of client or salesman with the client names who placed orders and the salesman names who processed those orders.
SELECT c.Client_Name AS Name, so.Order_Number, 'Client' AS Type
FROM clients c 
JOIN SalesOrder so ON c.Client_Number = so.Client_Number
UNION
SELECT s.Salesman_Name AS Name, so.Order_Number, 'Salesman' AS Type
FROM Salesman s
JOIN SalesOrder so ON s.Salesman_Number = so.Salesman_Number
ORDER BY Order_Number;

-- 9.	Write a SQL query to create a union of two queries that shows the salesman, cities, and target_Achieved of all salesmen. Those with a target of 60 or greater will have the words 'High Achieved', while the others will have the words 'Low Achieved'.


-- 10.	Write query to creates lists all products (Product_Number AS ID, Product_Name AS Name, Quantity_On_Hand AS Quantity) and their stock status. Products with a positive quantity in stock are labeled as 'More 5 pieces in Stock'.  Products with zero quantity are labeled as ‘Less 5 pieces in Stock'.
-- 11.	Create a procedure stores get_clients _by_city () saves the all Clients in table. Then Call procedure stores.
-- 12.	Drop get_clients _by_city () procedure stores.
-- 13.	Create a stored procedure to update the delivery status for a given order number. Change value delivery status of order number “O20006” and “O20008” to “On Way”.
-- 14.	Create a stored procedure to retrieve the total quantity for each product.
-- 15.	Create a stored procedure to update the remarks for a specific salesman.
-- 16.	Create a procedure stores find_clients() saves all of clients and can call each client by client_number.
-- 17.	Create a procedure stores salary_salesman() saves all of clients (salesman_number, salesman_name, salary) having salary >15000. Then execute the first 2 rows or the first 4 rows from the salesman table.
-- 18.	Procedure MySQL MAX() function retrieves maximum salary from MAX_SALARY of salary table.
-- 19.	Create a procedure stores execute finding amount of order_status by values order status of salesorder table.
-- 20.	Create a stored procedure to calculate and update the discount rate for orders.
-- 21.	Count the number of salesman with following conditions : SALARY < 20000; SALARY > 20000; SALARY = 20000.
-- 22.	Create a stored procedure to retrieve the total sales for a specific salesman.
-- 23.	Create a stored procedure to add a new product:
-- Input variables: Product_Number, Product_Name, Quantity_On_Hand, Quantity_Sell, Sell_Price, Cost_Price.
-- 24.	Create a stored procedure for calculating the total order value and classification:
-- -	This stored procedure receives the order code (p_Order_Number) và return the total value (p_TotalValue) and order classification (p_OrderStatus).
-- -	Using the cursor (CURSOR) to browse all the products in the order (SalesOrderDetails ).
-- -	LOOP/While: Browse each product and calculate the total order value.
-- -	CASE WHEN: Classify orders based on total value:
-- Greater than or equal to 10000: "Large"
-- Greater than or equal to 5000: "Midium"
-- Less than 5000: "Small"
