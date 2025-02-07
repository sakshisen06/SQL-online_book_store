create database onlinebookstore;

use onlinebookstore;

-- Basic Questions:

-- query 1 - Retrieve all books in the "Fiction" genre

SELECT 
    *
FROM
    onlinebookstore.books
WHERE
    Genre = 'Fiction';

-- query 2 - Find books published after the year 1950

SELECT 
    *
FROM
    books
WHERE
    Published_Year > 1950;

-- query 3 - List all customers from the Canada
SELECT 
    *
FROM
    customers
WHERE
    country = 'Canada';

-- query 4 - Show orders placed in November 2023

SELECT 
    *
FROM
    orders
WHERE
    Order_Date BETWEEN '2023-11-01' AND '2023-11-30';

-- query 5 - Retrieve the total stock of books available

SELECT 
    SUM(Stock) AS 'total_stock'
FROM
    books;

-- query 6 - Find the details of the most expensive book

SELECT 
    *
FROM
    books
ORDER BY Price DESC
LIMIT 1;

-- query 7 - Show all customers who ordered more than 1 quantity of a book

SELECT 
    Customer_ID, C.Name, O.Quantity
FROM
    customers c
        JOIN
    orders o USING (Customer_ID)
WHERE
    Quantity > 1
ORDER BY Quantity DESC;

-- query 8 - Retrieve all orders where the total amount exceeds $20
SELECT 
    *
FROM
    orders
WHERE
    Total_Amount > 20;

-- query 9 - List all genres available in the Books table

SELECT DISTINCT
    Genre
FROM
    books;

-- query 10 - Find the book with the lowest stock

SELECT 
    *
FROM
    books
ORDER BY Stock ASC;

-- query 11 - Calculate the total revenue generated from all orders

SELECT 
    SUM(Total_Amount) AS 'total_sales'
FROM
    orders;


-- Advance Questions : 

-- query 1 - Retrieve the total number of books sold for each genre:

SELECT 
    Genre, SUM(Quantity)
FROM
    books b
        JOIN
    orders o USING (Book_ID)
GROUP BY Genre;

-- query 2 - Find the average price of books in the "Fantasy" genre:

SELECT 
    AVG(Price) AS 'avg_price'
FROM
    books
WHERE
    Genre = 'Fantasy';

-- query 3 - List customers who have placed at least 2 orders:

SELECT 
    o.Customer_ID, c.Name, COUNT(Order_ID) AS total_count
FROM
    orders o
        JOIN
    customers c ON o.customer_id = c.customer_id
GROUP BY o.Customer_ID , c.Name
HAVING COUNT(Order_ID) >= 2;

-- query 4 - Find the most frequently ordered book:

SELECT 
    o.Book_ID, b.Title, COUNT(Order_ID) AS order_count
FROM
    orders o
        JOIN
    books b USING (Book_ID)
GROUP BY o.Book_ID , b.Title
ORDER BY order_count DESC
LIMIT 1;

-- query 5 - Show the top 3 most expensive books of 'Fantasy' Genre :

SELECT 
    *
FROM
    books
WHERE
    Genre = 'Fantasy'
ORDER BY Price DESC
LIMIT 3;

-- query 6 - Retrieve the total quantity of books sold by each author:

SELECT 
    b.Author, SUM(o.Quantity) AS total_book_sold
FROM
    orders o
        RIGHT JOIN
    books b USING (Book_ID)
GROUP BY b.Author
ORDER BY total_book_sold DESC;

-- query 7 - List the cities where customers who spent over $30 are located:

SELECT DISTINCT
    c.City, Total_Amount
FROM
    orders o
        JOIN
    customers c USING (Customer_ID)
WHERE
    o.Total_Amount > 30;

-- query 8 - Find the customer who spent the most on orders:

SELECT 
    c.Customer_ID, c.Name, SUM(o.Total_Amount) AS Total_Spent
FROM
    orders o
        JOIN
    customers c USING (Customer_ID)
GROUP BY c.Customer_ID , c.Name
ORDER BY Total_Spent DESC;

-- query 9 - Calculate the stock remaining after fulfilling all orders:

SELECT 
    b.Book_ID,
    b.Title,
    b.Price,
    b.stock,
    COALESCE(o.Quantity, 0) AS quantity_1,
    SUM(stock - COALESCE(o.Quantity, 0)) AS left_stock
FROM
    books b
        LEFT JOIN
    orders o USING (book_ID)
GROUP BY b.Book_ID , b.Title , b.Price , b.stock , o.Quantity;
