--1. Find out the selling cost average for packages developed in Pascal.
Select Avg(scost) as 'Avg Cost for Packages in Pascal'
from Software
where Developin = 'PASCAL'
Group By Developin;

--2. Display the names and ages of all programmers.
Select PNAME, Datediff(YY,DOB, GetDate()) as 'Age'
From Programmer;

--3. Display the names of those who have done the DAP Course.
Select PNAME
From Studies
where Course ='DAP';

--4. Display the names and date of birth of all programmers born in January.
Select  PNAME, 
		DOB
From Programmer
where month(DOB)=1;

--5. What is the highest number of copies sold by a package?
Select Max(Sold) as 'Highest Sold'
from Software;

--6. Display lowest course fee.
Select Min(Course_Fee) as 'Lowest Fee'
From Studies;


--7. How many programmers have done the PGDCA Course? 
Select Count(Course) 'Num_Programmers_PGDCA'
from Studies
where Course = 'PGDCA';


--8. How much revenue has been earned through sales of packages developed in C? 
Select Developin, sum(SCost*Sold) 'Revenue'
From Software
Where Developin ='C'
group by Developin;

--9. Display the details of the software developed by Ramesh. 
Select *
From Software
Where PName = 'Ramesh';

--10. How many programmers studied at Sabhari? 
Select Institute, Count(PName) 'Num_Programmers'
From Studies
where Institute = 'SABHARI'
group by Institute;

--11. Display details of packages whose sales crossed the 2000 mark. 
Select *
from Software
where (SCOST*Sold) >2000;

--12. Display the details of packages for which development costs have been recovered. 
Select PNAME,Title, Developin,(SCost*Sold)as 'Revenue',Dcost
from Software
where (SCost*Sold) > Dcost;

--13. What is the cost of the costliest software development in Basic?
Select *
from Software
where Developin = 'Basic'
And DCost = (Select Max(DCost)
			from Software s2
			where  Developin = 'Basic');

--14. How many packages have been developed in dBase?
Select Developin, Count(*) 'Num_Packages'
from Software
where Developin = 'dBase'
group by Developin;

--15. How many programmers studied in Pragathi? 
Select Institute, Count(PName) 'Num_Programmers'
From Studies
where Institute = 'Pragathi'
group by Institute;

--16. How many programmers paid 5000 to 10000 for their course? 
Select Count(PName)'Num_Programmers' 
from Studies
Where Course_Fee between 5000 and 10000;
--Where Course_Fee >=5000 and Course_Fee <= 10000;


--17. What is the average course fee? 
Select avg(Course_Fee) 'Avg Fees'
From Studies;

--18. Display the details of the programmers knowing C. 
Select * 
From Programmer
where Prof1 = 'C' or Prof2 = 'C';

--19. How many programmers know either COBOL or Pascal? 
Select Count(PName) 'Num_Programmers'
From Programmer
where Prof1 IN ('COBOL','PASCAL') or Prof2 IN ('COBOL','PASCAL') ;

--20. How many programmers don’t know Pascal and C? 
Select Count(PName) 'Num_Programmers'
From Programmer
where Prof1 NOT IN ('C','PASCAL') AND Prof2 NOT IN ('C','PASCAL') ;

--21. How old is the oldest male programmer? 
Select PNAME, DOB, 
DateDiff(yy,DOB,getdate()) as 'Age'
From Programmer
where DOB = 
(Select Min(DOB)
From Programmer)

--22. What is the average age of female programmers? 
Select Avg(DateDiff(yy,DOB,getdate())) as 'Avg Age of Female Programmers'
From Programmer
where Gender = 'F';

--23. Calculate the experience in years for each programmer and display with their names in descending order.
Select PNAME, Datediff(dd,DOJ,getdate())/365 as 'ExpinYears',
DOJ
From Programmer
Order By DOJ Desc --assuming the question meant to sort by exp, if it was by name then PName Desc

--24. Who are the programmers who celebrate their birthdays during the current month? 
Select PNAME,DOB
From Programmer
where DatePart(mm,DOB) = DatePart(mm,getdate());

--25. How many female programmers are there? 
select count(1) 'Num_female_Programmers'
from Programmer
where Gender = 'F';

--26. What are the languages studied by male programmers?
select  prof1 
from Programmer
where Gender = 'M'
Union 
select  prof2 
from Programmer
where Gender = 'M';

--27. What is the average salary? 
Select Avg(Salary) as 'Avg Salary'
From Programmer;

--28. How many people draw a salary between 2000 to 4000? 
Select Count(PNAME) 
From Programmer
Where Salary >= 2000 and Salary <=4000;

--29. Display the details of those who don’t know Clipper, COBOL or Pascal. 
Select * 
From Programmer
where Prof1 Not In ('Clipper','Cobol','Pascal')
and Prof2 Not In ('Clipper','Cobol','Pascal')

--30. Display the cost of packages developed by each programmer. 
select TITLE,Developin,DCOST 
from Software;

--31. Display the sales value of the packages developed by each programmer.
select TITLE,Developin,SCOST 
from Software;

--32. Display the number of packages sold by each programmer. 
select PNAME,SUM(Sold) as 'Total Sold' 
from Software
group by PNAME;

--33. Display the sales cost of the packages developed by each programmer language wise. 
Select PName, Developin, Sum(SCost) as 'Sales Cost'
From Software
Group by PName, Developin
Order By PName, Developin;

--34. Display each language name with the average development cost, average selling cost and average price per copy.
Select Developin, 
	   Avg(dCost) 'Avg development Cost', 
	   cast(Avg(sCost) as decimal(9,2)) 'Avg Selling Cost',
	   iif(avg(sold)>0,Avg(SCost)/Avg(Sold),Avg(scost)) 'Avg Price Per Copy'
From Software
Group by Developin
Order By Developin;

--35. Display each programmer’s name and the costliest and cheapest packages developed by him or her. 
Select PNAME, 
	   Min(dCost) 'Cheapest Package', 
	   Max(dCost) 'Costliest Package'
	   --count(dCost) '# of Packages'
From Software
Group by PName

--36. Display each institute’s name with the number of courses and the average cost per course.
Select Institute, Count(Course) 'Num_Courses',avg(Course_Fee) as 'AvgFee'
from Studies 
group by institute;

--37. Display each institute’s name with the number of students. 
Select Institute,count(PName) '# of Students'
from Studies 
group by institute

--38. Display names of male and female programmers along with their gender. 
Select PNAME, Gender 
from Programmer
Order by Gender;

--39. Display the name of programmers and their packages. 
Select PName, Title 
from Software
Order by PName;

--40. Display the number of packages in each language except C and C++.
Select Developin,count(Title) 
from Software
where Developin Not In('C','C++')
Group By Developin;

--41. Display the number of packages in each language for which development cost is less than 1000.
Select Developin,count(Title) 
from Software
where dCost < 1000
Group By Developin;

--42. Display the average difference between SCOST and DCOST for each package. 
Select Developin,Avg(sCost)-Avg(dCost) as 'Sale-Dev'
from Software
Group By Developin;

--43. Display the total SCOST, DCOST and the amount to be recovered for each programmer whose cost has not yet been recovered. 
Select PName,
	   Sum(SCost*Sold) as 'Total Sales',
	   sum(DCost)'Total DCost', 
	   Sum(DCost)-sum(SCost*Sold) 'To be Recovered'
from Software
Group By PName
having Sum(DCost)-sum(SCost*Sold) > 0;

--44. Display the highest, lowest and average salaries for those earning more than 2000. 
Select Max(Salary) 'Highest Sal above 2k',
       Min(Salary) 'Lowest Sal above 2k',
	   Avg(Salary) 'Average Sal above 2k'
From Programmer
where Salary > 2000;

--45. Who is the highest paid C programmer? 
Select PName,Salary 
From 
Programmer
where Salary = (Select Max(Salary) from Programmer where Prof1='C'or Prof2='C')
and  (Prof1='C'or Prof2='C')

--46. Who is the highest paid female COBOL programmer? 
Select PName,Salary 
From 
Programmer
where (Prof1='COBOL'or Prof2='COBOL')
AND Gender = 'F'
and Salary = (Select Max(Salary) from Programmer where (Prof1='COBOL'or Prof2='COBOL') and Gender='F')

--47. Display the names of the highest paid programmers for each language. 
Select * from
(Select PName, CLanguage, Salary,
		Rank() over(Partition By CLanguage Order by Salary Desc ) 'ProfRank'
from
		(Select PName, Prof1 as 'CLanguage', Salary
		from Programmer
		Union
		Select PName, Prof2, Salary
		from Programmer)as Prog_Lang
) as final
where ProfRank = 1
Order by PName

--48. Who is the least experienced programmer?
Select PName
From Programmer
where DOJ = (Select Max(DOJ) from Programmer)


--49. Who is the most experienced male programmer knowing PASCAL?
Select PNAme
From Programmer
Where (Prof1 = 'Pascal' or Prof2 = 'Pascal')
AND DOJ = (Select Min(DOJ) from Programmer where Prof1 = 'Pascal' or Prof2 = 'Pascal')

--50. Which language is known by only one programmer? 
Select CLanguage
from
	(Select Prof1 as 'CLanguage'
	from Programmer
	Union All
	Select Prof2
	from Programmer)as Prog_Lang
group by CLanguage
having count(CLanguage) = 1
Order by Count(CLanguage);
Select * from Programmer

--51. Who is the above programmer referred in 50? 
;with ProgLangCte AS
(
Select CLanguage
from
	(Select Prof1 as 'CLanguage'
	from Programmer
	Union All
	Select Prof2
	from Programmer)as Prog_Lang
group by CLanguage
having count(CLanguage) = 1
)
Select PName, Prof1, Prof2
from Programmer
where Prof1 in (Select CLanguage from ProgLangCte)
or Prof2 in (Select CLanguage from ProgLangCte);

--52. Who is the youngest programmer knowing dBase?
Select PNAME
From Programmer
Where (Prof1 = 'dBase' or Prof2 = 'dBase')
AND DOB = (Select Max(DOB) from Programmer Where Prof1 = 'dBase' or Prof2 = 'dBase')

--53. Which female programmer earning more than 3000 does not know C, C++, Oracle or dBase?
Select PName, Prof1, Prof2 
From Programmer
where Prof1 not in ('C', 'C++','Óracle','dBase')
and Prof2 not in ('C', 'C++','Óracle','dBase')
and Salary > 3000
and Gender = 'F';

--54. Which institute has the most number of students? 
;with CourseCte as
(Select INSTITUTE, Count(PName) as Students
from studies
group by INSTITUTE
)
Select Institute, Students
from CourseCte
where Students = (Select Max(Students)
                  from CourseCte);

--55. What is the costliest course? 
Select Course
from Studies
Where Course_Fee = (Select Max(Course_Fee) 
					from Studies);

--56. Which course has been done by the most number of students? 
;with StudentCte as
(Select Course, Count(PName) as Students
from studies
group by Course
)
Select Course
from StudentCte
where Students = (Select Max(Students)
				  from StudentCte)

--57. Which institute conducts the costliest course? 
Select Institute
from Studies
Where Course_Fee = (Select Max(Course_Fee) 
					from Studies)

--58. Display the name of the institute and the course which has below average course fee. 
Select Institute, Course, Course_Fee
from Studies
Where Course_Fee < (Select Avg(Course_Fee) 
					from Studies)

--59. Display the names of the courses whose fees are within 1000 (+ or -) of the average fee. 
Select Course 
from Studies
where Course_Fee < (Select Avg(course_Fee) +1000 from Studies)
and Course_Fee > (Select Avg(course_Fee) - 1000 from Studies)

--60. Which package has the highest development cost? 
Select Title, *  
from Software
where DCost = (Select Max(DCost) from Software)


--61. Which course has below average number of students?
Select Course 
from Studies
group by Course
having Count(PName) < (Select Avg(StudentCt) from (Select Count(PName) as 'StudentCt' 
						   from Studies group by INSTITUTE)Stud_Inst
						)

--62. Which package has the lowest selling cost? 
Select *
from Software
where sCost = (Select Min(sCost) from Software)

--63. Who developed the package that has sold the least number of copies? 
Select PName, Sold
from Software
where sold = (Select Min(sold) from Software)

--64. Which language has been used to develop the package which has the highest sales amount? 
Select Developin
from Software
where sCost = (Select Max(sCost) from Software)

--65. How many copies of the package that has the least difference between development 
--and selling cost were sold?
Select Title,Sold 
from Software 
where DCost - sCost = (Select Min(DCost - SCost)
						from Software)

--66. Which is the costliest package developed in Pascal? 
Select Title
from Software 
where Developin = 'Pascal'
and dCost = (Select Max(dCost) 
			 from Software 
			where Developin = 'Pascal')

--67. Which language was used to develop the most number of packages? 
;With LangCte as
(Select Developin, Count(Title) as 'CountofPkg'
from Software
group by Developin)
Select Developin 
from LangCte
where CountofPkg = (Select 
					Max(CountofPkg) from LangCte) 

--68. Which programmer has developed the highest number of packages? 
;With PrgCte as
(Select PName, Count(Title) as 'CountofPkg'
from Software
group by PName)
Select PName 
from PrgCte
where CountofPkg = (Select 
					Max(CountofPkg) from PrgCte) 

--69. Who is the author of the costliest package? 
--high dCost
Select PName 
from Software
where DCost = (Select Max(dCost)
               from Software)
--high sCost
Select * 
from Software
where sCost = (Select Max(sCost)
               from Software)

--70. Display the names of the packages which have sold less than the average number of copies. 
Select Title, sold
from Software
where sold < (Select Avg(Sold)
			  from Software)

--71. Who are the authors of the packages which have recovered more than double the development cost? 
Select PName
from Software
Where (sCost*Sold) > 2*DCost

--72. Display the programmer names and the cheapest packages developed by them in each language.
Select PName, Title
from
(Select PName, Title,
rank() over(Partition by PName Order by DCost) 'DCostPrice'
from Software) as ProgPack
where DCostPrice = 1

--73. Display the language used by each programmer to develop the highest selling and lowest selling package.
Select PName, Developin, Title, 'Highest' as 'CountSold'
from Software S1
where Sold = (Select Max(Sold) from Software S2 where S1.Pname = S2.Pname)
Union
Select PName, Developin, Title, 'Lowest'
from Software S1
where Sold = (Select Min(Sold) from Software S2 where S1.Pname = S2.Pname)
Order by PName

--74. Who is the youngest male programmer born in 1965?
Select PName, DOB
from Programmer
where DOB = (Select Min(DOB) from Programmer where Year(DOB) = 1965 and Gender='M')
and Gender = 'M';

--75. Who is the oldest female programmer who joined in 1992? 
Select PName, DOB, DOJ
from Programmer P1
where DOB = (Select Min(DOB) from Programmer P2
             where Gender = 'F' and Year(DOJ) = 1992)
and Gender = 'F'
and Year(DOJ) = 1992;

--76. In which year was the most number of programmers born? 
;With YrDOBCte as 
(Select Year(DoB) as 'YearofBirth', Count(Year(DOB)) 'CtYr'
from Programmer 
Group by Year(DOB)
)
Select YearofBirth 
from YrDOBCte
where CtYr = (Select Max(CtYr) from YrDOBCte)

--77. In which month did the most number of programmers join? 
;With MthDOJCte as 
(Select DateName(month,DoJ) as 'MonthofJoin', Count(Month(DOJ)) 'CtMth'
from Programmer 
Group by DateName(month,DOJ)
)
Select MonthofJoin 
from MthDOJCte
where CtMth = (Select Max(CtMth) from MthDOJCte)

--78. In which language are most of the programmer’s proficient? 
;With ProfCte as 
(Select Prof, count(Prof) as 'CtProf'
from (Select Prof1 as 'Prof'
	from Programmer P
	Union All
	Select Prof2
	from Programmer P)as Lang
group by Prof 
)
Select Prof,CtProf from ProfCte
where CtProf = (Select Max(CtProf)
				from ProfCte)

--79. Who are the male programmers earning below the average salary of female programmers?
Select PName 
from Programmer
where Gender = 'M'
and Salary < (Select Avg(Salary)
	from Programmer
	where Gender = 'F'
	);

--80. Who are the female programmers earning more than the highest paid? 
-- highest paid male?
Select PName 
from Programmer
where Gender = 'F'
and Salary > (Select Max(Salary)
	from Programmer
	where Gender = 'M'
	);

--81. Which language has been stated as the proficiency by most of the programmers? 
-- repeat of 78?
;With ProfCte as 
(Select Prof, count(Prof) as 'CtProf'
from (Select Prof1 as 'Prof'
	from Programmer P
	Union All
	Select Prof2
	from Programmer P)as Lang
group by Prof 
)
Select Prof,CtProf from ProfCte
where CtProf = (Select Max(CtProf)
				from ProfCte)

--82. Display the details of those who are drawing the same salary. 
Select p1.*
from programmer P1
join Programmer P2 on P1.Salary = P2.Salary
and P1.PName <> P2.PName
Order by P1.Salary

--83. Display the details of the software developed by the male programmers earning more than 3000.
Select S.PName, S.Developin,
	   S.Title, S.DCost,
	   S.SCost, S.Sold
from Programmer P
left join Software S on P.Pname = S.PName
where P.Gender = 'M' 
and P.Salary > 3000
--84. Display the details of the packages developed in Pascal by the female programmers. 
Select S.*
from Programmer P
left join Software S on P.Pname = S.PName
where P.Gender = 'F' 
and S.Developin = 'Pascal'

--85. Display the details of the programmers who joined before 1990. 
Select P.*
from Programmer P
where Year(P.DOJ) < 1990;

--86. Display the details of the software developed in C by the female programmers at Pragathi. 
Select S.*
from Programmer P
join Studies St on St.PName = P.PNAME
join Software S on S.PName = St.PName
where P.Gender = 'F'
and St.INSTITUTE = 'Pragathi'
and S.Developin = 'C';

--87. Display the number of packages, number of copies sold and sales value of each programmer institute wise. 
Select St.Institute, St.PName,
		Count(S.Title) as '# of Pkgs',
		sum(Sold) 'Total Copies Sold', 
		Sum(SCost*Sold) 'Total Revenue'
from Studies St 
left join Software S on S.PName = St.PName
group by St.Institute, St.PName
Order by St.Institute, St.PName

--88. Display the details of the software developed in dBase by male programmers who belong 
--to the institute in which the most number of programmers studied.
 --using temp table
Select Institute, Count(PName) as 'StudentCt'
Into #tempInstitute
from Studies
group by Institute 

Select S.*
from Software S
join Programmer P on P.PName = S.PName
join Studies St on St.PName = S.Pname
where P.Gender = 'M'
and S.Developin = 'dBase'
and St.Institute in (Select Institute
                    from #tempInstitute
				    where StudentCt = (Select Max(StudentCt) from #tempInstitute)
                    )

--89. Display the details of the software developed by the male programmers born before 1965 
--and female programmers born after 1975. 
Select P.PName, P.Gender, P.DOB,
       S.Developin, S.Title, S.DCost, S.Sold, S.SCost
from Programmer P 
left join Software S on P.PName = S.PName
Where (P.Gender = 'M' and Year(DOB) < 1965)
or (P.Gender = 'F' and Year(DOB) > 1975)

--90. Display the details of the software that has been developed in the language 
--which is neither the first nor the second proficiency of the programmers. 
Select Prof, Count(Prof) as 'CtProf', 
	   rank() over(Order by Count(Prof) desc) as 'CountRank'
into #tempAllProf
from
(Select Prof1 as 'Prof'
from Programmer
Union ALL
Select Prof2 
from Programmer)as ProfCt 
group by Prof

Select * 
from Software
where Developin in (Select Prof 
					from #tempAllProf 
					where CountRank > 2);


--91. Display the details of the software developed by the male students at Sabhari. 
Select S.*
From Software S
join Studies St on St.PName = S.Pname and St.Institute = 'Sabhari'
join Programmer P on P.PName = S.Pname and Gender = 'M'

--92. Display the names of the programmers who have not developed any packages.
Select PName
from Programmer P 
Except 
Select PName
From Software
--93. What is the total cost of the software developed by the programmers of Apple? 
Select Sum(dCost) as 'Total DCost'
from Software S
join Studies St on St.PName = S.Pname
where St.Institute = 'Apple'

--94. Who are the programmers who joined on the same day? 
Select P1.* 
from Programmer P1
join Programmer P2 on P1.DOJ = P2.Doj and P1.PName <> P2.PName 
order by P1.DOJ

--95. Who are the programmers who have the same Prof2? 
Select Distinct P1.PName,P1.Prof2
from Programmer P1
join Programmer P2 on P1.Prof2 = P2.Prof2 and P1.Pname <> P2.PName

--96. Display the total sales value of the software institute wise. 
Select St.INSTITUTE, Sum(sCost*Sold) as 'Total_Sales_Value'
from  Software S 
join Studies St on St.PName = S.Pname
group by St.INSTITUTE

--97. In which institute does the person who developed the costliest package study? 
Select S.PName , St.INSTITUTE
from Software S
join Studies St on St.Pname = S.Pname
where DCost = (Select Max(dCost)
               from Software)

--98. Which language listed in Prof1, Prof2 has not been used to develop any package? 
Create table #tempAllProf12(AllProf varchar(20))
Insert into #tempAllProf12
	Select distinct Prof1
	from Programmer P
	Union 
	Select distinct Prof2
	from Programmer P

Select *
from #tempAllProf12
where AllProf Not In(Select Distinct Developin from Software)

--99. How much does the person who developed the highest selling package earn 
     --and what course did he/she undergo?
Select P.PName,P.Salary,St.INSTITUTE
from Programmer P
join Software S on S.Pname = P.PName
join Studies St on St.PName = S.Pname
where S.sCost = (Select Max(sCost)
				 from Software)
--100. What is the average salary for those whose software sales is more than 50,000? 
Select Avg(Salary)
from Programmer P
join Software S on S.Pname = P.PName
where (DCost*Sold) > 50000;

--101. How many packages were developed by students who studied in institutes that charge the lowest course fee?
Select S.PName,
       Count(S.Title)'# of Packages Developed', 
	   St.Institute
From Software S
join Studies St on St.PName = S.Pname
where St.COURSE_FEE = (Select Min(Course_Fee) 
					   from Studies)
group by S.PName, St.Institute
--102. How many packages were developed by the person who developed the cheapest package? Where did he/she study?
Select S.PName,
       Count(S.Title)'# of Packages Developed', 
	   St.Institute
From Software S
join Studies St on St.PName = S.Pname
where S.DCost = (Select Min(DCost) from Software)
group by S.PName, St.Institute
--103. How many packages were developed by female programmers earning more than the highest paid male programmer?
Select --S.PName, 
       Count(Title)
From Software S
Right join 
(Select PName, Salary
from Programmer 
where Gender = 'F' 
and Salary >
			(Select Max(Salary) 
			from Programmer
			Where Gender = 'M')
) FemProg on S.PName = FemProg.PName
--group by S.Pname
--104. How many packages are developed by the most experienced programmers from BDPS?
;with BDPSCte AS
(Select P.Pname, Sr.Title,
		rank() over(Order by P.Doj Asc) as 'Experience'
From Programmer P
left Join Studies St on P.PNAME = St.PNAME
left join Software Sr on P.PName = Sr.PName
where St.Institute = 'BDPS'
)
Select BDPSCte.PName, Count(Title) as '# of Packages Developed'
From BDPSCte
group by BDPSCte.PName, Experience
having  Experience = 1 
--105. List the programmers (from the software table) and the institutes they studied at. 
Select Distinct S.PName, St.INSTITUTE
from Software S
join Studies St on S.Pname = St.Pname

--106. List each PROF with the number of programmers having that PROF and the number of the packages in that PROF. 
Select P2.Prof1, PrgCt as '# of Programmers',Count(Title) '# of Packages'
from Software S
right join
	(Select Prof1, Count(PName) as 'PrgCt'
	from (Select PName, Prof1
		from Programmer P
		Union 
		Select PName, Prof2
		from Programmer P) Pr 
	group by Prof1) P2 on P2.Prof1 = S.DEVELOPIN
group by P2.Prof1, PrgCt 
--107. List the programmer names (from the programmer table) and the number of packages each has developed.
Select PNAME, Count(Title) '# of Packages' 
from software s
group by PName;