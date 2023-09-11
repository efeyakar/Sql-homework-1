--'986' kimli�ine sahip Y�netici alt�nda �al��an t�m �al��anlar�n EmpId ve FullName bilgilerini getiren bir SQL sorgusu yaz�n.

select EmpId ,FullName
    FROM [HOMEWORK].[dbo].[EmployeeDetails]
	where ManagerId = 986;

--EmployeeSalary tablosundan farkl� projeleri getiren bir SQL sorgusu yaz�n.

select distinct Project
from [HOMEWORK].[dbo].[EmployeeSalary]
where Project Is not null

--'P1' projesinde �al��an �al��an say�s�n� getiren bir SQL sorgusu yaz�n.

select COUNT(Project) as "P1 count"
from [HOMEWORK].[dbo].[EmployeeSalary]
where Project='P1';

--�al��anlar�n en y�ksek, en d���k ve ortalama maa��n� bulan bir SQL sorgusu yaz�n.

select AVG(salary) AS "Avarage",max(Salary) AS "Max", min(Salary) AS "Min"
from [HOMEWORK].[dbo].[EmployeeSalary];

--Maa�� 9000 ile 15000 aral���nda olan �al��anlar�n kimlik bilgisini bulan bir SQL sorgusu yaz�n

select [HOMEWORK].[dbo].[EmployeeDetails].* , [HOMEWORK].[dbo].[EmployeeSalary].Salary
from [HOMEWORK].[dbo].[EmployeeSalary]
inner join [HOMEWORK].[dbo].[EmployeeDetails]
on [HOMEWORK].[dbo].[EmployeeSalary].EmpId = [HOMEWORK].[dbo].[EmployeeDetails].EmpId
where Salary between 9000 and 15000;

-- ��z�m 2


select *
from [HOMEWORK].[dbo].[EmployeeDetails]
where EmpId in (select EmpId from [HOMEWORK].[dbo].[EmployeeSalary] where Salary between 9000 and 15000)


-- ��z�m 3 (Daha performansl� ��nk� 1 kere �arp��t�r�r)


Select *
from [HOMEWORK].[dbo].[EmployeeDetails] D, [HOMEWORK].[dbo].[EmployeeSalary] s
where s.Salary BETWEEN 9000 AND 15009 and D.EmpId = s.EmpId



--Toronto'da ya�ayan ve ManagerId'si 321 olan y�netici alt�nda �al��an �al��anlar� getiren bir SQL sorgusu yaz�n

select *
from [HOMEWORK].[dbo].[EmployeeDetails]
where City = 'Toronto' and ManagerId = '321';

--Ya Kaliforniya'da ya�ayan ya da ManagerId'si 321 olan bir y�netici alt�nda �al��an t�m �al��anlar� getiren bir SQL sorgusu yaz�n.

select *
from [HOMEWORK].[dbo].[EmployeeDetails]
where City = 'California' or ManagerId = '321';


--P1 d���ndaki projelerde �al��an t�m �al��anlar� getiren bir SQL sorgusu yaz�n.

select [HOMEWORK].[dbo].[EmployeeDetails].*, [HOMEWORK].[dbo].[EmployeeSalary].Project
from [HOMEWORK].[dbo].[EmployeeSalary]
inner join [HOMEWORK].[dbo].[EmployeeDetails]
on [HOMEWORK].[dbo].[EmployeeSalary].EmpId = [HOMEWORK].[dbo].[EmployeeDetails].EmpId
where [HOMEWORK].[dbo].[EmployeeSalary].Project != 'P1';



-- ��z�m 2



select *
from [HOMEWORK].[dbo].[EmployeeDetails]
where EmpId in (select EmpId from [HOMEWORK].[dbo].[EmployeeSalary] where Project != 'P1')

--Her �al��an�n toplam maa��n�, Salary ve Variable de�erlerini ekleyerek g�r�nt�leyen bir SQL sorgusu yaz�n.

select d.* , c.Salary , c.Variable , Salary + Variable as " Total"
from [HOMEWORK].[dbo].[EmployeeSalary] c, [HOMEWORK].[dbo].[EmployeeDetails] d
where c.EmpId = d.EmpId


--�smi herhangi iki karakterle ba�layan, ard�ndan "hn" metni gelen ve herhangi bir karakter dizisi ile biten �al��anlar� getiren bir SQL sorgusu yaz�n.
select *
from [HOMEWORK].[dbo].[EmployeeDetails]
where SUBSTRING(FullName,3,2) = 'hn';

--��z�m 2

select * 
from [HOMEWORK].[dbo].[EmployeeDetails]
where CHARINDEX('hn', FullName) = 3;

--��z�m 3

select *
from [HOMEWORK].[dbo].[EmployeeDetails]
where FullName like '__hn%'

--'EmployeeDetails' ve 'EmployeeSalary' tablolar�n�n herhangi birinde bulunan EmpIds bilgisini getiren bir SQL sorgusu yaz�n.select EmpId
from [HOMEWORK].[dbo].[EmployeeDetails]
union
select EmpId
from [HOMEWORK].[dbo].[EmployeeSalary]


-- Birinde olup di�erinde olmayan 

select EmpId
from [HOMEWORK].[dbo].[EmployeeDetails]
where EmpId not in (select EmpId from [HOMEWORK].[dbo].[EmployeeSalary] )

union

select EmpId
from [HOMEWORK].[dbo].[EmployeeSalary]
where EmpId not in (select EmpId from [HOMEWORK].[dbo].[EmployeeDetails] )


--�ki tablo aras�ndaki ortak kay�tlar� getiren bir SQL sorgusu yaz�n



select *
from [HOMEWORK].[dbo].[EmployeeSalary] S
inner join [HOMEWORK].[dbo].[EmployeeDetails] D on S.EmpId = D.EmpId


--Bir tabloda bulunan ancak di�er tabloda bulunmayan kay�tlar� getiren bir SQL sorgusu yaz�n.

SELECT *
FROM [HOMEWORK].[dbo].[EmployeeDetails] D
right JOIN [HOMEWORK].[dbo].[EmployeeSalary] S ON d.EmpId = S.EmpId
where  S.EmpId Is null


--'EmployeeDetails' ve 'EmployeeSalary' tablolar�nda bulunan EmpIds bilgisini getiren bir SQL sorgusu yaz�n.select *from [HOMEWORK].[dbo].[EmployeeSalary] S INNER JOIN [HOMEWORK].[dbo].[EmployeeDetails] D on S.EmpId = D.EmpId--��z�m 2select *from [HOMEWORK].[dbo].[EmployeeDetails] Dwhere D.EmpId in (select EmpId from [HOMEWORK].[dbo].[EmployeeSalary])--��z�m 3select *from [HOMEWORK].[dbo].[EmployeeSalary] S, [HOMEWORK].[dbo].[EmployeeDetails] Dwhere s.EmpId = D.EmpId--�al��anlar�n tam isimlerini bo�lu�u '-' ile de�i�tirerek getiren bir SQL sorgusu yaz�n. ('Replace' fonksiyonunu kullanarak)select EmpId as EmpId , REPLACE(FullName,' ' ,'-') as FullName , ManagerId as ManagerID, DateOfJoining as DateOfJoining , City as Cityfrom [HOMEWORK].[dbo].EmployeeDetails;--Verilen karakter(ler)in bir alan i�indeki konumunu getiren bir SQL sorgusu yaz�n.select CHARINDEX('a',City)from [HOMEWORK].[dbo].[EmployeeDetails] Dselect *from [HOMEWORK].[dbo].[EmployeeDetails] D



--EmpId ve ManagerId bilgisini bir arada g�r�nt�leyen bir SQL sorgusu yaz�n.


select c.EmpId , ManagerId
from [HOMEWORK].[dbo].[EmployeeSalary] c
inner join [HOMEWORK].[dbo].[EmployeeDetails] d
on d.EmpId = c.EmpId;

--Do�ru ��z�m

select CONCAT(EmpId , '-', ManagerId) as "EmpId-ManagerID"
from [HOMEWORK].[dbo].[EmployeeDetails]

--Do�ru ��z�m 2


select CONCAT(EmpId,CONCAT('-',ManagerId)) as "EmpId-ManagerID"
from [HOMEWORK].[dbo].[EmployeeDetails]


--�al��an ad�n� b�y�k harf yaparak ve �ehir de�erlerini k���k harf yaparak getiren bir SQL sorgusu yaz�n.


select EmpId as EmpId , UPPER(FullName) as FullName , ManagerId as ManagerID, DateOfJoining as DateOfJoining , LOWER(City) as City
from [HOMEWORK].[dbo].[EmployeeDetails]



--FullName alan�nda belirli bir karakter olan 'n' karakterinin toplam ka� kez bulundu�unu bulan bir SQL sorgusu yaz�n.
select LEN(FullName)from [HOMEWORK].[dbo].[EmployeeDetails]select FullName, LEN(FullName)- LEN(REPLACE(FullName,'n','')) as "i�inde ge�en n say�s�"from [HOMEWORK].[dbo].[EmployeeDetails]-- Ba��nda ve sonunda bo�luklar olan �al��an adlar�n� g�ncelleyen bir SQL sorgusu yaz�n.  tsqlUPDATE [HOMEWORK].[dbo].[EmployeeDetails]SET FullName = TRIM(FullName)--Herhangi bir projede �al��mayan t�m �al��anlar� getiren bir SQL sorgusu yaz�n.select c.EmpId as EmpId , FullName as FullName , ManagerId as ManagerID, DateOfJoining as DateOfJoining , City as City
from [HOMEWORK].[dbo].[EmployeeSalary] c
inner join [HOMEWORK].[dbo].[EmployeeDetails] d
on d.EmpId = c.EmpId
where Project is null


-- Maa�� 5000'den b�y�k ve 10000'den k���k veya e�it olan �al��anlar�n ad�n� getiren bir SQL sorgusu yaz�n.


select [HOMEWORK].[dbo].[EmployeeDetails].FullName, [HOMEWORK].[dbo].[EmployeeSalary].Salary
from [HOMEWORK].[dbo].[EmployeeSalary]
inner join [HOMEWORK].[dbo].[EmployeeDetails]
on [HOMEWORK].[dbo].[EmployeeSalary].EmpId = [HOMEWORK].[dbo].[EmployeeDetails].EmpId
where Salary > 5000 and Salary <= 10000;


--Ge�erli tarih ve saati bulan bir SQL sorgusu yaz�n.
SELECT SYSDATETIME();
select CONVERT(varchar, GETDATE(), 13)


--EmployeeDetails tablosuna kat�lan t�m �al��an ayr�nt�lar�n�, 2020 y�l�nda kat�lanlar� getiren bir SQL sorgusu yaz�n

select *
from [HOMEWORK].[dbo].[EmployeeDetails]
where YEAR(DateOfJoining) = 2020;

--��z�m 2

select *
from [HOMEWORK].[dbo].[EmployeeDetails]
where DateOfJoining LIKE '2020%'


--��z�m 3 
select *
from [HOMEWORK].[dbo].[EmployeeDetails]
where DateOfJoining between '2020-01-01' and '2020-12-31'

-- ��z�m 4

select *
from [HOMEWORK].[dbo].[EmployeeDetails]
where DateOfJoining between CONVERT(DATETIME,'2020-01-01') and CONVERT(DATETIME,'2020-12-31')



--EmployeeSalary tablosunda maa� kayd� olan t�m �al��an kay�tlar�n� getiren bir SQL sorgusu yaz�n

select c.EmpId as EmpId , FullName as FullName , ManagerId as ManagerID, DateOfJoining as DateOfJoining , City as City
from [HOMEWORK].[dbo].[EmployeeSalary] c
inner join [HOMEWORK].[dbo].[EmployeeDetails] d
on d.EmpId = c.EmpId
where Salary is not null

--�al��an adlar�n� ve maa� kay�tlar�n� getiren bir sorgu yaz�n. Maa� kayd� �al��an i�in mevcut olmasa bile �al��an ayr�nt�lar�n� g�r�nt�leyin

select FullName , Salary
from [HOMEWORK].[dbo].[EmployeeSalary] c
inner join [HOMEWORK].[dbo].[EmployeeDetails] d
on d.EmpId = c.EmpId






------------------------------------------------------------------
------------------------------------------------------------------
---------------------------JOIN KONUSU----------------------------
------------------------------------------------------------------
------------------------------------------------------------------

--- INNER JOIN CROSS JOIN LEFT JOIN R�GHT JOIN ---

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



-----------Hi� proje yapmayan �al��anlar


select  *
from [HOMEWORK].[dbo].[EmployeeSalary]
Left JOIN [HOMEWORK].[dbo].[EmployeeDetails]
ON [HOMEWORK].[dbo].[EmployeeDetails].EmpId = [HOMEWORK].[dbo].[EmployeeSalary].EmpId
where [HOMEWORK].[dbo].[EmployeeSalary].Project IS NULL


