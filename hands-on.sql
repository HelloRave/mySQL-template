SELECT city, phone, country FROM offices;

SELECT * FROM orders where comments like '%fedex%';

SELECT contactFirstName, contactLastName FROM customers ORDER BY contactFirstName DESC;

SELECT * FROM employees where jobTitle like 'sales rep' AND (firstName like '%son%' or lastName like '%son%');

SELECT customerName, contactFirstName, contactLastName FROM orders JOIN customers 
	on orders.customerNumber = customers.customerNumber
	where orders.customerNumber=124;

SELECT * FROM orderdetails JOIN products 
	on orderdetails.productCode = products.productCode;

-- Question 7
SELECT payments.customerNumber, customerName, sum(amount) FROM payments 
JOIN customers on payments.customerNumber = customers.customerNumber
WHERE country LIKE 'usa'
GROUP BY payments.customerNumber, customerName; -- in the case of repeated customer name

-- Question 8
SELECT state, count(*) FROM employees 
JOIN offices on employees.officeCode = offices.officeCode
WHERE country LIKE 'usa'
GROUP BY state;

-- Question 9 
SELECT customers.customerNumber, customerName, avg(amount) FROM payments
JOIN customers ON payments.customerNumber = customers.customerNumber
GROUP BY customers.customerNumber, customerName;

-- Question 10
SELECT customers.customerNumber, avg(amount) FROM payments
JOIN customers on payments.customerNumber = customers.customerNumber
GROUP BY customers.customerNumber
HAVING sum(amount) >= 10000;

-- Question 11
SELECT orderdetails.productCode, productName, count(*) FROM orderdetails
JOIN products on orderdetails.productCode = products.productCode
GROUP BY orderdetails.productCode, productName
ORDER BY count(*) DESC
LIMIT 10;