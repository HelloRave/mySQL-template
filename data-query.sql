-- display all columns
select * from employees;

-- select <column name> from table
select firstName as 'First Name', lastName, email from employees; -- as 'xxx' optional; for renaming purposes only 

-- use where to filter the rows
SELECT * FROM employees where officeCode=1;

-- use LIKE with wildcard to match partial strings 
SELECT * FROM employees where jobTitle like '%sales%';

-- Multiple conditions
SELECT * FROM employees where officeCode=1 AND jobTitle like 'sales rep';

-- OR has lower priority than AND
SELECT * FROM employees where jobTitle like 'sales rep' and (officeCode=1 OR officeCode=2);

-- JOIN tables
SELECT firstName, lastName, city, addressLine1, addressLine2 FROM employees join offices
on employees.officeCode = offices.officeCode
where country like 'usa';

SELECT customerName, firstName, lastName, email, employeeNumber, salesRepEmployeeNumber FROM customers join employees
on customers.salesRepEmployeeNumber = employees.employeeNumber;

SELECT count(*) FROM customers join employees
on customers.salesRepEmployeeNumber = employees.employeeNumber; --innerjoin; omit if on condition not fulfilled
-- left join to show even if customer customer has no sales rep 

-- Multiple JOIN
SELECT customerName as 'Customer Name', firstName, lastName, offices.phone, customers.country from customers join employees
	on customers.salesRepEmployeeNumber = employees.employeeNumber
	JOIN offices on employees.officeCode = offices.officeCode
	where customers.country='USA';

-- Date Manipulation 
SELECT curdate() -- current date on server

SELECT now() -- current date and time 

SELECT * FROM payments where paymentDate > '2003-06-30';

SELECT * FROM payments where paymentDate >= '2003-01-01' AND paymentDate <= '2003-06-31'; 
SELECT * FROM payments where paymentDate BETWEEN '2003-01-01' AND '2003-06-31';

SELECT checkNumber, YEAR(paymentDate) from payments;
SELECT checkNumber, YEAR(paymentDate), MONTH(paymentDate), DAY(paymentDate) from payments where YEAR(paymentDate) = 2003;

-- Aggregate functions
SELECT count(*) FROM employees;

SELECT sum(quantityOrdered) FROM orderdetails; 
SELECT sum(quantityOrdered) FROM orderdetails where productCode='S18_1749';
SELECT sum(quantityOrdered * priceEach) FROM orderdetails where productCode='S18_1749';
SELECT sum(quantityOrdered * priceEach) as 'Total worth ordered' FROM orderdetails where productCode='S18_1749';
SELECT sum(amount) FROM payments where paymentDate BETWEEN '2003-06-01' AND '2003-06-31';
SELECT sum(amount) FROM payments where paymentDate month(paymentDate)=6 and year(paymentDate)=2003;

-- Group By 
SELECT country, count(*) FROM customers group by country; -- to select the column that is grouped by and AGGREGATE function
SELECT country, avg(creditLimit) FROM customers group by country;

SELECT country, firstName, lastName, email, avg(creditLimit), count(*) from customers
JOIN employees on customers.salesRepEmployeeNumber = employees.employeeNumber
WHERE salesRepEmployeeNumber = 1504
GROUP BY country, firstName, lastName, email
ORDER BY avg(creditLimit)
LIMIT 3

SELECT * FROM orders
WHERE orderDate BETWEEN '2003-01-01' AND '2003-12-31';