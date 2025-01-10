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
SELECT Salesman_Name, City, Target_Achieved, 
    CASE 
        WHEN Target_Achieved >= 60 THEN 'High Achieved'
        ELSE 'Low Achieved'
    END AS Achievement_Status
FROM Salesman;

-- 10.	Write query to creates lists all products (Product_Number AS ID, Product_Name AS Name, Quantity_On_Hand AS Quantity) and their stock status. Products with a positive quantity in stock are labeled as 'More 5 pieces in Stock'.  Products with zero quantity are labeled as ‘Less 5 pieces in Stock'.
SELECT Product_Number AS ID, Product_Name AS Name, Quantity_On_Hand AS Quantity,
    CASE 
        WHEN Quantity_On_Hand > 5 THEN 'More 5 pieces in Stock'
        ELSE 'Less 5 pieces in Stock'
    END AS Stock_Status
FROM Product;

-- 11.	Create a procedure stores get_clients _by_city () saves the all Clients in table. Then Call procedure stores.
DELIMITER //
CREATE PROCEDURE get_clients_by_city()
BEGIN
    SELECT * FROM Clients;
END //
DELIMITER ;

CALL get_clients_by_city();

-- 12.	Drop get_clients _by_city () procedure stores.
DROP PROCEDURE IF EXISTS get_clients_by_city;

-- 13.	Create a stored procedure to update the delivery status for a given order number. Change value delivery status of order number “O20006” and “O20008” to “On Way”.
DELIMITER //
CREATE PROCEDURE update_delivery_status(IN p_order_number VARCHAR(15), IN p_status CHAR(15))
BEGIN
    UPDATE SalesOrder
    SET Delivery_Status = p_status
    WHERE Order_Number = p_order_number;
END //
DELIMITER ;

CALL update_delivery_status('O20006', 'On Way');
CALL update_delivery_status('O20008', 'On Way');

-- 14.	Create a stored procedure to retrieve the total quantity for each product.
DELIMITER //
CREATE PROCEDURE total_quantity_per_product()
BEGIN
    SELECT Product_Number, SUM(Order_Quantity) AS Total_Quantity
    FROM SalesOrderDetails
    GROUP BY Product_Number;
END //
DELIMITER ;

CALL total_quantity_per_product();

-- 15.	Create a stored procedure to update the remarks for a specific salesman.
DELIMITER //
CREATE PROCEDURE update_salesman_remarks(IN p_salesman_number VARCHAR(15), IN p_remarks VARCHAR(255))
BEGIN
    UPDATE Salesman
    SET Remarks = p_remarks
    WHERE Salesman_Number = p_salesman_number;
END //
DELIMITER ;

-- 16.	Create a procedure stores find_clients() saves all of clients and can call each client by client_number.
DELIMITER //
CREATE PROCEDURE find_clients(IN p_client_number VARCHAR(10))
BEGIN
    SELECT * FROM Clients
    WHERE Client_Number = p_client_number;
END //
DELIMITER ;

-- 17.	Create a procedure stores salary_salesman() saves all of clients (salesman_number, salesman_name, salary) having salary >15000. Then execute the first 2 rows or the first 4 rows from the salesman table.
DELIMITER //
CREATE PROCEDURE salary_salesman()
BEGIN
    SELECT Salesman_Number, Salesman_Name, Salary
    FROM Salesman
    WHERE Salary > 15000
    LIMIT 2;
END //
DELIMITER ;
CALL salary_salesman();

-- 18.	Procedure MySQL MAX() function retrieves maximum salary from MAX_SALARY of salary table.
DELIMITER //
CREATE PROCEDURE max_salary()
BEGIN
    SELECT MAX(Salary) AS MAX_SALARY
    FROM Salesman;
END //
DELIMITER ;

CALL max_salary();

-- 19.	Create a procedure stores execute finding amount of order_status by values order status of salesorder table.
DELIMITER //
CREATE PROCEDURE count_order_status()
BEGIN
    SELECT Order_Status, COUNT(*) AS Status_Count
    FROM SalesOrder
    GROUP BY Order_Status;
END //
DELIMITER ;

CALL count_order_status();

-- 20.	Create a stored procedure to calculate and update the discount rate for orders.
DELIMITER //
CREATE PROCEDURE update_discount_rate(IN p_order_number VARCHAR(15), IN p_discount_rate INT)
BEGIN
    UPDATE SalesOrderDetails
    SET Discount_Rate = p_discount_rate
    WHERE Order_Number = p_order_number;
END //
DELIMITER ;

-- 21.	Count the number of salesman with following conditions : SALARY < 20000; SALARY > 20000; SALARY = 20000.
SELECT
    SUM(CASE WHEN Salary < 20000 THEN 1 ELSE 0 END) AS Salary_Less_Than_20000,
    SUM(CASE WHEN Salary > 20000 THEN 1 ELSE 0 END) AS Salary_Greater_Than_20000,
    SUM(CASE WHEN Salary = 20000 THEN 1 ELSE 0 END) AS Salary_Equal_To_20000
FROM Salesman;

-- 22.	Create a stored procedure to retrieve the total sales for a specific salesman.
DELIMITER //
CREATE PROCEDURE total_sales_by_salesman(IN p_salesman_number VARCHAR(15))
BEGIN
    SELECT Salesman_Number, SUM(Quantity_Sell * Sell_Price) AS Total_Sales
    FROM SalesOrder
    JOIN SalesOrderDetails USING(Order_Number)
    JOIN Product USING(Product_Number)
    WHERE Salesman_Number = p_salesman_number
    GROUP BY Salesman_Number;
END //
DELIMITER ;
CALL total_sales_by_salesman('S001');

-- 23.	Create a stored procedure to add a new product:
-- Input variables: Product_Number, Product_Name, Quantity_On_Hand, Quantity_Sell, Sell_Price, Cost_Price.
DELIMITER //
CREATE PROCEDURE add_product(
    IN p_Product_Number VARCHAR(15), 
    IN p_Product_Name VARCHAR(25), 
    IN p_Quantity_On_Hand INT, 
    IN p_Quantity_Sell INT, 
    IN p_Sell_Price DECIMAL(15,4), 
    IN p_Cost_Price DECIMAL(15,4)
)
BEGIN
    INSERT INTO Product (Product_Number, Product_Name, Quantity_On_Hand, Quantity_Sell, Sell_Price, Cost_Price)
    VALUES (p_Product_Number, p_Product_Name, p_Quantity_On_Hand, p_Quantity_Sell, p_Sell_Price, p_Cost_Price);
END //
DELIMITER ;

CALL add_product('P1010', 'Tablet', 10, 5, 2000, 1500);

-- 24.	Create a stored procedure for calculating the total order value and classification:
-- -	This stored procedure receives the order code (p_Order_Number) và return the total value (p_TotalValue) and order classification (p_OrderStatus).
-- -	Using the cursor (CURSOR) to browse all the products in the order (SalesOrderDetails ).
-- -	LOOP/While: Browse each product and calculate the total order value.
-- -	CASE WHEN: Classify orders based on total value:
-- Greater than or equal to 10000: "Large"
-- Greater than or equal to 5000: "Midium"
-- Less than 5000: "Small"
DELIMITER //
CREATE PROCEDURE calculate_order_value_and_classify(IN p_Order_Number VARCHAR(15), OUT p_TotalValue DECIMAL(15,4), OUT p_OrderStatus VARCHAR(15))
BEGIN
    DECLARE v_Product_Price DECIMAL(15,4);
    DECLARE v_Order_Quantity INT;
    DECLARE v_Total DECIMAL(15,4) DEFAULT 0;
    DECLARE done INT DEFAULT FALSE;
    DECLARE order_cursor CURSOR FOR
        SELECT Sell_Price, Order_Quantity 
        FROM SalesOrderDetails
        JOIN Product USING(Product_Number)
        WHERE Order_Number = p_Order_Number;
        
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    OPEN order_cursor;
    
    read_loop: LOOP
        FETCH order_cursor INTO v_Product_Price, v_Order_Quantity;
        IF done THEN
            LEAVE read_loop;
        END IF;
        SET v_Total = v_Total + (v_Product_Price * v_Order_Quantity);
    END LOOP;
    
    CLOSE order_cursor;
    
    SET p_TotalValue = v_Total;
    
    CASE
        WHEN v_Total >= 10000 THEN SET p_OrderStatus = 'Large';
        WHEN v_Total >= 5000 THEN SET p_OrderStatus = 'Medium';
        ELSE SET p_OrderStatus = 'Small';
    END CASE;
END //
DELIMITER ;

CALL calculate_order_value_and_classify('O20001', @total_value, @order_status);
SELECT @total_value AS TotalValue, @order_status AS OrderStatus;

