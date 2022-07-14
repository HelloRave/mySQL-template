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