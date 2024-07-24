create database ManagementProject;
use ManagementProject;

create table EMPLOYEE(
	employeeID varchar(3) primary key,
    lastName varchar(20) not null,
    middleName varchar(20),
    firstName varchar(20) not null,
    dateOfBirth date not null,
    gender varchar(5) not null,
    salary decimal not null,
    address varchar(100) not null,
    managerID varchar(3),
    departmentID int not null
);

INSERT INTO EMPLOYEE (employeeID, lastName, middleName, firstName, dateOfBirth, gender, salary, address, managerID, departmentID) VALUES
(123, 'Dinh', 'Ba', 'Tien', '1995-01-09', 'Nam', 30000, '731 Tran Hung Dao Q1 TPHCM', 333, 5),
(333, 'Nguyen', 'Thanh', 'Tung', '1945-12-08', 'Nam', 40000, '638 Nguyen Van Cu Q5 TPHCM', 888, 5),
(453, 'Tran', 'Thanh', 'Tam', '1962-07-31', 'Nam', 25000, '543 Mai Thi Luu Ba Dinh Ha Noi', 333, 5),
(666, 'Nguyen', 'Manh', 'Hung', '1952-09-15', 'Nam', 38000, '975 Le Lai P3 Vung Tau', 333, 5),
(777, 'Tran', 'Hong', 'Quang', '1959-03-29', 'Nam', 25000, '980 Le Hong Phong Vung Tau', 987, 4),
(888, 'Vuong', 'Ngoc', 'Quyen', '1927-10-10', 'Nu', 55000, '450 Trung Vuong My Tho TG', NULL, 1),
(987, 'Le', 'Thi', 'Nhan', '1931-06-20', 'Nu', 43000, '291 Ho Van Hue Q.PN TPHCM', 888, 4),
(999, 'Bui', 'Thuy', 'Vu', '1958-07-19', 'Nam', 25000, '332 Nguyen Thai Hoc Quy Nhon', 987, 4);

create table DEPARTMENT(
	departmentID int primary key,
    departmentName varchar(10) not null,
    managerID varchar(3) not null,
    dateOfEmployment date not null,
    foreign key (managerID) references EMPLOYEE (employeeID)
);

INSERT INTO department (departmentID, departmentName, managerID, dateOfEmployment) VALUES
(1, 'Quan ly', '888', '1971-06-19'),
(4, 'Dieu hanh', '777', '1985-01-01'),
(5, 'Nghien cuu', '333', '1978-05-22');

create table DEPARTMENTADDRESS (
	departmentID int not null,
    address varchar(30),
    primary key (departmentID, address),
    foreign key (departmentID) references DEPARTMENT (departmentID)
);

INSERT INTO departmentaddress (departmentID, address) VALUES
(1, 'TP HCM'),
(4, 'HA NOI'),
(5, 'NHA TRANG'),
(5, 'TP HCM'),
(5, 'VUNG TAU');

create table PROJECTS(
	projectID int primary key,
    projectName varchar(30) not null,
    projectAddress varchar(100) not null,
    departmentID int not null,
    foreign key (departmentID) references DEPARTMENT (departmentID)
);

INSERT INTO projects (projectID, projectName, projectAddress, departmentID) VALUES
(1, 'San pham X', 'VUNG TAU', 5),
(2, 'San pham Y', 'NHA TRANG', 5),
(3, 'San pham Z', 'TP HCM', 5),
(10, 'Tin hoc hoa', 'HA NOI', 4),
(20, 'Cap Quang', 'TP HCM', 1),
(30, 'Dao tao', 'HA NOI', 4);

create table ASSIGNMENT (
	employeeID varchar(3) not null,
    projectID int not null,
    workingHour float not null,
    primary key (employeeID, projectID),
    foreign key (employeeID) references employee (employeeID),
    foreign key (projectID) references projects (projectID)
);

INSERT INTO ASSIGNMENT (employeeID, projectID, workingHour) VALUES
(123, 1, 22.5),
(123, 2, 7.5),
(123, 3, 10),
(333, 10, 10),
(333, 20, 10),
(453, 1, 20),
(453, 2, 20),
(666, 3, 40),
(888, 20, 0),
(987, 20, 15);

create table RELATIVE (
	employeeID varchar(3),
    relativeName varchar(50),
    gender varchar(5) not null,
    dateOfBirth date null,
    relationship varchar(30) not null,
    primary key (employeeID, relativeName),
    foreign key (employeeID) references employee(employeeID)
);

INSERT INTO RELATIVE (employeeID, relativeName, gender, dateOfBirth, relationship) VALUES
(123, 'Chau', 'Nu', '1978-12-31', 'Con gai'),
(123, 'Duy', 'Nam', '1978-01-01', 'Con trai'),
(123, 'Phuong', 'Nu', '1957-05-05', 'Vo chong'),
(333, 'Duong', 'Nu', '1948-05-03', 'Vo chong'),
(333, 'Quang', 'Nu', '1976-04-05', 'Con gai'),
(333, 'Tung', 'Nam', '1973-10-25', 'Con trai'),
(987, 'Dang', 'Nam', '1932-02-29', 'Vo chong');

alter table EMPLOYEE
add foreign key (managerID) references employee (employeeID);

alter table EMPLOYEE
add foreign key (departmentID) references department (departmentID);
