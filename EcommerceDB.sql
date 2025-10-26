create database test;
use test;
drop database test;
-- Users table
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

select * from users;
drop table users;

-- Categories table
CREATE TABLE categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

drop table categories;
select * from categories;


-- Products table
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    image_url VARCHAR(500),
    category_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

-- Insert sample data
INSERT INTO categories (name, description) VALUES 
('Electronics', 'Electronic devices and gadgets'),
('Clothing', 'Clothing and fashion items'),
('Books', 'Books and educational materials');

INSERT INTO products (name, description, price, image_url) VALUES
('Samsung Galaxy S24 Ultra', 'Flagship smartphone with 200MP quad camera, 120Hz AMOLED display, 5G support', 79999, 'https://images.unsplash.com/photo-1658622343627-71c35f747aa5?w=400'),
('Apple iPhone 15 Pro', 'iOS flagship with A17 Pro chip, titanium frame, pro camera system', 139999, 'https://images.unsplash.com/photo-1695048134246-4767e4d2e9b4?w=400'),
('Sony WH-1000XM5', 'Premium over-ear noise cancelling headphones with long battery life', 29990, 'https://images.unsplash.com/photo-1516728778615-2d590ea1856f?w=400'),
('Bose QuietComfort Ultra', 'Luxury ANC headphones with spatial audio and immersive sound', 34990, 'https://images.unsplash.com/photo-1598970434795-0c54fe7c0642?w=400'),
('OnePlus 12', 'High-performance smartphone with 150W fast charging and flagship specs', 69999, 'https://images.unsplash.com/photo-1641335863091-92da2be72d73?w=400'),
('Dell XPS 15 (2024)', 'Premium laptop with 4K OLED display, Intel i9, and RTX series GPU', 239999, 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=400'),
('MacBook Air M3', 'Lightweight Apple laptop with M3 chip and long battery backup', 159999, 'https://images.unsplash.com/photo-1587829741301-dc798b83add3?w=400'),
('LG OLED C3 55"', '55-inch 4K OLED smart TV with Dolby Vision and WebOS platform', 129999, 'https://images.unsplash.com/photo-1606813909027-472cda4a4a6c?w=400'),
('Samsung Frame TV 50"', 'Art mode TV that can display paintings when off, ideal for living rooms', 99999, 'https://images.unsplash.com/photo-1606813909027-472cda4a4a6c?w=400'),
('Dyson V15 Detect', 'Cordless vacuum with laser dust detection and strong suction', 74999, 'https://images.unsplash.com/photo-1628771065518-0d82f193a3f0?w=400'),
('iRobot Roomba i4+', 'Smart robot vacuum with self-empty base and app control', 44999, 'https://images.unsplash.com/photo-1628771065518-0d82f193a3f0?w=400'),
('Philips Air fryer XXL', 'Hot air fryer with touch display and multiple presets', 13999, 'https://images.unsplash.com/photo-1617196034796-73f1e4c1e3d4?w=400'),
('Instant Pot Duo 8L', 'Multifunction pressure cooker, slow cook, sauté, steam in one appliance', 12499, 'https://images.unsplash.com/photo-1617196034796-73f1e4c1e3d4?w=400'),
('Nikon Z5 Mirrorless', 'Full-frame mirrorless camera with 4K video and dual card slots', 169999, 'https://images.unsplash.com/photo-1519183071298-a2962be96c83?w=400'),
('Canon EOS R50', 'Mirrorless camera suitable for vloggers & photographers, amazing low-light performance', 119999, 'https://images.unsplash.com/photo-1519183071298-a2962be96c83?w=400'),
('Fitbit Charge 6', 'Advanced fitness band with SpO2, ECG, sleep & stress tracking', 17999, 'https://images.unsplash.com/photo-1613470206071-8dc07c79ea2b?w=400'),
('Garmin Forerunner 965', 'Premium multisport GPS watch with mapping and triathlon features', 49999, 'https://images.unsplash.com/photo-1613470206071-8dc07c79ea2b?w=400'),
('Nike Air Zoom Pegasus 40', 'Versatile running shoes with responsive cushioning and durable outsole', 14999, 'https://images.unsplash.com/photo-1600180758890-6c3eae5c3be6?w=400'),
('Adidas Ultraboost Light', 'Lightweight running shoes with Boost technology for high energy return', 17999, 'https://images.unsplash.com/photo-1528701800489-20be7e2e7e43?w=400'),
('Ray-Ban Wayfarer Sunglasses', 'Iconic frame with UV protection lenses, perfect for daily wear', 12999, 'https://images.unsplash.com/photo-1530985409734-4a0c43d6f50c?w=400'),
('Levi’s 511 Slim Fit Jeans', 'Men’s denim in slim silhouette, stretch fabric', 4999, 'https://images.unsplash.com/photo-1512436991641-6745cdb1723f?w=400'),
('H&M Cotton T-Shirt (Pack of 3)', 'Basic crew neck t-shirts in assorted colors, comfortable cotton', 1399, 'https://images.unsplash.com/photo-1520975925253-3d0dc79861a9?w=400'),
('Samsung Galaxy Tab S9', 'High-end tablet with S Pen support and AMOLED display', 79999, 'https://images.unsplash.com/photo-1585792180666-cb52f5a3b6b2?w=400'),
('Apple iPad Mini (6th Gen)', 'Compact iPad with powerful chip and high-resolution display', 44999, 'https://images.unsplash.com/photo-1585792180666-cb52f5a3b6b2?w=400'),
('LG Refrigerator GL-I292RPZX', 'Double door refrigerator with smart inverter and frost-free cooling', 36990, 'https://images.unsplash.com/photo-1598032897853-7141fc9635f7?w=400'),
('Whirlpool Washing Machine 7kg', 'Front load washing machine with 6th Sense technology', 27990, 'https://images.unsplash.com/photo-1581579186940-f4e2a12b45d0?w=400'),
('Blue Star AC 1.5 Ton Inverter', 'Split AC with dual inverter and anti-bacterial filter', 49990, 'https://images.unsplash.com/photo-1591462562456-2be6d6399638?w=400'),
('Philips Hue White & Color Bulb', 'Smart LED bulb with color changing and app control', 3999, 'https://images.unsplash.com/photo-1601987077677-434b0d89a5b7?w=400'),
('Sony PlayStation 5', 'Next-gen gaming console with blazing fast SSD and immersive gameplay', 54999, 'https://images.unsplash.com/photo-1606813909027-472cda4a4a6c?w=400');


drop table products;
select * from products;

/*THANK YOU*/


