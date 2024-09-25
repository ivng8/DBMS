
-- 24f - CS 3200 - Introduction to Databases - Homework 02

-- Put your name here: Ivan Ng


-- Put your solution to Question 2 here.
SELECT officeCode, city, country
FROM offices
WHERE NOT country = 'USA'
ORDER BY country DESC;

-- Put your solution to Question 3 here.
SELECT productCode, productName, quantityInStock, productVendor, buyPrice
FROM products
WHERE quantityInStock < 600
ORDER BY quantityInStock;

-- Put your solution to Question 4 here.
SELECT customerName, creditLimit
FROM customers
WHERE creditLimit > 100000
ORDER BY creditLimit DESC;

-- Put your solution to Question 5 here.
SELECT c.state, ROUND(AVG(p.amount), 2)
FROM customers as c NATURAL JOIN payments as p
WHERE c.country = 'USA'
GROUP BY c.state
ORDER BY c.state;

-- Put your solution to Question 6 here.
SELECT productCode, productName, buyPrice, MSRP, (MSRP - buyPrice) as priceDifference
FROM products
WHERE (MSRP - buyPrice) > 75
ORDER BY priceDifference DESC;


-- Put your solution to Question 7 here.
SELECT DISTINCT c.customerName, c.contactLastName, c.contactFirstName, c.phone
FROM customers as c
NATURAL JOIN orders
NATURAL JOIN orderdetails
NATURAL JOIN products
WHERE products.productVendor = 'Red Start Diecast' AND c.country IN ('France', 'Australia')
ORDER BY c.customerName;


-- Put your solution to Question 8 here.
SELECT e.lastName, e.firstName, COUNT(c.customerNumber)
FROM employees as e JOIN customers as c ON e.employeeNumber = c.salesRepEmployeeNumber
GROUP BY e.lastName, e.firstName
ORDER BY e.lastName, e.firstName;


-- Put your solution to Question 9 here.
SELECT DISTINCT lastName, firstName, email, jobTitle
FROM employees as e
WHERE NOT EXISTS (
    SELECT TRUE
    FROM customers as c
    WHERE c.salesRepEmployeeNumber = e.employeeNumber
)
ORDER BY lastName, firstName;


-- Put your solution to Question 10 here.
