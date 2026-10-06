
CREATE DATABASE FinalProject;

USE FinalProject;

CREATE TABLE Properties (
	PropertyID		INT PRIMARY KEY,
	Address			CHAR (50) NOT NULL,
	City			CHAR (50) NOT NULL,
	ZipCode			CHAR (10) NOT NULL,
	PropertyType	CHAR (15) NOT NULL, 
	Status			CHAR (15) NOT NULL, 
	Rooms			INT NOT NULL,
	Bathrooms		DECIMAL (2,1) NOT NULL
	);

CREATE TABLE Tenants (
	TenantID		INT PRIMARY KEY, 
	FirstName		CHAR (15) NOT NULL, 
	LastName		CHAR (15) NOT NULL, 
	Email			VARCHAR (50) NOT NULL,
	PhoneNumber		VARCHAR (15)
	);


CREATE TABLE LeaseAgreements (
	ContractID		INT PRIMARY KEY, 
	PropertyID		INT NOT NULL,
	TenantID		INT NOT NULL,
	StartDate		DATE NOT NULL, 
	EndDate			DATE NOT NULL,
	
CONSTRAINT FK_LeaseAgreement_Property -- "LeaseAgreements" is related to "Properties" throug PropertyID; if a property is deleted from the Properties table 
	FOREIGN KEY (PropertyID) REFERENCES Properties (PropertyID) -- ON DELETE CASCADE function will delete any related lease in the LeaseAgreements table:
	ON DELETE CASCADE,

CONSTRAINT FK_LeaseAgreement_Tenants -- "LeaseAgreements" is related to "Tenants" through TenantID; if a Tenant is deleted, delete any related leases.
	FOREIGN KEY (TenantID) REFERENCES Tenants (TenantID)
	ON DELETE CASCADE,

CONSTRAINT LeaseAgreements_Dates -- Make sure the end date of the lease comes after the start date
	CHECK (EndDate > StartDate)
);


CREATE TABLE MaintenanceRequests (
	RequestID		INT PRIMARY KEY, 
	PropertyID		INT NOT NULL,
	TenantID		INT,
	RequestDate		DATE NOT NULL, 
	Status			CHAR (50) NOT NULL,

-- If a property is remove, remove any related maintenance request

CONSTRAINT FK_MaintenanceRequests_Property
	FOREIGN KEY (PropertyID) REFERENCES Properties (PropertyID)
	ON DELETE CASCADE,

-- Ensure if a tenant is deleted, the tenant field is set to NULL, but the request record remains in the table.
CONSTRAINT FK_MaintenanceRequests_Tenant
    FOREIGN KEY (TenantID) REFERENCES Tenants(TenantID)
    ON DELETE SET NULL
	);


-- INSERTING VALUES

INSERT INTO Properties
	(PropertyID, Address, City, ZipCode, PropertyType, Status, Rooms, Bathrooms)
	VALUES
	(1, '123 Palm Ave','Miami','33101', 'Single Family', 'Available', 4, 3.5),
    (2, '456 Ocean Dr', 'Miami Beach','33139', 'Apartment', 'Occupied',  2, 2.0),
    (3, '789 Sunset Blvd','Coral Gables','33134','Apartment', 'Available', 2, 1.5),
    (4, '321 Oceanview Ln','Key Biscayne','33149','Townhouse', 'Maintenance', 3, 2.0),
    (5, '654 Pinecrest Rd','Pinecrest', '33156', 'Single Family', 'Occupied',  4, 3.0),
	(6, '875 Brickell Ave','Miami','33131', 'Studio','Occupied', 1, 1.0),
    (7, '230 Grove St','Coral Gables','33133', 'Apartment','Occupied',  2, 1.0),
    (8, '987 Collins Ave','Miami Beach','33139', 'Studio', 'Available', 1, 1.0),
    (9, '412 Miracle Mile','Coral Gables','33134', 'Single Family','Maintenance', 5, 5.0),
    (10, '522 Bayshore Dr','Miami','33137', 'Townhouse','Available', 3, 2.5);


INSERT INTO Tenants
	(TenantID, FirstName, LastName, Email, PhoneNumber)
	VALUES
	(101, 'Ingrid','Bedoya', 'ingrid.bedoya@email.com','3055551001'),
    (201, 'Carlos', 'Lopez', 'carlos.lopez@email.com','3055551002'),
    (301, 'Maria', 'Gonzalez', 'maria.gonzalez@email.com', NULL),
    (401, 'James', 'Martinez', 'james.martinez@email.com','3055551004'),
    (501, 'Laura', 'Perez', 'laura.perez@email.com', NULL ),
    (601, 'Sofia', 'Ramirez','sofia.ramirez@email.com', NULL),
    (701, 'Daniel','Torres','daniel.torres@email.com','3055551007'),
	(801, 'Henelis', 'Guzman', 'henelis.guzman@email.com','3055551008');

INSERT INTO LeaseAgreements
	(ContractID, PropertyID,TenantID,StartDate, EndDate)
	VALUES
    (1001, 2, 101, '2025-01-01', '2025-12-31'),
    (1002, 2, 201, '2025-01-01', '2025-12-31'),
    (1003, 5, 301, '2025-08-01', '2026-08-31'),
    (1004, 5, 401, '2024-02-01', '2026-01-31'),
    (1005, 5, 501, '2025-02-01', '2026-01-31'),
    (1006, 7, 601, '2025-11-01', '2026-11-30'),
    (1007, 7, 701, '2025-03-01', '2026-02-28'),
    (1008, 6, 801, '2024-11-01', '2025-11-30');

INSERT INTO MaintenanceRequests
	(RequestID, PropertyID,TenantID, RequestDate, Status)
	VALUES
    (901, 2, 101, '2025-01-15', 'Open'),
    (902, 2, 201, '2025-03-02', 'InProgress'),
    (903, 2, 101, '2025-06-10', 'Closed'),
    (904, 5, 401, '2025-01-20', 'Open'),
    (905, 5, 501, '2025-03-18', 'Closed'),
    (906, 5, 301, '2025-09-05', 'InProgress'),
    (907, 7, 701, '2025-04-12', 'Open'),
    (908, 7, 701, '2025-05-30', 'Closed'),
    (909, 7, 601, '2025-11-10', 'Open'),
    (910, 6, 801, '2025-02-22', 'InProgress'),
    (911, 6, 801, '2025-07-14', 'Closed'),
    (912, 1,  NULL, '2025-03-01', 'Open'),         
    (913, 3,  NULL, '2025-05-09', 'InProgress'),   
    (914, 4,  NULL, '2025-06-21', 'Open'),         
    (915, 8,  NULL, '2025-07-03', 'Canceled'); 


	SELECT *
	FROM Properties

	SELECT *
	FROM Tenants

	SELECT *
	FROM LeaseAgreements

	SELECT *
	FROM MaintenanceRequests

--2. Add a constraint to one variable in one of the tables.
/*	CONSTRAINT LeaseAgreements_Dates
	CHECK (EndDate > StartDate)
);


-- 2.1 Test the constraint by inserting a new record that violates it.
EndDate is before StartDate, so the check constraint will block this insert 

INSERT INTO LeaseAgreements
	(ContractID, PropertyID,TenantID,StartDate, EndDate)
VALUES
	(1014, 2, 101, '2025-01-01', '2020-12-31');*/

-- 3. Execute at least 3 different queries involving at least three different tables from your database.

-- 3.1 In at least one query, utilize Join operators to retrieve data from multiple tables.
-- Return each active lease along with the property address and tenant name 
-- This join uses three tables (LeaseAgreements, Properties, Tenants)

SELECT  
    p.Address, 
    p.City, 
    RTRIM(t.FirstName) + ' ' + RTRIM(t.LastName) AS TenantName,
    la.StartDate, 
    la.EndDate
FROM LeaseAgreements AS la
INNER JOIN Properties AS p 
	ON la.PropertyID = p.PropertyID
INNER JOIN Tenants AS t 
	ON la.TenantID = t.TenantID
ORDER BY la.EndDate;


-- 3.2 Utilize the HAVING clause in at least one of the queries.
-- Find properties with at least 2 maintenance requests and groups them by property 

SELECT    
	p.Address, 
	p.City,
COUNT(mr.RequestID) AS RequestCount
FROM Properties AS p
INNER JOIN MaintenanceRequests AS mr 
	ON p.PropertyID = mr.PropertyID
GROUP BY p.Address, p.City
HAVING COUNT(mr.RequestID) >= 2
ORDER BY RequestCount DESC;


-- 3.3 - List tenants whose leases and maintenance requests overlap
--List the leases that are expiring within 60 days

SELECT 
    DISTINCT P.Address,
    LA.EndDate,
    DATEDIFF(day, GETDATE(), LA.EndDate) AS DaysLeft
FROM LeaseAgreements AS LA
INNER JOIN Properties AS P
    ON LA.PropertyID = P.PropertyID
WHERE DATEDIFF(day, GETDATE(), LA.EndDate) <= 60;


-- 4. Update a column based on a condition that needs to be met using the WHERE clause.
-- Mark maintenance requests as Closed for a given property and date range *

UPDATE MaintenanceRequests
SET Status = 'Closed'
FROM MaintenanceRequests 
WHERE PropertyID = 2
AND Status <> 'Closed'

-- Verify the change
SELECT 
	RequestID, 
	Status
FROM MaintenanceRequests
WHERE PropertyID = 2;


-- 5. Retrieve data with a query directly into a variable. Ensure that variables are initially declared.
-- Retrieve the current lease properties in 2024

DECLARE @TotalListed2024 INT;
SELECT @TotalListed2024 = COUNT(*)
FROM LeaseAgreements
WHERE YEAR(StartDate) = 2024;
PRINT 'Total properties listed in 2024: ' + CAST(@TotalListed2024 AS VARCHAR(10));


/*6. Create a stored procedure that returns full details of one of the tables of your choosing 
based on a given condition using the WHERE clause.*/

--Stored procedure that accepts optional @PropertyID and/or @City parameters 

GO
CREATE PROCEDURE GetPropertiesByFilters
	@PropertyID INT = NULL,
	@City VARCHAR(50) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM Properties 
     WHERE 
		(@PropertyID IS NULL OR PropertyID = @PropertyID)
		AND 
		(@City IS NULL OR City = @City)  
    ORDER BY PropertyID;
END
GO

-- Usage of the stored procedure:

EXEC GetPropertiesByFilters @PropertyID = 5;  -- finds property 5
EXEC GetPropertiesByFilters @City = 'Miami';  -- finds all properties in Miami
EXEC GetPropertiesByFilters;                  -- returns all properties
