-- 1. Create Database as ecommerce
CREATE DATABASE ecommerce;
USE ecommerce;

-- 2. Create 4 tables (gold_member_users, users, sales, product) under the above database(ecommerce)
CREATE TABLE gold_member_users (
    userid VARCHAR(50),
    signup_date DATE
);
CREATE TABLE users (
    userid VARCHAR(50),
    signup_date DATE
);
CREATE TABLE sales (
    userid VARCHAR(50),
    created_date DATE,
    product_id INT
);
CREATE TABLE product (
    product_id INT,
    product_name VARCHAR(50),
    price DECIMAL(10, 2)
);

-- 3. Insert the values provided above with respective datatypes
INSERT INTO gold_member_users (userid, signup_date)
VALUES('John', '2017-09-22'),('Mary', '2017-04-21');
INSERT INTO users (userid, signup_date)
VALUES('John', '2014-09-02'),('Michel', '2015-01-15'),('Mary', '2014-04-11');
INSERT INTO sales (userid, created_date, product_id)
VALUES('John', '2017-04-19', 2),('Mary', '2019-12-18', 1),('Michel', '2020-07-20', 3),('John', '2019-10-23', 2),('John', '2018-03-19', 3),
('Mary', '2016-12-20', 2),('John', '2016-11-09', 1),('John', '2016-05-20', 3),('Michel', '2017-09-24', 1),('John', '2017-03-11', 2),('John', '2016-03-11', 1),
('Mary', '2016-11-10', 1),('Mary', '2017-12-07', 2);
INSERT INTO product (product_id, product_name, price)
VALUES(1, 'Mobile', 980),(2, 'Ipad', 870),(3, 'Laptop', 330);

-- 4.Show all the tables in the same database(ecommerce)
USE ecommerce;
SELECT TABLE_NAME 
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_TYPE = 'BASE TABLE';

-- 5.Count all the records of all four tables using single query
SELECT 'gold_member_users' AS table_name, COUNT(*) AS record_count 
FROM gold_member_users
UNION ALL
SELECT 'users', COUNT(*) 
FROM users
UNION ALL
SELECT 'sales', COUNT(*) 
FROM sales
UNION ALL
SELECT 'product', COUNT(*) 
FROM product;

-- 6.What is the total amount each customer spent on ecommerce company
SELECT s.userid, SUM(p.price) AS total_spent
FROM sales s
JOIN product p ON s.product_id = p.product_id
GROUP BY s.userid;

-- 7.Find the distinct dates of each customer visited the website: output should have 2 columns date and customer name
SELECT DISTINCT s.created_date AS date, s.userid AS customer_name
FROM sales s
ORDER BY s.userid, s.created_date;

-- 8.Find the first product purchased by each customer using 3 tables(users, sales, product)
SELECT u.userid, p.product_name, MIN(s.created_date) AS first_purchase_date
FROM users u
JOIN sales s ON u.userid = s.userid
JOIN product p ON s.product_id = p.product_id
GROUP BY u.userid, p.product_name;

-- 9.What is the most purchased item of each customer and how many times the customer has purchased it: output should have 2 columns count of the items as item_count and customer name
SELECT userid,COUNT(product_name) AS item_count
FROM sales
JOIN product ON sales.product_id=product.product_id
GROUP BY userid
ORDER by item_count DESC;

-- 10.Find out the customer who is not the gold_member_user
SELECT u.userid
FROM users u
LEFT JOIN gold_member_users gm ON u.userid = gm.userid
WHERE gm.userid IS NULL;

-- 11.What is the amount spent by each customer when he was the gold_member user
SELECT s.userid, SUM(p.price) AS total_spent_as_gold_member
FROM sales s
JOIN product p ON s.product_id = p.product_id
JOIN gold_member_users gm ON s.userid = gm.userid
WHERE s.created_date >= gm.signup_date
GROUP BY s.userid;

-- 12.Find the Customers names whose name starts with M
SELECT userid
FROM users
WHERE userid LIKE 'M%';

-- 13.Find the Distinct customer Id of each customer
SELECT DISTINCT userid
FROM users;

-- 14.Change the Column name from product table as price_value from price
EXEC sp_rename 'product.price', 'price_value', 'COLUMN';

-- 15.Change the Column value product_name – Ipad to Iphone from product table
UPDATE product
SET product_name = 'Ipad'
WHERE product_name = 'Iphone';

-- 16.Change the table name of gold_member_users to gold_membership_users
EXEC sp_rename 'gold_member_users', 'gold_membership_users';

-- 17.Create a new column  as Status in the table crate above gold_membership_users  the Status values should be 2 Yes and No if the user is gold member, then status should be Yes else No.
ALTER TABLE gold_membership_users
ADD Status VARCHAR(3) DEFAULT 'NO';
-- For non-gold members (users not in gold_membership_users), you can update this in another query if necessary.

-- 18.Delete the users_ids 1,2 from users table and roll the back changes once both the rows are deleted one by one mention the result when performed roll back
BEGIN TRANSACTION;
DELETE FROM users WHERE userid='John';
ROLLBACK
BEGIN TRANSACTION;
DELETE FROM users WHERE userid='Mary'
ROLLBACK

-- 19.Insert one more record as same (3,'Laptop',330) as product table
INSERT INTO product VALUES(3,'Laptop',330);

-- 20.Write a query to find the duplicates in product table
SELECT product_id, COUNT(*) AS duplicates
FROM product
GROUP BY product_id
HAVING COUNT(*) > 1; 







