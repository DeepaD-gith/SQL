--1. Use the inbuilt functions and find the minimum, maximumand averageamount from the orders table
Select Max(Amount) as 'Max',
Min(Amount) as 'Min', 
Avg(Amount) as 'Avg'
from Orders;

--2. Create a user-defined function which will multiply the given number with10
CREATE Function NumberTimesTen(@mynum decimal(9,2))
returns decimal
AS
Begin
return @mynum*10;
END

SELECT dbo.NumberTimesTen(10);

--3. Use the case statement to check if 100 is less than 200, greater than 200 or equal to 200 and print the corresponding value. 
select case 
when 100 < 200 Then 'Less than 200'
when 100 > 200 Then 'Greater than 200'
when 100 = 200 Then 'Équal to 200'
End
--4. Using a case statement, find the status of the amount. Set the statusof theamount as high amount, low amount or medium amount based uponthecondition. 
Select Amount,
case when Amount > 1000 Then 'High Amount'
     when Amount < 300 Then 'Low Amount'
     Else 'Medium Amount'
END as 'Spent_Category'
From Orders

--5. Create a user-defined function, to fetch the amount greater thanthengiveninput.
CREATE OR ALTER FUNCTION udf_Filter_OrderAmount(@Amt decimal(9,2))
RETURNS decimal(9,2)
AS
BEGIN
DECLARE @ordAmount decimal(9,2) = 0.0

   SET @ordAmount = (Select Top 1 Amount 
   FROM Orders
   Where Amount > @Amt
   Order by Amount ASC)
   
   return @ordAmount;
END

select dbo.udf_Filter_OrderAmount(100.00)

Select C.*,O.Amount
from Customers c
join Orders o on c.customer_id = o.customer_id 
and o.Amount >= dbo.Filter_OrderAmount(100.00);