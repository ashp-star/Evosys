--QUERIES

SELECT name
FROM customers;
  

SELECT customer_id,name,credit_limit
FROM customers;
    

SELECT customer_id,name,address,website,credit_limit
FROM customers;


SELECT name, address, credit_limit
FROM customers
ORDER BY name ASC;

SELECT name, address, credit_limit
FROM customers
ORDER BY name DESC;

SELECT first_name,last_name
FROM contacts
ORDER BY first_name,last_name DESC;

SELECT name, credit_limit
FROM customers
ORDER BY 2 DESC,1;

SELECT country_id, city,state
FROM locations
ORDER BY city, state;

SELECT country_id,city,state
FROM locations
ORDER BY state ASC NULLS FIRST;

SELECT country_id, city, state 
FROM locations 
ORDER BY state ASC NULLS LAST;

SELECT customer_id,name
FROM customers
ORDER BY UPPER( name );

SELECT order_id, customer_id, status, order_date
FROM orders
ORDER BY order_date DESC;

SELECT first_name
FROM contacts
ORDER BY first_name; 

SELECT DISTINCT first_name
FROM contacts
ORDER BY first_name;

SELECT DISTINCT product_id,quantity
FROM ORDER_ITEMS
ORDER BY product_id;

SELECT DISTINCT state
FROM locations
ORDER BY state NULLS FIRST;

SELECT product_name,description,list_price,category_id
FROM products
WHERE product_name = 'Kingston';

SELECT product_name,list_price
FROM products
WHERE list_price > 500;

SELECT product_name,list_price
FROM products
WHERE list_price > 500 AND category_id = 4;

SELECT product_name, list_price
FROM products
WHERE list_price BETWEEN 650 AND 680
ORDER BY list_price;

SELECT product_name,category_id
FROM products
WHERE category_id IN(1, 4)
ORDER BY product_name;



SELECT product_name, list_price
FROM products
WHERE product_name LIKE 'Asus%'
ORDER BY list_price;

SELECT first_name,last_name
FROM employees
ORDER BY first_name;

SELECT first_name "Forename", last_name "Surname"
FROM employees; 

SELECT first_name "First Name",last_name "Family Name"
FROM employees;

SELECT first_name  || ' '  || last_name
FROM employees;

SELECT first_name  || ' '  || last_name AS "Full Name"
FROM employees;

SELECT product_name,list_price - standard_cost AS gross_profit
FROM products;

SELECT product_name,list_price - standard_cost AS gross_profit
FROM products
ORDER BY gross_profit DESC;

SELECT order_id,customer_id,status,order_date
FROM orders
WHERE status = 'Pending' AND customer_id = 2
ORDER BY order_date;

SELECT order_id,customer_id,status,order_date
FROM orders
WHERE status = 'Shipped' AND salesman_id = 60 AND EXTRACT(YEAR FROM order_date) = 2017
ORDER BY order_date;

SELECT order_id, customer_id,status,salesman_id,order_date
FROM orders
WHERE (status = 'Canceled' OR status = 'Pending')AND customer_id = 44
ORDER BY order_date;

SELECT order_id,customer_id,status,order_date
FROM orders
WHERE status = 'Pending' OR status = 'Canceled'
ORDER BY order_date DESC;

SELECT order_id, customer_id,status,salesman_id,order_date
FROM orders
WHERE salesman_id = 60 OR salesman_id = 61 OR salesman_id = 62
ORDER BY order_date DESC;

SELECT order_id,customer_id,status,salesman_id,order_date
FROM orders
WHERE salesman_id IN(60,61,62)
ORDER BY order_date DESC;

SELECT order_id,customer_id,status,salesman_id,order_date
FROM orders
WHERE(status = 'Canceled'  OR status = 'Pending')AND customer_id = 44
ORDER BY order_date;

SELECT product_name,standard_cost
FROM products
WHERE standard_cost BETWEEN 500 AND 600
ORDER BY standard_cost;

SELECT
    order_id,
    customer_id,
    status,
    order_date
FROM
    orders
WHERE
    order_date BETWEEN DATE '2016-12-01' AND DATE '2016-12-31'
ORDER BY
    order_date;

SELECT
    order_id,
    customer_id,
    status,
    salesman_id
FROM
    orders
WHERE
    salesman_id IN (
        54,
        55,
        56
    )
ORDER BY
    order_id;
    
    SELECT
    order_id,
    customer_id,
    status,
    salesman_id
FROM
    orders
WHERE
    status IN(
        'Pending',
        'Canceled'
    )
ORDER BY
    order_id;
    
    SELECT
    order_id,
    customer_id,
    status,
    salesman_id
FROM
    orders
WHERE
    status NOT IN(
        'Shipped',
        'Canceled'
    )
ORDER BY
    order_id;
    
SELECT
    employee_id,
    first_name,
    last_name
FROM
    employees
WHERE
    employee_id IN(
        SELECT
            DISTINCT salesman_id
        FROM
            orders
        WHERE
            status = 'Canceled'
    )
ORDER BY
    first_Name;
    
SELECT
	DISTINCT salesman_id
FROM
	orders
WHERE
	status = 'Canceled';
    
SELECT
    first_name,
    last_name,
    phone
FROM
    contacts
WHERE
    last_name LIKE 'St%'
ORDER BY
    last_name;
    
SELECT
    first_name,
    last_name,
    phone
FROM
    contacts
WHERE
    last_name LIKE '%er'
ORDER BY
    last_name;
    
SELECT
    first_name,
    last_name,
    email,
    phone
FROM
    contacts
WHERE
    first_name LIKE 'Je_%';
    
CREATE TABLE discounts
  (
    product_id NUMBER, 
    discount_message VARCHAR2( 255 ) NOT NULL,
    PRIMARY KEY( product_id )
  );


INSERT INTO discounts(product_id, discount_message)
VALUES(1,
       'Buy 1 and Get 25% OFF on 2nd ');

INSERT INTO discounts(product_id, discount_message)
VALUES(2,
       'Buy 2 and Get 50% OFF on 3rd ');


INSERT INTO discounts(product_id, discount_message)
VALUES(3,
       'Buy 3 Get 1 free');

SELECT
	product_id,
	discount_message
FROM
	discounts
WHERE
	discount_message LIKE '%25!%%' ESCAPE '!';
    
    
SELECT product_id,product_name,list_price
FROM products
WHERE list_price = (SELECT MAX( list_price )FROM products);

SELECT product_name,list_price,ROUND((SELECT AVG( list_price )FROM products p1
WHERE p1. category_id = p2.category_id),2) avg_list_price
FROM products p2
ORDER BY product_name;

SELECT order_id,order_value
FROM(SELECT order_id, SUM( quantity * unit_price ) order_value
FROM order_items
GROUP BY  order_id
        ORDER BY
            order_value DESC
    )
FETCH FIRST 10 ROWS ONLY; 

SELECT
    product_id,
    product_name,
    list_price
FROM
    products
WHERE
    list_price > (
        SELECT
            AVG( list_price )
        FROM
            products
    )
ORDER BY
    product_name;
    
SELECT
    name
FROM
    customers
WHERE
    customer_id NOT IN(
        SELECT
            customer_id
        FROM
            orders
        WHERE
            EXTRACT(
                YEAR
            FROM
                order_date) = 2017
            
    )
ORDER BY
    name; 

SELECT
    product_id,
    product_name,
    list_price
FROM
    products
WHERE
    list_price =(
        SELECT
            MIN( list_price )
        FROM
            products
    );
    
SELECT
    MIN( list_price )
FROM
    products;

SELECT
    product_id,
    product_name,
    list_price
FROM
    products p
WHERE
    list_price > (
        SELECT
            AVG( list_price )
        FROM
            products
        WHERE
            category_id = p.category_id
    );

SELECT
    product_id,
    product_name,
    standard_cost,
    ROUND(
        (
            SELECT
                AVG( standard_cost )
            FROM
                products
            WHERE
                category_id = p.category_id
        ),
        2
    ) avg_standard_cost
FROM
    products p
ORDER BY
    product_name;


SELECT
    customer_id,
    name
FROM
    customers
WHERE
    NOT EXISTS (
        SELECT
            *
        FROM
            orders
        WHERE
            orders.customer_id = customers.customer_id
    )
ORDER BY
    name;