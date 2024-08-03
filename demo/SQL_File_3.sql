create database shoponline;
use shoponline;
-- Tạo bảng customer
CREATE TABLE `customer` (
    `customer_id` INT AUTO_INCREMENT PRIMARY KEY,
    `customer_name` VARCHAR(255) NOT NULL,
    `email` VARCHAR(255) NOT NULL
);

-- Tạo bảng product
CREATE TABLE `product` (
    `product_id` INT AUTO_INCREMENT PRIMARY KEY,
    `product_name` VARCHAR(255) NOT NULL,
    `price` DECIMAL(10, 2) NOT NULL
);

-- Tạo bảng order
CREATE TABLE `order` (
    `order_id` INT AUTO_INCREMENT PRIMARY KEY,
    `order_date` DATE NOT NULL,
    `customer_id` INT NOT NULL,
    `total_amount` DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (`customer_id`) REFERENCES `customer`(`customer_id`)
);

-- Tạo bảng order_detail
CREATE TABLE `order_detail` (
    `order_detail_id` INT AUTO_INCREMENT PRIMARY KEY,
    `order_id` INT NOT NULL,
    `product_id` INT NOT NULL,
    `quantity` INT NOT NULL,
    `price` DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (`order_id`) REFERENCES `order`(`order_id`),
    FOREIGN KEY (`product_id`) REFERENCES `product`(`product_id`)
);

-- Thêm 5 khách hàng vào bảng customer
INSERT INTO `customer` (`customer_name`, `email`) VALUES
('John Doe', 'john@example.com'),
('Jane Smith', 'jane@example.com'),
('Alice Johnson', 'alice@example.com'),
('Bob Brown', 'bob@example.com'),
('Charlie Davis', 'charlie@example.com');

-- Thêm 10 sản phẩm vào bảng product
INSERT INTO `product` (`product_name`, `price`) VALUES
('Product 1', 10.00),
('Product 2', 20.00),
('Product 3', 30.00),
('Product 4', 40.00),
('Product 5', 50.00),
('Product 6', 60.00),
('Product 7', 70.00),
('Product 8', 80.00),
('Product 9', 90.00),
('Product 10', 100.00);

-- Thêm 10 đơn hàng vào bảng order
INSERT INTO `order` (`order_date`, `customer_id`, `total_amount`) VALUES
('2024-07-01', 1, 100.00),
('2024-07-02', 2, 200.00),
('2024-07-03', 3, 150.00),
('2024-07-04', 4, 250.00),
('2024-07-05', 5, 300.00),
('2024-07-06', 1, 120.00),
('2024-07-07', 2, 220.00),
('2024-07-08', 3, 130.00),
('2024-07-09', 4, 280.00),
('2024-07-10', 5, 350.00);

-- Thêm chi tiết cho các đơn hàng vào bảng order_detail
INSERT INTO `order_detail` (`order_id`, `product_id`, `quantity`, `price`) VALUES
(1, 1, 2, 50.00),
(1, 2, 1, 50.00),
(2, 3, 4, 50.00),
(2, 4, 2, 25.00),
(3, 5, 3, 50.00),
(3, 6, 1, 50.00),
(4, 1, 5, 50.00),
(4, 7, 2, 25.00),
(5, 8, 6, 50.00),
(5, 9, 1, 50.00),
(6, 2, 2, 60.00),
(6, 3, 1, 60.00),
(7, 4, 4, 55.00),
(7, 5, 2, 55.00),
(8, 6, 3, 45.00),
(8, 7, 1, 45.00),
(9, 1, 5, 56.00),
(9, 8, 2, 28.00),
(10, 9, 7, 50.00)
(10, 2, 1, 50.00);
