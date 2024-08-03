use salemanagement;

-- 1.	Create a trigger before_total_quantity_update to update total quantity of product when Quantity_On_Hand and Quantity_sell change values. Then Update total quantity when Product P1004 have Quantity_On_Hand = 30, quantity_sell =35.
DELIMITER $$
CREATE TRIGGER before_total_quantity_update
BEFORE UPDATE ON product
FOR EACH ROW
BEGIN
	SET NEW.total_quantity = NEW.Quantity_On_Hand + NEW. Quantity_Sell;
END $$
DELIMITER ;

UPDATE product
SET Quantity_On_Hand = 30, Quantity_Sell = 35 WHERE Product_Number = 'P1004';

UPDATE product
SET Quantity_On_Hand = 20, Quantity_Sell = 15 WHERE Product_Number = 'P1003';

-- 2.	Create a trigger before_remark_salesman_update to update Percentage of per_remarks in a salesman table (will be stored in PER_MARKS column) : per_remarks = target_achieved*100/sales_target.
alter table salesman
add column per_marks decimal(15,2);

DELIMITER $$
CREATE TRIGGER before_remark_salesman_update
BEFORE UPDATE ON salesman
FOR EACH ROW
BEGIN
	if new.Sales_Target > 0 then
		set new.per_marks = (new.Target_Achieved * 100)/new.Sales_Target;
        else
        set new.per_marks = 0;
        end if;
END $$
DELIMITER ;

select * from salesman;

update salesman
set per_marks = (target_achieved * 100)/sales_target;

update salesman
set target_achieved = 80, sales_target = 100 where salesman_number = 'S008';

update salesman
set target_achieved = 75, sales_target = 50 where salesman_number = 'S008';
-- 3.	Create a trigger before_product_insert to insert a product in product table.
delimiter $$
create trigger before_product_insert
before insert on product
for each row
begin
	declare profit_percent decimal (5,2);
    set profit_percent = (new.Sell_Price-new.Cost_Price)*100/new.Cost_Price;
    if profit_percent < 30 then 
		signal SQLSTATE '45000'
        set message_text = 'Profit percentage must be more than and equal 30%';
	end if;
end $$
delimiter ;

-- 4.	Create a trigger to update the delivery status to "Delivered" when an order is marked as "Shipped".
-- 5.	Create a trigger to update the remarks for all salesmen to "Good" when a new salesman is inserted.
-- 6.	Create a trigger to enforce that the first digit of the pin code in the "Clients" table must be 7.
-- 7.	Create a trigger to update the city for a specific client to "Unknown" when the client is deleted.
-- 8.	Create a trigger to update the delivery status to "Cancelled" for corresponding order details when an order is cancelled.
-- 9.	Create a trigger to update the delivery status to "Pending" for a specific order when an order is inserted
-- 10.	Create a trigger before_remark_salesman_update to update Percentage of per_remarks in a salesman table (will be stored in PER_MARKS column)  If  per_remarks >= 75%, his remarks should be ‘Good’. If 50% <= per_remarks < 75%, he is labeled as 'Average'. If per_remarks <50%, he is considered 'Poor'.
