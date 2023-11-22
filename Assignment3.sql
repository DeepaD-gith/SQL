--Tasks To Be Performed:
--1. Create an ‘Orders’ table which comprises of these columns: ‘order_id’,
--‘order_date’, ‘amount’, ‘customer_id’. 
CREATE TABLE ORDERS 
(ORDERID int Identity(1,1)PRIMARY KEY,
 Order_Date date Default getdate(),
 amount decimal(9,2),
 customer_id int)
 
--2. Insert 5 new records.
Insert into Orders (Amount, Customer_Id)
Values (357, 1),
       (1678, 2),
	   (345, 3),
	   (7890.50, 4),
	   (945.20, 5);

--3. Make an inner join on ‘Customer’ and ‘Orders’ tables on the ‘customer_id’ column. 
Select c.*, o.* 
from customers c
Join Orders o on C.Customer_Id = o.Customer_Id;

--4. Make left and right joins on ‘Customer’ and ‘Orders’ tables on the‘customer_id’ column.
Select c.*, o.* 
from customers c
left Join Orders o on C.Customer_Id = o.Customer_Id;

Select c.*, o.* 
from customers c
right Join Orders o on C.Customer_Id = o.Customer_Id;

--5. Make a full outer join on ‘Customer’ and ‘Orders’ table on the ‘customer_id’ column. 
Select c.*, o.* 
from customers c
full Join Orders o on C.Customer_Id = o.Customer_Id;

--6. Update the ‘Orders’ table and set the amount to be 100where‘customer_id’ is 3.
Update Orders set Amount = 100
where Customer_Id = 3;