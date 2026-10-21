-- Select Database
USE littlelemondb;

/*
Task 1
In this first task you need to create a new procedure called AddBooking to add a new table booking record.

The procedure should include four input parameters in the form of the following bookings parameters:

booking id, 

customer id, 

booking date,

and table number.
*/

DELIMITER //
CREATE PROCEDURE AddBooking(
	IN newbookid INT,
    IN newcustomerid INT,
    IN newbookdate DATE,
    IN tablenum INT
)
BEGIN
	DECLARE staff_id INT;
    
    -- Assign a staff id for new booking
    SELECT StaffID INTO staff_id FROM Staff ORDER BY RAND() LIMIT 1;
    
    -- Insert data in booking table
    INSERT INTO Bookings (BookingID, BookingDate, TableNumber, CustomerID, StaffID)
    VALUES (newbookid, newbookdate, tablenum, newcustomerid, staff_id);
    
    -- Update confirmation
    SELECT CONCAT("New booking added") AS Confirmation;
END //
DELIMITER ;

SET @newbookid = 7;
SET @newcustomerid = 2;
SET @newbookdate = '2026-10-21';
SET @tablenum = 3;

CALL AddBooking(@newbookid, @newcustomerid, @newbookdate, @tablenum);






/*
Task 2
For your second task, Little Lemon need you to create a new procedure called UpdateBooking that they can use to update existing bookings in the booking table.

The procedure should have two input parameters in the form of booking id and booking date. You must also include an UPDATE statement inside the procedure. 

The screenshot below shows an example of the UpdateBooking procedure in use.
*/
DELIMITER //
CREATE PROCEDURE UpdateBooking(
	IN booking_id INT,
    IN newDate DATE
)
BEGIN
	-- Declare a variable for booking id is exist or not
	DECLARE checkBooking INT DEFAULT 0;
    
    -- Check booking
    SELECT COUNT(BookingID) INTO checkBooking FROM Bookings WHERE BookingID = booking_id;
    
    -- If booking available so update data either notify booking not available
    IF checkBooking > 0 THEN
		UPDATE Bookings
        SET BookingDate = newDate
        WHERE BookingID = booking_id;
        SELECT CONCAT('The new booking date ', newDate,' updated for the booking id ', booking_id,'.') AS 'Confirmation';
	ELSE
		SELECT CONCAT('The booking id ', booking_id, ' is not avilable, please do a new booking') AS 'Confirmation';
	END IF;
END//
DELIMITER ;

SET @oldbookingid = 7;
SET @updateDate = '2026-10-22';

CALL UpdateBooking(@oldbookingid, @updateDate);







/*
Task 3
For the third and final task, Little Lemon need you to create a new procedure called CancelBooking that they can use to cancel or remove a booking.

The procedure should have one input parameter in the form of booking id. You must also write a DELETE statement inside the procedure. 

When the procedure is invoked, the output result should be similar to the following screenshot:
*/
DELIMITER //
CREATE PROCEDURE CancelBooking(
	IN cancelBookingID INT
)
BEGIN
	-- Perform direct deletion
    DELETE FROM Bookings
    WHERE BookingID = cancelBookingID;
    
    -- Check order cancelled or not
    IF ROW_COUNT() > 0 THEN
		SELECT CONCAT('Booking ', cancelBookingID,' cancelled') AS Confirmation;
	ELSE
		SELECT CONCAT('Booking ', cancelBookingID,' not available') AS Confirmation;
	END IF;
END//
DELIMITER ;

SET @cancelBookingID = 7;

CALL CancelBooking(@cancelBookingID);