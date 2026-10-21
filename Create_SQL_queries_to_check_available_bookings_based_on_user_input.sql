-- Select Database
USE littlelemondb;

/*
Task 1
Little Lemon wants to populate the Bookings table of their database with some records of data. Your first task is to replicate the list of records in the following table by adding them to the Little Lemon booking table. 
*/
INSERT INTO Bookings (BookingsID, BookingDate, TableNumber, CustomerID, StaffID)
VALUES
	(1, '2022-10-10', 5, 1, 1),
    (2, '2022-11-12', 3, 3, 2),
    (3, '2022-10-11', 2, 2, 3),
    (4, '2022-10,13', 2, 1, 2);

-- Check Insert Data
SELECT * FROM Bookings;




/*
Task 2
For your second task, Little Lemon need you to create a stored procedure called CheckBooking to check whether a table in the restaurant is already booked. Creating this procedure helps to minimize the effort involved in repeatedly coding the same SQL statements.

The procedure should have two input parameters in the form of booking date and table number. You can also create a variable in the procedure to check the status of each table.
*/

DELIMITER //
CREATE PROCEDURE CheckBooking(
	IN bookDate DATE,
    IN tableNo INT
)
BEGIN
	-- Declare variable for booking count and table status
    DECLARE bookCount INT DEFAULT 0;
    DECLARE tablestatus VARCHAR(20);
    
    -- Count how many booking exist for this slot
    SELECT COUNT(TableNumber) INTO bookCount
    FROM Bookings
    WHERE BookingDate = bookDate AND TableNumber = tableNo;
    
    -- Set status based on the count
    IF bookCount > 0 THEN
		SET tableStatus = 'already booked';
	ELSE
		SET tableStatus = 'available';
	END IF;
	
    -- Return the status
    SELECT CONCAT('Table ', tableNo,' is ', tableStatus) AS 'Booking Status';
END //
DELIMITER ;

SET @bookingdate = '2022-11-12';
SET @tableNo = 3;

CALL CheckBooking(@bookingdate, @tableNo)






/*
Task 3
For your third and final task, Little Lemon need to verify a booking, and decline any reservations for tables that are already booked under another name. 

Since integrity is not optional, Little Lemon need to ensure that every booking attempt includes these verification and decline steps. However, implementing these steps requires a stored procedure and a transaction. 

To implement these steps, you need to create a new procedure called AddValidBooking. This procedure must use a transaction statement to perform a rollback if a customer reserves a table that’s already booked under another name.  

Use the following guidelines to complete this task:

The procedure should include two input parameters in the form of booking date and table number.

It also requires at least one variable and should begin with a START TRANSACTION statement.

Your INSERT statement must add a new booking record using the input parameter's values.

Use an IF ELSE statement to check if a table is already booked on the given date. 

If the table is already booked, then rollback the transaction. If the table is available, then commit the transaction. 
*/

DELIMITER //
CREATE PROCEDURE AddValidBooking(
	IN bookDate DATE,
    IN tableNo INT
)
BEGIN
    -- Declare local variable for count table count and status
    DECLARE tableCount INT DEFAULT 0;
    DECLARE tableStatus VARCHAR(20);
    DECLARE totalBookings INT DEFAULT 0;
    
    -- Store random staffID
    DECLARE randStaffID INT DEFAULT 0;
    
	-- Start a transaction
    START TRANSACTION;
        
    -- Count how many booking exist for this slot
    SELECT COUNT(TableNumber) INTO tableCount
    FROM Bookings
    WHERE BookingDate = bookDate AND TableNumber = tableNo;
    
    -- Set status based on the count
    IF tableCount > 0 THEN
		SET tableStatus = 'already booked';
        SELECT CONCAT('Table ', tableNo, ' is ', tableStatus,' - booking cancelled') AS 'Booking Status';
        ROLLBACK;
	ELSE
		SET tableStatus = 'available';
        
        -- Count total bookings
        SELECT COUNT(BookingID) INTO totalBookings FROM Bookings;
        
        -- Select random staff
        SELECT StaffID INTO randStaffID FROM Staff ORDER BY RAND() LIMIT 1;
        
        -- Insert booking in booking table
        INSERT INTO Bookings (BookingID, BookingDate, TableNumber, CustomerID, StaffID)
        VALUES(totalBookings+1, bookDate, tableNo, 5, randStaffID);
		-- Return update for booking confirm
		SELECT CONCAT('Table ', tableNo,' is ', tableStatus, ' and booked for you') AS 'Booking Status';
    
		-- Commit the transaction
		COMMIT;
	END IF;
    
END //

DELIMITER ;

-- Set variable/check values
SET @bookingDate = '2022-10-11';
SET @tableNo = 2;

-- Call Procedure
CALL AddValidBooking(@bookingDate, @tableNo);
