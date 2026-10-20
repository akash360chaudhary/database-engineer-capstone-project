/*Task 1
In the first task, create a virtual table called OrdersView that focuses on OrderID, Quantity and Cost columns within the Orders table for all orders with a quantity greater than 2. 
*/
CREATE VIEW OrdersView AS
SELECT
	OrderID,
    Quantity,
    TotalCost AS Cost
FROM Orders
WHERE Quantity > 2;

-- Call the view
SELECT * FROM OrdersView;



/*
Task 2
For your second task, need information from four tables on all customers with orders that cost more than $150. Extract the required information from each of the following tables by using the relevant JOIN clause:
Customers table: The customer id and full name.

Orders table: The order id and cost.

Menus table: The menus name.

MenusItems table: the item’s name and category (e.g., starter, main, dessert, drink).
*/

SELECT
	c.CustomerID,
    c.CustomerName AS FullName,
    o.OrderID,
    o.TotalCost AS Cost,
    m.ItemName,
    mi.CourseName,
    mi.StarterName
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN Menus m ON o.MenuID = m.MenuID
JOIN MenuItems mi ON m.MenuItemsID = mi.MenuItemsID
WHERE o.TotalCost > 150
ORDER BY o.TotalCost ASC;



/*
Task 3
For the third and final task, need you to find all menu items for which more than 2 orders have been placed using a subquery. You can carry out this task by creating a subquery that lists the menu names from the menus table for any order quantity with more than 2.
*/

SELECT
	ItemName as MenuName
FROM Menus
WHERE MenuID = ANY(
	SELECT MenuID
    FROM Orders
    WHERE Quantity > 2
);