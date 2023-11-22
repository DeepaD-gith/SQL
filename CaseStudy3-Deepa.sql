--1. Display the count of customers in each region who have done the
--transaction in the year 2020.
Select R.Region_Name, Count(Distinct C.Customer_Id) as '# of CustomerTrans-Region-2020'
from Customers C
join Continent R on R.region_id = C.region_id
join [Transaction] T on T.Customer_id = C.customer_id
where Year(T.txn_date) = 2020
group by R.Region_Name;


--2. Display the maximum and minimum transaction amount of each
--transaction type.
Select txn_type, max(txn_amount) as 'Highest Txn Amt', 
       min(txn_amount) as 'Lowest Txn Amt'
from [transaction] t
group by txn_type

--3. Display the customer id, region name and transaction amount where
--transaction type is deposit and transaction amount > 2000.
Select t.customer_id, r.region_name, t.txn_amount
from Customers C
join Continent R on R.region_id = C.region_id
join [Transaction] T on T.Customer_id = C.customer_id
where txn_type = 'deposit' and txn_amount > 2000;

--4. Find duplicate records in the Customer table.
Select Count(RowNumC1) as 'DupCt',
       Cust.Customer_id,Cust.region_id,
	   Cust.Start_Date, Cust.end_date
from	   
	(Select C1.*, row_number() over(Order by Customer_id) as 'RowNumC1'
	from Customers C1
	) Cust
group by  Cust.Customer_id,Cust.region_id,
	      Cust.Start_Date, Cust.end_date
having count(RowNumC1) > 1;

--5. Display the customer id, region name, transaction type and transaction
--amount for the minimum transaction amount in deposit.
Select Distinct t.customer_id, r.region_name,t.txn_type, t.txn_amount
from Customers C
join Continent R on R.region_id = C.region_id
join [Transaction] T on T.Customer_id = C.customer_id
where t.txn_amount = (Select min(txn_amount) from [Transaction]);

--6. Create a stored procedure to display details of customers in the
--Transaction table where the transaction date is greater than Jun 2020.
Create or ALTER Procedure get_CustDetails_forTrans(@transdate date)
AS
Begin
	Select Distinct t.customer_id, r.region_name,
		   t.txn_type, t.txn_amount, t.txn_date
	from Customers C
	join Continent R on R.region_id = C.region_id
	join [Transaction] T on T.Customer_id = C.customer_id 
	where T.txn_date > @transdate
END

Exec get_CustDetails_forTrans @transdate = '2020-01-20'

--7. Create a stored procedure to insert a record in the Continent table.
Create Procedure _ins_into_Continent(@regionid tinyint,
                                     @region_name varchar(20))
AS
Begin
Insert into Continent values (@regionid,@region_name)
End

Exec _ins_into_Continent @regionid = 6, @region_name='Pacific' 


--8. Create a stored procedure to display the details of transactions that
--happened on a specific day.
Create Procedure _get_txn_details(@txndate date)
As
Begin

Select * 
from [transaction] T
where T.txn_date = @txndate

End

Exec _get_txn_details @txndate = '2020-01-20' 
--9. Create a user defined function to add 10% of the transaction amount in a
--table.

--Question is not clear, DDL, DML cannot be used in UDF, hence using Proc
Create Procedure _ins_txnAmt_TenPercent
As
Begin
	CREATE Table Txn_AmtPercent(txn_date date,
								txn_comm decimal(5,2));

	--Add 10% of txn_amount to new table
	Insert into Txn_AmtPercent
	Select txn_date, txn_amount*.1 
	from [Transaction];

	Select * from Txn_AmtPercent;
End

--if it is to get 10% of txnAmount, ans below in udf 
Create Function _get_txnAmt_byTenPercent()
Returns table
As
return(	
        Select T.*, txn_amount*.1 as 'TenPercent'
	    from  [Transaction] T
	)

Select * from _get_txnAmt_byTenPercent();

--10. Create a user defined function to find the total transaction amount for a
--given transaction type.
Create Function _get_TotalAmt_ByTxnType()
returns table 
as
return
( 
		Select T.txn_type, sum(T.txn_amount) as 'Total Amount'
        from [Transaction] T
		group by T.txn_type
)

Select * from _get_TotalAmt_ByTxnType();

--11. Create a table value function which comprises the columns customer_id,
--region_id ,txn_date , txn_type , txn_amount which will retrieve data from
--the above table.
Create Function _get_CustomerDetails()
returns table
As
return
(
    Select Distinct c.customer_id, c.region_id,
					t.txn_date, t.txn_type, t.txn_amount 
	from Customers C
	join [Transaction] T on T.Customer_id = C.customer_id 
)

Select * from _get_CustomerDetails();

--12. Create a TRY...CATCH block to print a region id and region name in a
--single column.
Begin Try
  Select convert(varchar(2),Region_id) + ' - ' + Region_Name as 'Region'
  from Continent;
End Try
Begin Catch
  Select ERROR_MESSAGE() as 'ErrMsg'
End Catch


--13. Create a TRY...CATCH block to insert a value in the Continent table.
Begin Try
  Insert into Continent 
  Values(7, 'New Zealand');
End Try
Begin Catch
   Select ERROR_NUMBER() as 'Err Num',
          ERROR_MESSAGE() as 'Err Msg',
		  ERROR_SEVERITY() as 'Err Severity';
End Catch

--14. Create a trigger to prevent deleting a table in a database.
Create Trigger _trig_NoDelete_Table
On DATABASE
FOR DROP_TABLE
AS
BEGIN
Print 'Delete Not Allowed'
Rollback Tran
END

--Testing Drop Table Continent;

--15. Create a trigger to audit the data in a table.
Create Table Txn_AuditTbl
(
 txnAudit_id int Identity(1,1) Primary Key,
 customer_id smallint,
 txn_date date,
 txn_type varchar(50),
 txn_amount smallint,
 DML_Type varchar(20),
 DML_User varchar(25) default suser_name(),
 ActionDate datetime default getdate(),
 )
CREATE OR ALTER TRIGGER ins_Transaction
ON [Transaction]
After Insert, update, delete
As
Begin
	If exists (Select 0 from deleted) and exists (Select 0 from inserted)-- update
		Begin
		  Print 'Update Trigger'
		  Insert Into Txn_AuditTbl 
		    (customer_id,
			 txn_date,
			 txn_type,
			 txn_amount,
			 DML_Type
			)
		  Select
		          inserted.customer_id, inserted.txn_date,
				  inserted.txn_type, inserted.txn_amount,
				  'Update'
		  from inserted
		End
	else if exists (Select 0 from inserted)
		Begin
		 Print 'Insert Trigger'
		  Insert Into Txn_AuditTbl 
		    (customer_id,
			 txn_date,
			 txn_type,
			 txn_amount,
			 DML_Type
			)
		  Select
		          inserted.customer_id, inserted.txn_date,
				  inserted.txn_type, inserted.txn_amount,
				  'Insert'
		   from inserted
		End
	else --delete
	Begin
	 Print 'Delete Trigger'
		  Insert Into Txn_AuditTbl 
		    (customer_id,
			 txn_date,
			 txn_type,
			 txn_amount,
			 DML_Type
			)
		  Select
		          Deleted.customer_id, Deleted.txn_date,
				  Deleted.txn_type, Deleted.txn_amount,
				  'Delete'
		   from Deleted
	End
End
--***************Testing Data Begin ****************--
Insert into [Transaction] values(429, '2023-09-01', 'deposit',12)

Select * from Txn_AuditTbl

update [Transaction] set txn_amount = 120 where txn_date = '2023-09-01' and txn_amount = 12;

Select * from Txn_AuditTbl

Delete from [Transaction]  where txn_date = '2023-09-01' and txn_amount = 120;

Select * from Txn_AuditTbl

Select * from [Transaction] where txn_date = '2023-09-01' and txn_amount = 120
--******************************--

--16. Create a trigger to prevent login of the same user id in multiple pages.
USE master;  
GO  
CREATE LOGIN login_test WITH PASSWORD = N'Test123' MUST_CHANGE,  
    CHECK_EXPIRATION = ON;  
GO  

GRANT VIEW SERVER STATE TO login_test;  
GO  

CREATE TRIGGER connection_limit_trigger  
ON ALL SERVER  
FOR LOGON  
AS  
BEGIN  
IF ORIGINAL_LOGIN()= N'login_test' AND  
    (SELECT COUNT(*) FROM sys.dm_exec_sessions  
            WHERE is_user_process = 1 AND  
                original_login_name = N'login_test') > 1  --Limiting to only one session
    ROLLBACK;  --stop login and show error
END;  

DROP TRIGGER connection_limit_trigger ON ALL SERVER;


--17. Display top n customers on the basis of transaction type.
Select * 
from
	(Select *, 
			DENSE_RANK() over(order by txn_type_count desc) as 'Rank_Txn'
	from
			(Select customer_id,
				  txn_type,
				  count(txn_type) as 'txn_type_count'
			from [Transaction] T
			group by customer_id, txn_type
			) T1
	)txn_rank
where txn_rank.Rank_Txn <=5  --top n costomers

--18. Create a pivot table to display the total purchase, withdrawal and
--deposit for all the customers.
Select * --[purchase], [withdrawal], [deposit] 
From
(Select 	txn_type,
		    txn_amount 
from [Transaction] T
) as P
Pivot
(
sum(txn_amount) FOR txn_type in ([purchase], [withdrawal], [deposit])
)as P1

--Another option below To add Year Column in Pivot

update [Transaction] 
set txn_date = DateFromParts('2022',Month(txn_date), Day(txn_date))
where customer_id in (367,13)
--End Test update

Select * --[purchase], [withdrawal], [deposit] 
From
(Select 	Year(Txn_date) as 'Txn_Year',
			txn_type,
		    txn_amount 
from [Transaction] T
) as P
Pivot
(
sum(txn_amount) FOR txn_type in ([purchase], [withdrawal], [deposit])
)as P1
