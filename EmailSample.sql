CREATE TABLE Employee
    ( 
    [ID] INT identity(1,1), 
    [FirstName] Varchar(100), 
    [LastName] Varchar(100), 
    [Email] Varchar(100), 
	[Register Date] smalldatetime 
    ) 
    GO 
     Insert into Employee ([FirstName],[LastName],[Email],[Register Date] )values
								('Sam','Adison','s@s.com','13-11-22'),
                                ('Raj','Gupta','r@r.com','11-10-22'),
                                ('Mohan','Kumar','m@m.com','09-10-22'),
                                ('Max','Barry','m@m.com','08-10-22'),
                                ('James','Barry','j@j.com','06-10-22'),
                                ('Jerry','Barry','j@j.com','05-10-22'),
								('John','Adams','j@j.com','05-10-22')



GO
CREATE PROCEDURE spDeleteDuplicate
AS
DELETE FROM [Employee]
    WHERE ID Not IN
(
   SELECT ID
FROM Employee
WHERE [Register Date]  IN
(
    SELECT MAX([Register Date]) AS MinRegisterDate
        FROM [Employee]
		 GROUP BY[Email]
)

);
GO


SELECT *FROM Employee;
exec dbo.spDeleteDuplicate
