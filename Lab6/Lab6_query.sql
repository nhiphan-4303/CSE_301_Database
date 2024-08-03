use SaleManagement;

-- 1.	How to check constraint in a table?
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_NAME = 'salesman';

-- 2. Create a separate table name as “ProductCost” from “Product” table, which contains the information about product name and its buying price. 
CREATE TABLE ProductCost AS
SELECT Product_Name, Cost_Price
FROM product;

-- 3.	Compute the profit percentage for all products. Note: profit = (sell-cost)/cost*100
ALTER TABLE product 
ADD COLUMN profit DECIMAL(15,2);

update product 
SET profit = (Sell_Price - Cost_Price)*100/Cost_Price;

-- 4.	If a salesman exceeded his sales target by more than equal to 75%, his remarks should be ‘Good’.
alter table salesman
add column Remark varchar(10);

update salesman
set Remark = 'Good'
where (Target_Achieved*100)/Sales_Target >= 75;

-- 5.	If a salesman does not reach more than 75% of his sales objective, he is labeled as 'Average'.
update salesman
set Remark='Average'
where (Target_Achieved*100)/Sales_Target >= 50 and (Target_Achieved*100)/Sales_Target < 75;

-- 6.	If a salesman does not meet more than half of his sales objective, he is considered 'Poor'.
update salesman 
set Remark = 'Poor'
where (Target_Achieved*100)/Sales_Target < 50;

-- 7.	Find the total quantity for each product. (Query)
select product_number, product_name, Quantity_On_Hand + Quantity_Sell
as Total_Quantity
from product;

-- 8.	Add a new column and find the total quantity for each product.
alter table product
add column Total_Quantity int;

update product
set Total_Quantity = Quantity_On_Hand + Quantity_Sell;

-- 9.	If the Quantity on hand for each product is more than 10, change the discount rate to 10 otherwise set to 5.
alter table product
add column Discount_Rate decimal (5,2);

update product
set Discount_Rate = case
	when Quantity_On_Hand > 10 then 10
    else 5
end;

-- 10.	If the Quantity on hand for each product is more than equal to 20, change the discount rate to 10, if it is between 10 and 20 then change to 5, if it is more than 5 then change to 3 otherwise set to 0.
update product
set Discount_Rate = case
	when Quantity_On_Hand >= 20 then 10
    when Quantity_On_Hand >=10 then 5
    when Quantity_On_Hand >5 then 3
    else 0
end;

-- 11.	The first number of pin code in client table should be start with 7.
alter table clients
add check (Pincode like '7%');

-- 12.	Creates a view name as clients_view that shows all customers information from Thu Dau Mot.
create view clients_view as 
select *
from clients
where City = 'Thu Dau Mot';

select * from clients_view;

-- 13.	Drop the “client_view”.
drop view clients_view;

-- 14.	Creates a view name as clients_order that shows all clients and their order details from Thu Dau Mot.
create view clients_order as
select c.Client_Number,
    c.Client_Name,
    c.Address,
    c.City,
    c.Pincode,
    c.Province,
    so.Order_Number,
    so.Order_Date,
    so.Delivery_Status,
    so.Delivery_Date,
    so.Order_Status
from clients c 
join SalesOrder so ON c.Client_Number = so.Client_Number
where c.City = 'Thu Dau Mot'; 

-- 15.	Creates a view that selects every product in the "Products" table with a sell price higher than the average sell price.
create view product_above_average as
select *
from product
where Sell_Price > (select AVG(Sell_Price)
						from product);

-- 16.	Creates a view name as salesman_view that show all salesman information and products (product names, product price, quantity order) were sold by them.
create view salesman_view as
select s.*, p.Product_Name, p.Sell_Price, p.Cost_Price, sod.Order_Quantity
from salesman s 
inner join salesorder so on s.Salesman_Number = so.Salesman_Number
inner join salesorderdetails sod on so.Order_Number = sod.Order_Number
inner join product p  on sod.Product_Number = p.Product_Number;

select * from salesman_view;

-- 17.	Creates a view name as sale_view that show all salesman information and product (product names, product price, quantity order) were sold by them with order_status = 'Successful'.
create view sale_view as
select s.*, p.Product_Name, p.Sell_Price, sod.Order_Quantity, so.Order_Status
from salesman s
inner join salesorder so on s.Salesman_Number = so.Salesman_Number
inner join salesorderdetails sod on sod.Order_Number = so.Order_Number
inner join product p on p.Product_Number = sod.Product_Number
where so.Order_Status = 'Successful';

-- 18.	Creates a view name as sale_amount_view that show all salesman information and sum order quantity of product greater than and equal 20 pieces were sold by them with order_status = 'Successful'.
create view sale_amount_view as
select s.*, sum(sod.Order_Quantity) as Total_Order_Quantity
from Salesman s
inner join salesorder so on s.Salesman_Number = so.Salesman_Number
inner join salesorderdetails sod on sod.Order_Number = so.Order_Number
where so.Order_Status = 'Successful'
group by s.Salesman_Number
having sum(sod.Order_Quantity) >= 20;

-- 19.	Amount paid and amounted due should not be negative when you are inserting the data. 
ALTER TABLE clients
ADD CONSTRAINT check_amount_paid_non_negative CHECK (
		Amount_Paid >= 0 and Amount_Due >=0
);

-- 20.	Remove the constraint from pincode;
alter table clients drop constraint check_pincode;

-- 21.	The sell price and cost price should be unique.
ALTER TABLE product
ADD CONSTRAINT unique_sell_price UNIQUE (Sell_Price);

ALTER TABLE product
ADD CONSTRAINT unique_cost_price UNIQUE (Cost_Price);

-- 22.	The sell price and cost price should not be unique.
ALTER TABLE product
DROP CONSTRAINT unique_sell_price;

ALTER TABLE product
DROP CONSTRAINT unique_cost_price;

-- 23.	Remove unique constraint from product name.
ALTER TABLE product
ADD CONSTRAINT unique_product_name unique (product_name);

ALTER TABLE product
DROP CONSTRAINT unique_product_name;

-- 24.	Update the delivery status to “Delivered” for the product number P1007.
update SalesOrder so
inner join SalesOrderDetails sod on so.Order_Number = sod.Order_Number
inner join Product p on p.Product_Number = sod.Product_Number
set so.Delivery_Status = 'Delivered'
where p.Product_Number = 'P1007';

-- 25.	Change address and city to ‘Phu Hoa’ and ‘Thu Dau Mot’ where client number is C104.
update clients
set Address = 'Phu Hoa', city = 'Thu Dau Mot'
where Client_Number = 'C104';

-- 26.	Add a new column to “Product” table named as “Exp_Date”, data type is Date.
alter table product
add column Exp_Date date;

-- 27.	Add a new column to “Clients” table named as “Phone”, data type is varchar and size is 15.
alter table clients
add column Phone varchar(15);

-- 28.	Update remarks as “Good” for all salesman.
SET SQL_SAFE_UPDATES = 0;
UPDATE Salesman
SET remark = 'Good';

-- 29.	Change remarks to "bad" whose salesman number is "S004".
update salesman
set remark = 'Bad'
where salesman_number = 'S004';

-- 30.	Modify the data type of “Phone” in “Clients” table with varchar from size 15 to size is 10.
alter table clients
modify phone varchar(10);

-- 31.	Delete the “Phone” column from “Clients” table.
alter table clients
drop column phone;

-- 32.	alter table Clients drop column Phone;
alter table clients
drop column phone;

-- 33.	Change the sell price of Mouse to 120.
update product
set sell_price = 120
where product_name = 'Mouse';

-- 34.	Change the city of client number C104 to “Ben Cat”.
update clients
set city = 'Ben Cat'
where Client_Number = 'C104';

-- 35.	If On_Hand_Quantity greater than 5, then 10% discount. If On_Hand_Quantity greater than 10, then 15% discount. Othrwise, no discount.
update product
set Discount_Rate = case
	when Quantity_On_Hand > 10 then 0.15
    when Quantity_On_Hand > 5 then 0.1
    else 0
end;
