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
('C107','Nguyen Thanh ','Hoa Phu','Dai An',700023,'Binh Duong',8500,7500),
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
