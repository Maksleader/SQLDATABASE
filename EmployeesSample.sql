
CREATE TABLE Employees
(
  EmployeeID int NOT NULL PRIMARY KEY,
  FirstName varchar(50) NOT NULL,
  LastName varchar(50) NOT NULL,
  ManagerID int NULL
)
GO
INSERT INTO Employees VALUES (1, 'Ken', 'Thompson', NULL)
INSERT INTO Employees VALUES (2, 'Terri', 'Ryan', 1)
INSERT INTO Employees VALUES (3, 'Robert', 'Durello', 1)
INSERT INTO Employees VALUES (4, 'Rob', 'Bailey', 2)
INSERT INTO Employees VALUES (5, 'Kent', 'Erickson', 2)
INSERT INTO Employees VALUES (6, 'Bill', 'Goldberg', 3)
INSERT INTO Employees VALUES (7, 'Ryan', 'Miller', 3)
INSERT INTO Employees VALUES (8, 'Dane', 'Mark', 5)
INSERT INTO Employees VALUES (9, 'Charles', 'Matthew', 6)
INSERT INTO Employees VALUES (10, 'Michael', 'Jhonson', 6) 
INSERT INTO Employees VALUES (11, 'Test', 'Test', 9) 
INSERT INTO Employees VALUES (12, 'Test1', 'Test1', 10) 


GO

CREATE PROCEDURE spManagers
@ID INT  
AS  
WITH   subordinate AS (  
    SELECT  EmployeeID,  
            FirstName,  
            LastName,  
            ManagerID,  
            1 AS level  
    FROM Employees  
    WHERE EmployeeID = @ID  
   
    UNION ALL  
   
    SELECT  e.EmployeeID,  
            e.FirstName,  
            e.LastName,  
            e.ManagerID,  
            level + 1
    FROM Employees e  
JOIN subordinate s  
ON e.EmployeeID=s.ManagerId
)  
   
  
SELECT    
    m.EmployeeID AS direct_superior_id,  
    m.FirstName AS direct_superior_first_name,  
    m.LastName AS direct_superior_last_name,  
    s.level
FROM Employees m

JOIN subordinate s 
ON s.ManagerID = m.EmployeeID

ORDER BY level; 
GO

CREATE PROCEDURE [dbo].[spEmployees]
@ID INT  
AS  
WITH   subordinate AS (  
    SELECT  EmployeeID,  
            FirstName,  
            LastName,  
            ManagerID,  
            0 AS level  
    FROM Employees  
    WHERE EmployeeID = @ID  
   
    UNION ALL  
   
    SELECT  e.EmployeeID,  
            e.FirstName,  
            e.LastName,  
            e.ManagerID,  
            level + 1  
    FROM Employees e  
JOIN subordinate s  
ON e.ManagerID=s.EmployeeID
)  
   
  
SELECT   
   s.EmployeeID,  
   s.FirstName AS subordinate_first_name,  
   s.LastName AS subordinate_last_name,  
    m.EmployeeID AS direct_superior_id,  
    m.FirstName AS direct_superior_first_name,  
    m.LastName AS direct_superior_last_name,  
    s.level 
FROM subordinate s

JOIN Employees m  
ON s.ManagerId = m.EmployeeID 
WHERE s.level>0
ORDER BY level; 
Go

SELECT *FROM Employees;

exec spEmployees 6

exec spManagers 6