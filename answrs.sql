--'986' kimliðine sahip Yönetici altýnda çalýþan tüm çalýþanlarýn EmpId ve FullName bilgilerini getiren bir SQL sorgusu yazýn.

select EmpId ,FullName
    FROM [HOMEWORK].[dbo].[EmployeeDetails]
	where ManagerId = 986;

--EmployeeSalary tablosundan farklý projeleri getiren bir SQL sorgusu yazýn.

select distinct Project
from [HOMEWORK].[dbo].[EmployeeSalary]
where Project Is not null

--'P1' projesinde çalýþan çalýþan sayýsýný getiren bir SQL sorgusu yazýn.

select COUNT(Project) as "P1 count"
from [HOMEWORK].[dbo].[EmployeeSalary]
where Project='P1';

--Çalýþanlarýn en yüksek, en düþük ve ortalama maaþýný bulan bir SQL sorgusu yazýn.

select AVG(salary) AS "Avarage",max(Salary) AS "Max", min(Salary) AS "Min"
from [HOMEWORK].[dbo].[EmployeeSalary];

--Maaþý 9000 ile 15000 aralýðýnda olan çalýþanlarýn kimlik bilgisini bulan bir SQL sorgusu yazýn

select [HOMEWORK].[dbo].[EmployeeDetails].* , [HOMEWORK].[dbo].[EmployeeSalary].Salary
from [HOMEWORK].[dbo].[EmployeeSalary]
inner join [HOMEWORK].[dbo].[EmployeeDetails]
on [HOMEWORK].[dbo].[EmployeeSalary].EmpId = [HOMEWORK].[dbo].[EmployeeDetails].EmpId
where Salary between 9000 and 15000;

-- Çözüm 2


select *
from [HOMEWORK].[dbo].[EmployeeDetails]
where EmpId in (select EmpId from [HOMEWORK].[dbo].[EmployeeSalary] where Salary between 9000 and 15000)


-- Çözüm 3 (Daha performanslý çünkü 1 kere çarpýþtýrýr)


Select *
from [HOMEWORK].[dbo].[EmployeeDetails] D, [HOMEWORK].[dbo].[EmployeeSalary] s
where s.Salary BETWEEN 9000 AND 15009 and D.EmpId = s.EmpId



--Toronto'da yaþayan ve ManagerId'si 321 olan yönetici altýnda çalýþan çalýþanlarý getiren bir SQL sorgusu yazýn

select *
from [HOMEWORK].[dbo].[EmployeeDetails]
where City = 'Toronto' and ManagerId = '321';

--Ya Kaliforniya'da yaþayan ya da ManagerId'si 321 olan bir yönetici altýnda çalýþan tüm çalýþanlarý getiren bir SQL sorgusu yazýn.

select *
from [HOMEWORK].[dbo].[EmployeeDetails]
where City = 'California' or ManagerId = '321';


--P1 dýþýndaki projelerde çalýþan tüm çalýþanlarý getiren bir SQL sorgusu yazýn.

select [HOMEWORK].[dbo].[EmployeeDetails].*, [HOMEWORK].[dbo].[EmployeeSalary].Project
from [HOMEWORK].[dbo].[EmployeeSalary]
inner join [HOMEWORK].[dbo].[EmployeeDetails]
on [HOMEWORK].[dbo].[EmployeeSalary].EmpId = [HOMEWORK].[dbo].[EmployeeDetails].EmpId
where [HOMEWORK].[dbo].[EmployeeSalary].Project != 'P1';



-- Çözüm 2



select *
from [HOMEWORK].[dbo].[EmployeeDetails]
where EmpId in (select EmpId from [HOMEWORK].[dbo].[EmployeeSalary] where Project != 'P1')

--Her çalýþanýn toplam maaþýný, Salary ve Variable deðerlerini ekleyerek görüntüleyen bir SQL sorgusu yazýn.

select d.* , c.Salary , c.Variable , Salary + Variable as " Total"
from [HOMEWORK].[dbo].[EmployeeSalary] c, [HOMEWORK].[dbo].[EmployeeDetails] d
where c.EmpId = d.EmpId


--Ýsmi herhangi iki karakterle baþlayan, ardýndan "hn" metni gelen ve herhangi bir karakter dizisi ile biten çalýþanlarý getiren bir SQL sorgusu yazýn.
select *
from [HOMEWORK].[dbo].[EmployeeDetails]
where SUBSTRING(FullName,3,2) = 'hn';

--Çözüm 2

select * 
from [HOMEWORK].[dbo].[EmployeeDetails]
where CHARINDEX('hn', FullName) = 3;

--Çözüm 3

select *
from [HOMEWORK].[dbo].[EmployeeDetails]
where FullName like '__hn%'

--'EmployeeDetails' ve 'EmployeeSalary' tablolarýnýn herhangi birinde bulunan EmpIds bilgisini getiren bir SQL sorgusu yazýn.select EmpId
from [HOMEWORK].[dbo].[EmployeeDetails]
union
select EmpId
from [HOMEWORK].[dbo].[EmployeeSalary]


-- Birinde olup diðerinde olmayan 

select EmpId
from [HOMEWORK].[dbo].[EmployeeDetails]
where EmpId not in (select EmpId from [HOMEWORK].[dbo].[EmployeeSalary] )

union

select EmpId
from [HOMEWORK].[dbo].[EmployeeSalary]
where EmpId not in (select EmpId from [HOMEWORK].[dbo].[EmployeeDetails] )


--Ýki tablo arasýndaki ortak kayýtlarý getiren bir SQL sorgusu yazýn



select *
from [HOMEWORK].[dbo].[EmployeeSalary] S
inner join [HOMEWORK].[dbo].[EmployeeDetails] D on S.EmpId = D.EmpId


--Bir tabloda bulunan ancak diðer tabloda bulunmayan kayýtlarý getiren bir SQL sorgusu yazýn.

SELECT *
FROM [HOMEWORK].[dbo].[EmployeeDetails] D
right JOIN [HOMEWORK].[dbo].[EmployeeSalary] S ON d.EmpId = S.EmpId
where  S.EmpId Is null


--'EmployeeDetails' ve 'EmployeeSalary' tablolarýnda bulunan EmpIds bilgisini getiren bir SQL sorgusu yazýn.select *from [HOMEWORK].[dbo].[EmployeeSalary] S INNER JOIN [HOMEWORK].[dbo].[EmployeeDetails] D on S.EmpId = D.EmpId--Çözüm 2select *from [HOMEWORK].[dbo].[EmployeeDetails] Dwhere D.EmpId in (select EmpId from [HOMEWORK].[dbo].[EmployeeSalary])--Çözüm 3select *from [HOMEWORK].[dbo].[EmployeeSalary] S, [HOMEWORK].[dbo].[EmployeeDetails] Dwhere s.EmpId = D.EmpId--Çalýþanlarýn tam isimlerini boþluðu '-' ile deðiþtirerek getiren bir SQL sorgusu yazýn. ('Replace' fonksiyonunu kullanarak)select EmpId as EmpId , REPLACE(FullName,' ' ,'-') as FullName , ManagerId as ManagerID, DateOfJoining as DateOfJoining , City as Cityfrom [HOMEWORK].[dbo].EmployeeDetails;--Verilen karakter(ler)in bir alan içindeki konumunu getiren bir SQL sorgusu yazýn.select CHARINDEX('a',City)from [HOMEWORK].[dbo].[EmployeeDetails] Dselect *from [HOMEWORK].[dbo].[EmployeeDetails] D



--EmpId ve ManagerId bilgisini bir arada görüntüleyen bir SQL sorgusu yazýn.


select c.EmpId , ManagerId
from [HOMEWORK].[dbo].[EmployeeSalary] c
inner join [HOMEWORK].[dbo].[EmployeeDetails] d
on d.EmpId = c.EmpId;

--Doðru çözüm

select CONCAT(EmpId , '-', ManagerId) as "EmpId-ManagerID"
from [HOMEWORK].[dbo].[EmployeeDetails]

--Doðru Çözüm 2


select CONCAT(EmpId,CONCAT('-',ManagerId)) as "EmpId-ManagerID"
from [HOMEWORK].[dbo].[EmployeeDetails]


--Çalýþan adýný büyük harf yaparak ve þehir deðerlerini küçük harf yaparak getiren bir SQL sorgusu yazýn.


select EmpId as EmpId , UPPER(FullName) as FullName , ManagerId as ManagerID, DateOfJoining as DateOfJoining , LOWER(City) as City
from [HOMEWORK].[dbo].[EmployeeDetails]



--FullName alanýnda belirli bir karakter olan 'n' karakterinin toplam kaç kez bulunduðunu bulan bir SQL sorgusu yazýn.
select LEN(FullName)from [HOMEWORK].[dbo].[EmployeeDetails]select FullName, LEN(FullName)- LEN(REPLACE(FullName,'n','')) as "içinde geçen n sayýsý"from [HOMEWORK].[dbo].[EmployeeDetails]-- Baþýnda ve sonunda boþluklar olan çalýþan adlarýný güncelleyen bir SQL sorgusu yazýn.  tsqlUPDATE [HOMEWORK].[dbo].[EmployeeDetails]SET FullName = TRIM(FullName)--Herhangi bir projede çalýþmayan tüm çalýþanlarý getiren bir SQL sorgusu yazýn.select c.EmpId as EmpId , FullName as FullName , ManagerId as ManagerID, DateOfJoining as DateOfJoining , City as City
from [HOMEWORK].[dbo].[EmployeeSalary] c
inner join [HOMEWORK].[dbo].[EmployeeDetails] d
on d.EmpId = c.EmpId
where Project is null


-- Maaþý 5000'den büyük ve 10000'den küçük veya eþit olan çalýþanlarýn adýný getiren bir SQL sorgusu yazýn.


select [HOMEWORK].[dbo].[EmployeeDetails].FullName, [HOMEWORK].[dbo].[EmployeeSalary].Salary
from [HOMEWORK].[dbo].[EmployeeSalary]
inner join [HOMEWORK].[dbo].[EmployeeDetails]
on [HOMEWORK].[dbo].[EmployeeSalary].EmpId = [HOMEWORK].[dbo].[EmployeeDetails].EmpId
where Salary > 5000 and Salary <= 10000;


--Geçerli tarih ve saati bulan bir SQL sorgusu yazýn.
SELECT SYSDATETIME();
select CONVERT(varchar, GETDATE(), 13)


--EmployeeDetails tablosuna katýlan tüm Çalýþan ayrýntýlarýný, 2020 yýlýnda katýlanlarý getiren bir SQL sorgusu yazýn

select *
from [HOMEWORK].[dbo].[EmployeeDetails]
where YEAR(DateOfJoining) = 2020;

--Çözüm 2

select *
from [HOMEWORK].[dbo].[EmployeeDetails]
where DateOfJoining LIKE '2020%'


--Çözüm 3 
select *
from [HOMEWORK].[dbo].[EmployeeDetails]
where DateOfJoining between '2020-01-01' and '2020-12-31'

-- çözüm 4

select *
from [HOMEWORK].[dbo].[EmployeeDetails]
where DateOfJoining between CONVERT(DATETIME,'2020-01-01') and CONVERT(DATETIME,'2020-12-31')



--EmployeeSalary tablosunda maaþ kaydý olan tüm çalýþan kayýtlarýný getiren bir SQL sorgusu yazýn

select c.EmpId as EmpId , FullName as FullName , ManagerId as ManagerID, DateOfJoining as DateOfJoining , City as City
from [HOMEWORK].[dbo].[EmployeeSalary] c
inner join [HOMEWORK].[dbo].[EmployeeDetails] d
on d.EmpId = c.EmpId
where Salary is not null

--Çalýþan adlarýný ve maaþ kayýtlarýný getiren bir sorgu yazýn. Maaþ kaydý çalýþan için mevcut olmasa bile çalýþan ayrýntýlarýný görüntüleyin

select FullName , Salary
from [HOMEWORK].[dbo].[EmployeeSalary] c
inner join [HOMEWORK].[dbo].[EmployeeDetails] d
on d.EmpId = c.EmpId






------------------------------------------------------------------
------------------------------------------------------------------
---------------------------JOIN KONUSU----------------------------
------------------------------------------------------------------
------------------------------------------------------------------

--- INNER JOIN CROSS JOIN LEFT JOIN RÝGHT JOIN ---

SELECT *
FROM [HOMEWORK].[dbo].[EmployeeSalary] S 
INNER JOIN [HOMEWORK].[dbo].[EmployeeDetails] D ON S.EmpId = D.EmpId


SELECT *
from [HOMEWORK].[dbo].[EmployeeSalary]
CROSS JOIN [HOMEWORK].[dbo].[EmployeeDetails]
 


SELECT *
FROM [HOMEWORK].[dbo].[EmployeeDetails] D
LEFT JOIN [HOMEWORK].[dbo].[EmployeeSalary] S ON d.EmpId = S.EmpId





SELECT *
FROM [HOMEWORK].[dbo].[EmployeeDetails] D
RIGHT JOIN [HOMEWORK].[dbo].[EmployeeSalary] S ON d.EmpId = S.EmpId



-----------Hiç proje yapmayan çalýþanlar


select  *
from [HOMEWORK].[dbo].[EmployeeSalary]
Left JOIN [HOMEWORK].[dbo].[EmployeeDetails]
ON [HOMEWORK].[dbo].[EmployeeDetails].EmpId = [HOMEWORK].[dbo].[EmployeeSalary].EmpId
where [HOMEWORK].[dbo].[EmployeeSalary].Project IS NULL


