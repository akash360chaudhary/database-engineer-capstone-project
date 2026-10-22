"""
Task1

In the first task of this exercise, you are tasked with extending the environment to connect with your database and interact with the data it holds. 

Your first step is to import the connector module, enter your user details and connect with the database (Hint: you can use an alias when importing the module).

This gives you access to all the functionality available from the connector API, which can be accessed through the variable named connector (or whichever alias you choose). 
"""
import mysql.connector as connector

connection = connector.connect(user = "root", password = "", db = "littlelemondb")

# Create cusror
cursor = connection.cursor()

# Print a message if database connected
print("Database connected successfully.")



"""
Task2

In this second task, you now need to query the database to show all tables within the database. 

Having established a connection in the first task, you need to execute a test query to ensure that there are no issues. You can do this by executing, or passing, a generic query that returns a snapshot of the database tables. 
"""
# Write a MySQL query for getting tables
show_tables_query = "SHOW TABLES;"

# execute cursor for get a snapshot of the tables names
cursor.execute(show_tables_query)

# Store results in a string list
tableList = cursor.fetchall()

# Print all table names using for loop
for i in tableList:
    print(i[0])





"""
Task 3

Query with table JOIN

For the third and final task, Little Lemon need you to return specific details from your database. They require the full name and contact details for every customer that has placed an order greater than $60 for a promotional campaign. 

You can use the following steps to implement this functionality in your database directory:


Step One: Identify which tables are required. To complete the query, you first need to identify which table has the required data. 

The bill paid can be found in Orders as TotalCost and the customer contact information can be found in the Customers table. 

When selecting attributes from a specific table, specify the table name, followed by a dot and the target attribute as below (Hint: select the column attributes that you will need). 


Step Two: Next, specify a table (Hint: The FROM keyword allows you to identify a table.)

To join two tables, specify the type of JOIN and the attribute to join the table on. The tables must be joined on an attribute that is common to both tables (such as a common column).


Step Three: Finally, include a clause to filter the data on. (Hint: the WHERE clause can be used to add conditional parameters.) 

When you have completed these steps, wrap this query as a string and pass it to the .execute() method of the cursor class. When executed, your SELECT query must extract the full name, contact details and bill amount for every customer who spent more than $60.
"""
# Write MySQL query for getting customer data
customerData = """
    SELECT  c.CustomerName AS FullName,
            c.PhoneNumber As 'Contact Details',
            o.TotalCost AS Cost
    FROM Customers c
    INNER JOIN Orders o ON c.CustomerID = o.CustomerID
    WHERE o.TotalCost > 60;"""

# execute cursor for a snapshot of the customer data
cursor.execute(customerData)

# store result
result = cursor.fetchall()

# Get table header name
cols = cursor.column_names

# print columns
print(*cols)

# print customer data using for loop
for i in result:
    print(*i)