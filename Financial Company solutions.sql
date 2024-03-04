--1)Write a SQL query to retrieve the product_id, product_name, unit_price, and stock_quantity for all products in the "Laptops" category.
SELECT product_id,product_name,unit_price,stock_quantity
FROM Techmart.products
WHERE category_id=(
SELECT category_id FROM Techmart.categories
WHERE category_name='Laptops');

--2)Write a SQL query to determine the top 3 product categories based on the total quantity of products sold. The result should include the category_id, category_name, and the total quantity sold across all orders.
SELECT c.category_id,c.category_name,p."Quantity_Sold" FROM (
SELECT category_id,SUM(stock_quantity) AS "Quantity_Sold"
FROM Techmart.products
GROUP BY category_id
ORDER BY "Quantity_Sold" DESC
LIMIT 3) AS p
INNER JOIN Techmart.categories AS c
ON p.category_id=c.category_id;

--3)Write a SQL query that shows the order_id, order_date, product_id, product_name, and quantity for each product purchased by a specific customer with customer_id = 5001.
SELECT z.order_id,z.order_date,z.product_id,k.product_name,z.quantity FROM(
SELECT x.order_id,x.order_date,y.product_id,y.quantity FROM( 
SELECT * FROM Techmart.orders
WHERE customer_id=5001) AS x
INNER JOIN Techmart.order_items AS y
ON x.order_id=y.order_id) AS z
INNER JOIN Techmart.products AS k
ON z.product_id=k.product_id;



--6)Write a SQL query to rank TechMarts customers based on their total spending (sum of total_price) in descending order. The result should display the customer_id and their respective rank.
SELECT customer_id,RANK() OVER(ORDER BY Sum_of_totalprice DESC) FROM (
SELECT customer_id,SUM(total_price) AS Sum_of_totalprice FROM(
SELECT * FROM Techmart.order_items AS oi
JOIN Techmart.orders AS o
ON oi.order_id=o.order_id)
GROUP BY customer_id
ORDER BY Sum_of_totalprice DESC);

--7)Write a SQL query that suggests three product recommendations to customers who have purchased products in the "Smartphones" category. The recommendations should be based on the purchasing history of other customers who bought products from the same category
SELECT z.product_id,k.product_name,z.sum AS "Sum_of_quantity" FROM(
SELECT x.product_id,SUM(y.quantity) FROM(
SELECT * FROM 
Techmart.products
WHERE category_id=(SELECT category_id FROM Techmart.categories
WHERE category_name='Smartphones')) AS x
INNER JOIN Techmart.order_items AS y
ON x.product_id=y.product_id
GROUP BY x.product_id
ORDER BY SUM(y.quantity) DESC) AS z
INNER JOIN Techmart.products AS k
ON z.product_id=k.product_id;



















