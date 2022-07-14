SELECT city, phone, country FROM offices;

SELECT * FROM orders where comments like '%fedex%';

SELECT contactFirstName, contactLastName FROM customers ORDER BY contactFirstName DESC;

SELECT * FROM employees where jobTitle like 'sales rep' AND (firstName like '%son%' or lastName like '%son%');

SELECT customerName, contactFirstName, contactLastName FROM orders JOIN customers 
	on orders.customerNumber = customers.customerNumber
	where orders.customerNumber=124;

SELECT * FROM orderdetails JOIN products 
	on orderdetails.productCode = products.productCode;