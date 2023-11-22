--1. Create a customer table which comprises of these columns: ‘customer_id’,
--‘first_name’, ‘last_name’, ‘email’, ‘address’, ‘city’,’state’,’zip’ 
CREATE TABLE Customer
(customer_id int IDENTITY(1,1) PRIMARY KEY,
 first_name varchar(30),
 last_name varchar(30),
 email varchar(35),
 address varchar(55),
 city varchar(30),
 state varchar(30),
 zip int
 )


--2. Insert 5 new records into the table
Insert Into customer
(first_name, last_name,email,address, city, state, zip)
values('Sneha','Bhatia', 'sbhatia@gmail.com','#32 123 Street','Santa Monica','California', 98703)
Insert Into customer
(first_name, last_name,email,address, city, state, zip)
values('James','John', 'jj@hotmail.com','#345 Main Street','AnyTown','Massachusets', 63456)
Insert Into customer
(first_name, last_name,email,address, city, state, zip)
values('Kirsten','Pearson', 'Kirsten99@gmail.com','#95 Jefferson Lane','NewTown','Idaho', 63456)
Insert Into customer
(first_name, last_name,email,address, city, state, zip)
values('Smitha','Paul', 'SmithaP@gmail.com','#123 New Hope Street','MyTown','Omaha', 78901)
Insert Into customer
(first_name, last_name,email,address, city, state, zip)
values('Mike','Tyson', 'MT103@gmail.com','#95 Lincoln Street','Phoenix','Arizona', 34500)
Insert Into customer
(first_name, last_name,email,address, city, state, zip)
values('Gerald','Newman', 'gerald3@gmail.com','#33 Jefferson Street','SanJose','California', 97500)

--3. Select only the ‘first_name’ and ‘last_name’ columns from the customer
--table
Select first_name, last_name from customer;
--4. Select those records where ‘first_name’ starts with “G” and city is ‘SanJose’. 
Select * from customer
where first_name LIKE 'G%'
and city ='SanJose'
--5. Select those records where Email has only ‘gmail’. 
Select * from customer
where email LIKE '%gmail%'
--6. Select those records where the ‘last_name’ doesn't end with “A”.
Select * from customer
where last_name Not LIKE '%A'
and city ='SanJose'

