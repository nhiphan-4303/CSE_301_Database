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

-- 55.	Display last five sales order information from sales order table.
SELECT *
FROM SalesOrder
ORDER BY Order_Number DESC
LIMIT 5;

-- 56.	Count the pincode in client table.
SELECT COUNT(DISTINCT Pincode)
AS Number_Of_Pincode
FROM clients;

-- 57.	How many clients are living in Binh Duong?
SELECT COUNT(*) 
AS Binh_Duong_Clients
FROM clients
WHERE Province like 'Binh Duong';

-- 58.	Count the clients for each province.
SELECT Province, COUNT(*)
AS Number_Of_Clients
FROM clients
GROUP BY Province;

-- 59.	If there are more than three clients, find the name of the province and the number of clients in each province.
SELECT Province, COUNT(*)
AS Number_Of_Clients
FROM clients
GROUP BY Province
HAVING COUNT(*) > 3;

-- 60.	Display product number and product name and count number orders of each product more than 1 (in ascending order).
SELECT p.Product_Number, p.Product_Name, COUNT(so.Order_Number)
AS Order_Count
FROM product p
JOIN SalesOrderDetails so ON p.Product_Number = so.Product_Number
GROUP BY p.Product_Number, p.Product_Name
HAVING COUNT(so.Order_Number) > 1
ORDER BY Order_Count ASC;

-- 61.	Find products which have more quantity on hand than 20 and less than average of quantity on hand.
SELECT *
FROM product
WHERE Quantity_On_Hand > 20 
AND Quantity_On_Hand < (SELECT AVG(Quantity_On_Hand) FROM product);



