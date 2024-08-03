show tables;

select*from customer;

select distinct email from customer;

select * from customer where customer_id between 2 and 4;
select * from customer where customer_id >=2 and customer_id<=4;
select * from `order`, order_detail
where `order`.oder_id = order_detail.order_id;

select * from `order` as o, order_detail as od
where o.order_id = od.order_id;

select order_date from `order`;

select * 
from `order` as o, order_detail as od
where o.order_id = o.order_id and order_date between '2024-07-06' and '2024-07-09';

select * 
from `order` as o, order_detail as od
where o.order_id = o.order_id 
and order_date between '2024-07-06' and '2024-07-09' and price >= 50;

select*
from customer
where customer_name like 'J%';

select*
from customer
where customer_name like '%h';

select*
from customer
where customer_name like '%s%';

select *
from customer 
order by customer_name ASC, email DESC;

-- lấy tất cả những đơn hàng má giá của nó là từ 50-80
select *
from `order` o, order_detail od
where o.order_id = od.order_id
and product_id in (select product_id from product where price>=50 and price <=100);

select * from order_detail where order_id =4; 

select *
from `order` o, order_detail od
where o.order_id = od.order_id
and product_id not in (select product_id from product where price>=50 and price <=100);

select * from customer c inner join `order` o on c.customer_id = o.customer_id;

select *
from customer c, `order` o
where c.customer_id = o.customer_id;

insert into customer(customer_name, email)
values('abcd', 'abcd@gmail.com');

select *
from customer c left join `order` o on c.customer_id = o.customer_id;

select * from `order` c left join customer o on c.customer_id = o.customer_id;

-- select * from `order` o, full join customer c on c.customer_id = o.customer_id;

select * from `order` order by total_amount limit 2;

select * from `order` order by total_amount desc limit 3;

select order_date, customer_id, total_amount
from `order`
where total_amount<=150 
union
select customer_id, order_date, 0 as total_amount
from `order`
where total_amount>200;

create table Order_Customer(
customer_id int,
order_date date
);

select customer_id, order_date into Order_Customer
from `order`
where total_amount>200;

select CUSTOMER_ID, MAX(total_amount) AS TOTAL
from `order`
where total_amount>200
GROUP BY CUSTOMER_ID
HAVING max(total_amount)>300;

select * from product;
select *
from product p
where not exists(select * from order_detail o where p.product_id = o.product_id);

select *
from product p left join order_detail o on p.product_id = o.product_id
where o.product_id is not null;


select * from `order`;
select *
from product p left join (select o.product_id, product_id from `order` o, order_detial od
where o.order_id = od.order_id and order_date between '2024-07-07' and '2024-07-10') as
T on p.product_id = T.product_id
where T.product_id is null;

update customer set email = 'abcd@gmail.com' where customer_id = 3;

-- cập nhật đơn hàng của khách hàng có tên là Alice Johnson với tổng tiền = 100000
update `order` set total_amount = total_amount*1.1 where customer_id in (select customer_id from customer where customer_name = 'Alice Johnson');


-- cap nhat gia sp * 15% va cap nhat lai don hang
update product set price = price * 1.1;

update order_detail o, product as p set o.price = p.price * o.quantity
where o.product_id = p.product_id;

select * from order_detail;

-- delete
select * from customer;

-- xoa nhung khach hang co email bat dau bang chu 'j'    
delete
from customer
where email like 'j%';

delete
from `order`
where customer_id in (select customer_id from customer where email like 'j%');

delete
from order_detail 
where order_id in (select order_id from `order` 
					where customer_id in (select customer_id from customer where email like 'j%'));

-- tao view lay tat ca nhung don hàng, order_id, customer_id, product_id, quantity, price, total
create view AllOrder
as
	select o.order_id, customer_id,product_id, quantity, price, total_amount as total
	from `order` o inner join order_detail od on o.order_id = od.order_id;
    
-- lay ten kh, ten sp
select a.*, c.customer_name, p.product_name
from allorder a inner join customer as c on c.customer_id = a.customer_id
				inner join product as p on a.product_id = p.product_id;
                
drop view allorder;

delimiter //
create procedure GetAllOrderandAllProduct()
begin 
-- all order
	select * from Allorder;
    select * from product;
    
end
//

call GetAllOrderandAllProduct();

select *, case when salary < 15000 then 'Low' else
			case when salary< 20000 then 'medium' else 'high' end end 'note'
from salesman;

-- 10%, 15%, 20%
select *
from salesman;
update  salesman set salary = case when salary >= 20000 then 1.1 else
							case when salary >= 15000 then 1.15 else 1.2 end end * salary;