use SaleManagement;

-- 1.	Show the all-clients details who lives in “Binh Duong”.
select *
from clients
where Province like 'Binh Duong';

-- 2.	Find the client’s number and client’s name who do not live in “Hanoi”.
select Client_Number, Client_Name
from clients
where Province <> "Hanoi";

-- 3.	Identify the names of all products with less than 25 in stock.

-- 4.	Find the product names where company making losses. 
select Product_Name
from product
where Sell_Price < Cost_Price;

-- 5.	Find the salesman’s details who are able achieved their target.

-- 6.	Select the names and city of salesman who are not received salary between 10000 and 17000.
select salesman_name, city
from salesman
where Salary not between 10000 and 17000;

-- 7.	Show order date and the clients_number of who bought the product between '2022-01-01' and '2022-02-15'.


-- 8.	Find the names of cities in clients table where city name starts with "N"
select city
from clients
where city like "N%";

-- 9.	Display clients’ information whose names have "u" in third position.
select *
from clients
where Client_Name like '__u%';

-- 10.	Find the details of clients whose names have "u" in second last position.
select *
from clients
where Client_Name like '%u_';

-- 11.	Find the names of cities in clients table where city name starts with "D" and ends with “n”.

-- 12.	Select all clients details who belongs from Ho Chi Minh, Hanoi and Da Lat.

-- 13.	Choose all clients data who do not reside in Ho Chi Minh, Hanoi and Da Lat.
----------------------------------------------------------------------------------------------------------

-- 14.	Find the average salesman’s salary.
select AVG(salary) 
as avg_salary
from salesman;

-- 15.	Find the name of the highest paid salesman.
select salesman_name
from salesman
where salary in(select max(salary) from salesman);

select salesman_name
from salesman
order by Salary desc
limit 1;

-- 16.	Find the name of the salesman who is paid the lowest salary.
select salesman_name
from salesman
order by salary asc
limit 1;

select salesman_name
from salesman
where Salary in(select min(salary) from salesman);

-- 17.	Determine the total number of salespeople employed by the company.
select COUNT(salesman_number) as total_of_salespeople
from salesman;

-- 18.	Compute the total salary paid to the company's salesman.
select SUM(salary) 
as total_salary
from salesman;

-- d)	Using Order by keyword, limit clause

-- 19.	Select the salesman’s details sorted by their salary.
select *
from salesman
order by Salary asc;

-- 20.	Display salesman names and phone numbers based on their target achieved (in ascending order) and their city (in descending order).
select salesman_name, phone
from salesman
order by Target_Achieved asc, city desc;

-- 21.	Display 3 first names of the salesman table and the salesman’s names in descending order.
select salesman_name
from salesman
order by salesman_name desc
limit 3;

-- 22.	Find salary and the salesman’s names who is getting the highest salary.
select salesman_name, salary 
from salesman
order by salary desc
limit 1;

select salesman_name, salary
from salesman
where salary in(select max(salary) from salesman)
limit 1;

-- 23.	Find salary and the salesman’s names who is getting second lowest salary.
select salesman_name, salary
from salesman
order by salary asc
limit 2,1;

-- 24.	Display the first five sales orders in formation from the sales order table.

-- 25.	Display next ten sales order information from sales order table except first five sales order.
select *
from salesorder
order by Order_Number
limit 5,10;

-- e)	Using group by with having clause with aggregate functions (COUNT(), MAX(), MIN(), SUM(), AVG()), order by.

-- 26.	If there are more than one client, find the name of the province and the number of clients in each province, ordered high to low.
select  province, client_name, count(Client_Number) as total_client, province
from clients
group by province
having total_client > 1
order by total_client asc;

select province, count(province) as Quantity_Client
from clients
group by province
having quantity_client > 1
order by quantity_client desc;

-- 27.	Display information clients have number of sales order more than 1.
select *
from clients c
join salesorder s 
on c.Client_Number = s.Client_Number
where c.Client_number in (
	select c.client_number
    from clients c
    join salesorder s
    on c.Client_Number = s.Client_Number
    group by c.Client_Number
    having count(c.Client_Number) > 1
);

-- Practice to grade
-- Question : Using database ‘SaleManagerment’ to write SQL queries following:

-- 28.	Display the name and due amount of those clients who lives in “Hanoi”.
select province, client_name, amount_due
from clients
where Province like "Hanoi";

-- 29.	Find the clients details who has due more than 3000.

-- 30.	Find the clients name and their province who has no due.
select client_name, province
from clients
where amount_due <= 0;

-- 31.	Show details of all clients paying between 10,000 and 13,000.

-- 32.	Find the details of clients whose name is “Dat”.

-- 33.	Display all product name and their corresponding selling price.

-- 34.	How many TVs are in stock?

-- 35.	Find the salesman’s details who are not able achieved their target.

-- 36.	Show all the product details of product number ‘P1005’.

-- 37.	Find the buying price and sell price of a Mouse.

-- 38.	Find the salesman names and phone numbers who lives in Thu Dau Mot.

-- 39.	Find all the salesman’s name and salary.

-- 40.	Select the names and salary of salesman who are received between 10000 and 17000.

-- 41.	Display all salesman details who are received salary between 10000 and 20000 and achieved their target. 

-- 42.	Display all salesman details who are received salary between 20000 and 30000 and not achieved their target. 

-- 43.	Find information about all clients whose names do not end with "h".
select *
from clients
where Client_Name not like "%h";

-- 44.	Find client names whose second letter is 'r' or second last letter 'a'.

-- 45.	Select all clients where the city name starts with "D" and at least 3 characters in length.
select *
from clients
where city like"D___%";

-- 46.	Select the salesman name, salaries and target achieved sorted by their target_achieved in descending order.

-- 47.	Select the salesman’s details sorted by their sales_target and target_achieved in ascending order.

-- 48.	Select the salesman’s details sorted ascending by their salary and descending by achieved target.

-- 49.	Display salesman names and phone numbers in descending order based on their sales target.

-- 50.	Display the product name, cost price, and sell price sorted by quantity in hand.

-- 51.	Retrieve the clients’ names in ascending order.

-- 52.	Display client information based on order by their city.

-- 53.	Display client information based on order by their address and city.
-- 54.	Display client information based on their city, sorted high to low based on amount due.
-- 55.	Display last five sales order in formation from sales order table.
-- 56.	Count the pincode in client table.
-- 57.	How many clients are living in Binh Duong?
-- 58.	Count the clients for each province.
-- 59.	If there are more than three clients, find the name of the province and the number of clients in each province.

-- 60.	Display product number and product name and count number orders of each product more than 1 (in ascending order).
select p.product_number, p.product_name, count(sod.order_number) as order_count
from product p
join salesorderdetails sod
on p.product_number = sod.product_number
group by p.Product_Number, p.Product_Name
having order_count > 1
order by order_count asc;

-- 61.	Find products which have more quantity on hand than 20 and less than the sum of average.
select *
from product
where Quantity_On_Hand between 20
and (select avg (Quantity_On_Hand) 
	from product);

-----------------------------------------------------------------------------------------------------------------------------
-- 1.	Display the clients (name) who lives in same city.
select distinct c1.client_name, c2.client_name, c1.City
from clients c1
join clients c2
on c1.city = c2.city
and c1.client_number <> c2.Client_Number
group by c1.client_name, c2.client_name, c1.city;

-- 2.	Display city, the client names and salesman names who are lives in “Thu Dau Mot” city.
select c.client_name, s.salesman_name, c.City
from clients c
join salesman s
on c.city = s.city 
where c.city like "Thu Dau Mot";

-- 3.	Display client name, client number, order number, salesman number, and product number for each order.

-- 4.	Find each order (client_number, client_name, order_number) placed by each client. 

-- 5.	Display the details of clients (client_number, client_name) and the number of orders which is paid by them.
select c.client_number, c.client_name, count(so.order_number) as number_of_orders
from clients c
join salesorder so
on c.client_number = so.client_number
group by c.client_number;

-- 6.	Display the details of clients (client_number, client_name) who have paid for more than 2 orders.
select c.client_number, c.client_name, count(so.order_number) as number_of_orders
from clients c
join salesorder so
on c.client_number = so.client_number
group by c.client_number
having number_of_orders > 2;
 
-- 7.	Display details of clients who have paid for more than 1 order in descending order of client_number.
select c.client_number, c.client_name, count(so.order_number) as number_of_orders
from clients c
join salesorder so
on c.client_number = so.client_number
group by c.client_number
having number_of_orders > 1
order by number_of_orders desc;

-- 8.	Find the salesman names who sells more than 20 products.
select s.Salesman_Name
from salesman s
join salesorder so
on s.Salesman_Number = so.Salesman_Number
join salesorderdetails sod
on so.Order_Number = sod.Order_Number
group by s.Salesman_Number
having sum(sod.Order_Quantity) > 20;

-- 9.	Display the client information (client_number, client_name) and order number of those clients who have order status is cancelled.

-- 10.	Display client name, client number of clients C101 and count the number of orders which were received “successful”.
select c.client_name, c.client_number, count(so.order_number) as number_of_orders
from clients c
join salesorder so
on c.Client_Number = so.Client_Number
where c.Client_Number like "C101"
and so.order_status like "successful"
group by c.client_number;

-- 11.	Count the number of clients orders placed for each product.

-- 12.	Find product numbers that were ordered by more than two clients then order in descending by product number.
select p.product_number, p.product_name
from product p
join salesorderdetails sod
on p.Product_Number = sod.Product_Number
join salesorder so
on so.Order_Number = sod.Order_Number
join clients c
on so.Client_Number = c.Client_Number
group by p.product_number, p.product_name
having count(c.Client_Number) > 2
order by p.Product_Number desc;


-- IV.	Using nested query with operator (IN, EXISTS, ANY and ALL)
-- 13.	Find the salesman’s names who is getting the second highest salary.
-- 14.	Find the salesman’s names who is getting second lowest salary.
-- 15.	Write a query to find the name and the salary of the salesman who have a higher salary than the salesman whose salesman number is S001.
-- 16.	Write a query to find the name of all salesman who sold the product has number: P1002.
-- 17.	Find the name of the salesman who sold the product to client C108 with delivery status is “delivered”.
-- 18.	Display lists the ProductName in ANY records in the sale Order Details table has Order Quantity equal to 5.
-- 19.	Write a query to find the name and number of the salesman who sold pen or TV or laptop.
-- 20.	Lists the salesman’s name sold product with a product price less than 800 and Quantity_On_Hand more than 50.
-- 21.	Write a query to find the name and salary of the salesman whose salary is greater than the average salary.
-- 22.	Write a query to find the name and Amount Paid of the clients whose amount paid is greater than the average amount paid.
-- V.	Additional excersices:
-- 23.	Find the product price that was sold to Le Xuan.
select p.product_name, p.sell_price
from product p 
join salesorderdetails sod 
on p.Product_Number = sod.Product_Number
join salesorder so
on so.Order_Number = sod.Order_Number
join clients c
on so.client_number = c.Client_Number
where c.client_name like "Le Xuan";

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
-----------------------------------------------------------------------------------------------------------------------

-- 1. How to check constraint in a table?
select constraint_name, constraint_type
from information_schema.table_constraints
where table_name = "salesman";

-- 2. Create a separate table name as “ProductCost” from “Product” table, which contains the information about product name and its buying price. 


-- 3. Compute the profit percentage for all products. Note: profit = (sell-cost)/cost*100

-- 4. If a salesman exceeded his sales target by more than equal to 75%, his remarks should be ‘Good’.


-- 5. If a salesman does not reach more than 75% of his sales objective, he is labeled as 'Average'.
-- 6. If a salesman does not meet more than half of his sales objective, he is considered 'Poor'.
-- 7. Find the total quantity for each product. (Query)
select product_name, quantity_on_hand + quantity_sell
from product
group by product_number;

-- 8. Add a new column and find the total quantity for each product.

-- 9. If the Quantity on hand for each product is more than 10, change the discount rate to 10 otherwise set to 5.
alter table product
add column discount_rate decimal (5,2);

update product
set discount_rate = case
	when quantity_on_hand > 10 then 10 
	else 5
end;

-- 10. If the Quantity on hand for each product is more than equal to 20, change the discount rate to 10, if it is between 10 and 20 then change to 5, if it is more than 5 then change to 3 otherwise set to 0.
-- 11. The first number of pin code in the client table should start with 7.
-- 12. Creates a view name as clients_view that shows all customers information from Thu Dau Mot.
create view client_view as
select *
from clients
where city = "Thu Dau Mot";

-- 13. Drop the “client_view”.

-- 14. Creates a view name as clients_order that shows all clients and their order details from Thu Dau Mot.
-- 15. Creates a view that selects every product in the "Products" table with a sell price higher than the average sell price.
create view product_above_avg as
select *
from product
where Sell_Price > (select avg(Sell_Price) from product);

-- 16. Creates a view name as salesman_view that show all salesman information and products (product names, product price, quantity order) were sold by them.
-- 17. Creates a view name as sale_view that show all salesman information and product (product names, product price, quantity order) were sold by them with order_status = 'Successful'.
-- 18. Creates a view name as sale_amount_view that show all salesman information and sum order quantity of product greater than and equal 20 pieces were sold by them with order_status = 'Successful'.

-- II.	Additional assignments about Constraint
-- 19. Amount paid and amounted due should not be negative when you are inserting the data.
alter table clients
add constraint check_amount_paid_non_negative
check (Amount_Paid >= 0 and Amount_due >=0);
 
-- 20. Do not enforce the check constraint for pincode.
alter table clients
drop constraint check_pincode;

-- 21. How to alter a check constraint enforcement state?
alter table clients
add constraint check_pincode
check (pincode like "7%");

-- 22. Remove the constraint from pincode;
alter table clients
drop constraint check_pincode;

-- 23. The sell price and cost price should be unique.
alter table product
add constraint unique_sell_price
unique (sell_price);

and check_cost_price
check (

-- 24. The sell price and cost price should not be unique.
-- 25. Update the delivery status to “Delivered” for the product number P1007.
-- 26. Change address and city to ‘Phu Hoa’ and ‘Thu Dau Mot’ where client number is C104.
-- 27. Add a new column to “Product” table named as “Exp_Date”, data type is Date.
-- 28. Add a new column to “Clients” table named as “Phone”, data type is varchar and size is 15.
-- 29. Update remarks as “Good” for all salesman.
-- 30. Change remarks to "bad" whose salesman number is "S004".
-- 31. Modify the data type of “Phone” in “Clients” table with varchar from size 15 to size is 10.
-- 32. Delete the “Phone” column from “Clients” table.
-- 33. alter table Clients drop column Phone;
-- 34. Change the sell price of Mouse to 120.
-- 35. Change the city of client number C104 to “Ben Cat”.
-- 36. If Order_Quantity greater than 5, then 10% discount. If Order_Quantity greater than 10, then 15% discount. Othrwise, no discount.
