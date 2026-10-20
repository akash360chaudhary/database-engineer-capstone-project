-- Select Database
USE littlelemondb;

/*
Task 1
In this first task, we need you to create a procedure that displays the maximum ordered quantity in the Orders table. 

Creating this procedure will allow Little Lemon to reuse the logic implemented in the procedure easily without retyping the same code over again and again to check the maximum quantity. 

You can call the procedure GetMaxQuantity and invoke it as follows:
*/
DELIMITER //
CREATE PROCEDURE GetMaxQuantity()
BEGIN
	SELECT MAX(Quantity) AS 'Max Quantity in order'
	FROM orders;
END //
DELIMITER ;

-- Call GetMaxQuantity Procedure
CALL GetMaxQuantity();




/*
Task 2
In the second task, Little Lemon need you to help them to create a prepared statement called GetOrderDetail. This prepared statement will help to reduce the parsing time of queries. It will also help to secure the database from SQL injections.

The prepared statement should accept one input argument, the CustomerID value, from a variable. 

The statement should return the order id, the quantity and the order cost from the Orders table. 

Once you create the prepared statement, you can create a variable called id and assign it value of 1. 
*/

PREPARE GetOrderDetail FROM 'SELECT OrderID, Quantity, TotalCost FROM Orders WHERE CustomerID = ?';

-- Call Prepare Statement
SET @Id = 1;
EXECUTE GetOrderDetail USING @id;




/*
Task 3
Your third and final task is to create a stored procedure called CancelOrder. Little Lemon want to use this stored procedure to delete an order record based on the user input of the order id.

Creating this procedure will allow Little Lemon to cancel any order by specifying the order id value in the procedure parameter without typing the entire SQL delete statement.   
*/
DELIMITER //
CREATE PROCEDURE CancelOrder(IN o_order_id INT)
BEGIN
	DELETE FROM orders
    WHERE OrderID = o_order_id;
    
    SELECT CONCAT('Order ', o_order_id, ' is cancelled') AS Confirmation;
END //
DELIMITER ;

-- Call CancelOrder Procedure
SET @order_id = 6;
CALL CancelOrder(@order_id);