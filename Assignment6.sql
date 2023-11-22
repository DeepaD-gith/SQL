--1. Create a view named ‘customer_san_jose’ which comprises of onlythosecustomers who are from San Jose
CREATE VIEW customer_san_jose
AS
Select * from customers
where city = 'San Jose';

--2. Inside a transaction, update the first name of the customer to Franciswhere the last name is Jordan:
  Begin Tran CUpdate;
	  Update Customers 
	  set FirstName = 'Francis'
	  where LastName = 'Jordan';

   Select @@TRANCOUNT; 

   --a. Rollback the transaction
   Rollback Tran CUpdate;
   Select @@TRANCOUNT; 

   --b. Set the first name of customer to Alex, where the last nameisJordan
    Update customers 
	set FirstName = 'Alex'
	where LastName = 'Jordan';

--3. Inside a TRY... CATCH block, divide 100 with 0, print the default error message. 
Begin Try
	Select 100/0;
End Try
Begin Catch
   Print ERROR_MESSAGE()
End Catch

--4. Create a transaction to insert a new record to Orders table and saveit.
Begin Tran
 Insert into 
     Orders(Order_Date, Amount, Customer_Id)
     Values (GetDate(), 1267.5, 4)
Commit Tran;

