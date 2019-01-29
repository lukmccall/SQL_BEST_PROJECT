------------------------------------------------------- TWORZENIE TABEL
IF OBJECT_ID('dbo.ActiveServices', 'U') IS NOT NULL 
	DROP TABLE ActiveServices
GO
CREATE TABLE ActiveServices (
    ServicesId     INT NOT NULL,
    ClientsLogin   nvarchar (30) NOT NULL, 
    StartDate      datetime DEFAULT GETDATE(),
    EndDate        datetime NOT NULL
)
GO

ALTER TABLE ActiveServices ADD constraint ActiveServices_PK PRIMARY KEY CLUSTERED (ServicesId, ClientsLogin, EndDate)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON ) 
GO


IF OBJECT_ID('dbo.BonusSalary', 'U') IS NOT NULL 
	DROP TABLE BonusSalary
GO
CREATE TABLE BonusSalary ( 
	EmployeesId INT NOT NULL, 
	ReceivedDate DATE DEFAULT GETDATE(),
	BonusSalary money NOT NULL,
	ReceiveFor nvarchar (30) DEFAULT N'Bonus' )
GO

ALTER TABLE BonusSalary ADD constraint BonusSalary_PK PRIMARY KEY CLUSTERED (EmployeesId, ReceivedDate)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON ) 
GO

IF OBJECT_ID('dbo.Categories', 'U') IS NOT NULL 
	DROP TABLE Categories
GO
CREATE TABLE Categories (
    Id     INT IDENTITY(1,1),
    Category   nvarchar(30) 
)
GO

ALTER TABLE Categories ADD constraint Categories_PK PRIMARY KEY CLUSTERED (Id)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON ) 
GO

IF OBJECT_ID('dbo.Clients', 'U') IS NOT NULL 
	DROP TABLE Clients
GO
CREATE TABLE Clients ( 
	Login nvarchar (30) NOT NULL , 
	PeopleId INT NOT NULL,
    Password NVARCHAR (30)
)
GO 

ALTER TABLE Clients ADD constraint Clients_PK PRIMARY KEY CLUSTERED (Login)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON ) 
GO

IF OBJECT_ID('dbo.Comments', 'U') IS NOT NULL 
	DROP TABLE Comments
GO
CREATE TABLE Comments ( 
	NewsId INT NOT NULL , 
    ClientsLogin NVARCHAR(30) NOT NULL,
    AddDate DATETIME DEFAULT GETDATE(),
	CommentBody text
)
GO

ALTER TABLE Comments ADD constraint Comments_PK PRIMARY KEY CLUSTERED (AddDate, NewsId, ClientsLogin)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON ) 
GO

IF OBJECT_ID('dbo.Employees', 'U') IS NOT NULL 
	DROP TABLE Employees
GO
CREATE TABLE Employees (
    PeopleId      INT NOT NULL,
    HireDate       DATE DEFAULT GETDATE(),
    PositionsId   INT NOT NULL,
    BossId           INT
)
GO

ALTER TABLE Employees ADD constraint Employees_PK PRIMARY KEY CLUSTERED (PeopleId)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON ) 
GO

IF OBJECT_ID('dbo.ExpiredServices', 'U') IS NOT NULL 
	DROP TABLE ExpiredServices
GO
CREATE TABLE ExpiredServices (
	ServicesId     INT NOT NULL,
    ClientsLogin   nvarchar (30) NOT NULL,
    StartDate      datetime DEFAULT GETDATE(),
    EndDate        datetime NOT NULL
) 
GO
ALTER TABLE ExpiredServices ADD constraint ExpiredServices_PK PRIMARY KEY CLUSTERED (ServicesId, ClientsLogin, EndDate)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON ) 
GO

IF OBJECT_ID('dbo.Items', 'U') IS NOT NULL 
	DROP TABLE Items
GO
CREATE TABLE Items (
    Id		     INT NOT NULL,
    Name         nvarchar (30) , 
    CategoriesId INT NOT NULL ) 
GO

ALTER TABLE Items ADD constraint Items_PK PRIMARY KEY CLUSTERED (Id)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON ) 
GO

IF OBJECT_ID('dbo.ItemsInWarehouse', 'U') IS NOT NULL 
	DROP TABLE ItemsInWarehouse
GO
CREATE TABLE ItemsInWarehouse (
    ItemsId       INT NOT NULL,
	WarehouseId   INT NOT NULL,
    Quantity       INT
)
GO

ALTER TABLE ItemsInWarehouse ADD constraint ItemsInWarehouse_PK PRIMARY KEY CLUSTERED (ItemsId, WarehouseId)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON ) 
GO

IF OBJECT_ID('dbo.Logs', 'U') IS NOT NULL 
	DROP TABLE Logs
GO
CREATE TABLE Logs( 
	 Id INT IDENTITY(1,1),
	 Date DATETIME DEFAULT GETDATE(), 
     Info TEXT , 
     Level CHAR(1) DEFAULT 'I'
) 
GO

ALTER TABLE Logs ADD constraint Logs_PK PRIMARY KEY CLUSTERED (Id)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON ) 
GO

IF OBJECT_ID('dbo.News', 'U') IS NOT NULL 
	DROP TABLE News
GO
CREATE TABLE News ( 
	Id INT IDENTITY(1,1), 
    Topic nvarchar(30) NOT NULL,
	NewsBody text NOT NULL, 
	Date datetime DEFAULT GETDATE()
)
GO

ALTER TABLE News ADD constraint News_PK PRIMARY KEY CLUSTERED (Id)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON ) 
GO

IF OBJECT_ID('dbo.Orders', 'U') IS NOT NULL 
	DROP TABLE Orders
GO
CREATE TABLE Orders (
    Id             INT IDENTITY(1,1),
    PurchaseDate   datetime DEFAULT GETDATE(),
    City           nvarchar (30) , 
    Country		   NVARCHAR (30) , 
    Address		   NVARCHAR (30) , 
    ClientsLogin   NVARCHAR (30) NOT NULL 
) 
GO

ALTER TABLE Orders ADD constraint Orders_PK PRIMARY KEY CLUSTERED (Id)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON ) 
GO


IF OBJECT_ID('dbo.OrdersDetails', 'U') IS NOT NULL 
	DROP TABLE OrdersDetails
GO
CREATE TABLE OrdersDetails (
    OrdersId     INT NOT NULL,
    ProductsId   INT NOT NULL,
    UnitPrice     money NOT NULL,
    Quantity      SMALLINT NOT NULL,
    Discount      INT NOT NULL
)
GO

ALTER TABLE OrdersDetails ADD constraint OrdersDetails_PK PRIMARY KEY CLUSTERED (OrdersId, ProductsId)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON ) 
GO

IF OBJECT_ID('dbo.Status', 'U') IS NOT NULL 
	DROP TABLE Status
GO
CREATE TABLE Status(
	Id INT IDENTITY(1,1),
	StatusInfo text,
)
GO

ALTER TABLE Status ADD constraint Status_PK PRIMARY KEY CLUSTERED (Id)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON ) 
GO

IF OBJECT_ID('dbo.OrdersStatus', 'U') IS NOT NULL 
	DROP TABLE OrdersStatus
GO
CREATE TABLE OrdersStatus (
    OrdersId    INT NOT NULL,
    StatusId    INT NOT NULL,
)
GO

ALTER TABLE OrdersStatus ADD constraint OrdersStatus_PK PRIMARY KEY CLUSTERED (OrdersId)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON ) 
GO

IF OBJECT_ID('dbo.Payments', 'U') IS NOT NULL 
	DROP TABLE Payments
GO
CREATE TABLE Payments ( 
	Id				INT IDENTITY(1,1), 
	PaymentsTypsId	INT NOT NULL , 
    OrdersId		INT NOT NULL,
    PaymentDate		DATETIME DEFAULT GETDATE(), 
    Value			MONEY
)
Go

ALTER TABLE Payments ADD constraint Payments_PK PRIMARY KEY CLUSTERED (Id)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON ) 
GO

IF OBJECT_ID('dbo.PaymentsTyps', 'U') IS NOT NULL 
	DROP TABLE PaymentsTyps
GO
CREATE TABLE PaymentsTyps (
    Id     INT IDENTITY(1,1),
    Type   nvarchar(30) NOT NULL, 
    Provider NVARCHAR(30) NOT NULL, 
	TermsUrl nvarchar(30) 
)
GO

ALTER TABLE PaymentsTyps ADD constraint PaymentsTyps_PK PRIMARY KEY CLUSTERED (Id)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
Go

IF OBJECT_ID('dbo.People', 'U') IS NOT NULL 
	DROP TABLE People
GO
CREATE TABLE People (
    Id     INT IDENTITY(1,1),
    Name   nvarchar (30) NOT NULL, 
    Surname NVARCHAR (30) NOT NULL, 
    Email NVARCHAR (30) NOT NULL, 
	Phone nvarchar(12),
	Country NVARCHAR(30),
	City NVARCHAR(30),
	Adress NVARCHAR(30)
)
GO

ALTER TABLE People ADD constraint People_pk PRIMARY KEY CLUSTERED (Id)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON ) 
Go

IF OBJECT_ID('dbo.Positions', 'U') IS NOT NULL 
	DROP TABLE Positions
GO
CREATE TABLE Positions (
    Id         INT IDENTITY(1,1),
    Position   nvarchar(30) NOT NULL, 
	Salary	INT NOT NULL ) 
GO

ALTER TABLE Positions ADD constraint Positions_PK PRIMARY KEY CLUSTERED (Id)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON ) 
Go

IF OBJECT_ID('dbo.Products', 'U') IS NOT NULL 
	DROP TABLE Products
GO
CREATE TABLE Products (
    Id            INT NOT NULL,
    Description   text NOT NULL
)
GO

ALTER TABLE Products ADD constraint Products_PK PRIMARY KEY CLUSTERED (Id)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON ) 
GO

IF OBJECT_ID('dbo.ProductsPrices', 'U') IS NOT NULL 
	DROP TABLE ProductsPrices
GO
CREATE TABLE ProductsPrices (
    ProductsId   INT NOT NULL,
    StartDate     datetime DEFAULT GETDATE(),
    EndDate       datetime DEFAULT NULL,
    UnitPrice     money
)
GO

ALTER TABLE ProductsPrices ADD constraint ProductsPrices_pk PRIMARY KEY CLUSTERED (ProductsId, StartDate)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON ) 
GO

IF OBJECT_ID('dbo.PromotionCodes', 'U') IS NOT NULL 
	DROP TABLE PromotionCodes
GO
CREATE TABLE PromotionCodes (
    Id				INT IDENTITY(1,1),
	ProductsId		INT NOT NULL,
	Discount		INT,
    Code			nvarchar (10) NOT NULL, 
    ExpirDate		DATETIME NOT NULL , 
    ClientsLogin	NVARCHAR (30),
	OrdersId		INT
) 
Go

ALTER TABLE PromotionCodes ADD constraint PromotionCodes_pk PRIMARY KEY CLUSTERED (Id)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON ) 
GO

IF OBJECT_ID('dbo.Ratings', 'U') IS NOT NULL 
	DROP TABLE Ratings
GO
CREATE TABLE Ratings( 
	ClientsLogin nvarchar (30) NOT NULL ,
	ProductsId INT NOT NULL, 
    Rating SMALLINT NOT NULL, 
    AddDate DATETIME DEFAULT GETDATE()
) 
GO

ALTER TABLE Ratings ADD constraint Ratings_pk PRIMARY KEY CLUSTERED (ClientsLogin, ProductsId)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON ) 
GO

IF OBJECT_ID('dbo.Sales', 'U') IS NOT NULL 
	DROP TABLE Sales
GO
CREATE TABLE Sales (
    ProductsId   INT NOT NULL,
    UnitPrice     money NOT NULL,
    Until         datetime NOT NULL
)
GO

ALTER TABLE Sales ADD constraint Sales_PK PRIMARY KEY CLUSTERED (ProductsId)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON ) 
GO

IF OBJECT_ID('dbo.Services', 'U') IS NOT NULL 
	DROP TABLE Services
GO
CREATE TABLE Services (
    Id			 INT NOT NULL,
    Name		 nvarchar (30) NOT NULL, 
    Time	     INT , 
    CategoriesId INT NOT NULL ) 
GO

ALTER TABLE Services ADD constraint Services_PK PRIMARY KEY CLUSTERED (Id)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON ) 
GO

IF OBJECT_ID('dbo.Warehouse', 'U') IS NOT NULL 
	DROP TABLE Warehouse
GO
CREATE TABLE Warehouse (
    Id     INT IDENTITY(1,1),
    Name   nvarchar (30) NOT NULL, 
	Country nvarchar(30) NOT NULL,
	City	nvarchar(30) NOT NULL,
    Address nvarchar(30) NOT NULL, 
	Phone nvarchar(12)    NOT NULL                  
)
GO

ALTER TABLE Warehouse ADD constraint Warehouse_PK PRIMARY KEY CLUSTERED (Id)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON ) 
GO
------------------------------------------------------- KONIEC TWORZENIE TABEL

------------------------------------------------------- KLUCZE OBCE
ALTER TABLE ActiveServices
    ADD CONSTRAINT ActiveServices_Clients_FK FOREIGN KEY ( ClientsLogin )
        REFERENCES clients ( Login )
	ON DELETE CASCADE
    ON UPDATE CASCADE 
GO

ALTER TABLE ActiveServices
    ADD CONSTRAINT ActiveServices_Services_FK FOREIGN KEY ( ServicesId )
        REFERENCES Services ( Id )
GO

ALTER TABLE BonusSalary
    ADD CONSTRAINT BonusSalary_Employees_FK FOREIGN KEY ( EmployeesId )
        REFERENCES Employees ( PeopleId )
GO

ALTER TABLE Clients
    ADD CONSTRAINT Clients_People_FK FOREIGN KEY ( PeopleId )
	REFERENCES People ( Id )
	ON DELETE CASCADE 
    ON UPDATE CASCADE 
GO

ALTER TABLE Comments
    ADD CONSTRAINT Comments_Clients_FK FOREIGN KEY ( ClientsLogin )
        REFERENCES Clients ( Login )
	ON DELETE CASCADE 
    ON UPDATE CASCADE 
GO

ALTER TABLE Comments
    ADD CONSTRAINT Comments_News_FK FOREIGN KEY ( NewsId )
        REFERENCES News ( Id )
	ON DELETE CASCADE 
    ON UPDATE CASCADE 
GO

ALTER TABLE Employees
    ADD CONSTRAINT Employees_People_FK FOREIGN KEY ( PeopleId )
        REFERENCES People ( Id )
    ON DELETE CASCADE 
    ON UPDATE CASCADE 
GO

ALTER TABLE Employees
    ADD CONSTRAINT Employees_Positions_FK FOREIGN KEY ( PositionsId )
        REFERENCES Positions ( Id )
GO

ALTER TABLE ExpiredServices
    ADD CONSTRAINT ExpiredServices_Clients_FK FOREIGN KEY ( ClientsLogin )
        REFERENCES Clients ( Login )
GO

ALTER TABLE ExpiredServices
    ADD CONSTRAINT ExpiredServices_Services_FK FOREIGN KEY ( ServicesId )
        REFERENCES Services ( Id )
GO

ALTER TABLE Items
    ADD CONSTRAINT Items_Categories_FK FOREIGN KEY ( CategoriesId )
        REFERENCES Categories ( Id )
GO

ALTER TABLE ItemsInWarehouse
    ADD CONSTRAINT ItemsInWarehouse_Items_FK FOREIGN KEY ( ItemsId )
        REFERENCES Items ( Id )
	ON DELETE CASCADE 
    ON UPDATE CASCADE 
GO

ALTER TABLE ItemsInWarehouse
    ADD CONSTRAINT ItemsInWarehouse_Warehouse_FK FOREIGN KEY ( WarehouseId )
        REFERENCES Warehouse ( Id )
	ON DELETE CASCADE 
    ON UPDATE CASCADE 
GO

ALTER TABLE Orders
    ADD CONSTRAINT Orders_Clients_FK FOREIGN KEY ( ClientsLogin )
        REFERENCES Clients ( Login )
GO

ALTER TABLE OrdersDetails
    ADD CONSTRAINT OrdersDetails_Orders_FK FOREIGN KEY ( OrdersId )
        REFERENCES Orders ( Id )
GO

ALTER TABLE OrdersDetails
    ADD CONSTRAINT OrdersDetails_Products_FK FOREIGN KEY ( ProductsId )
        REFERENCES Products ( Id )
GO

ALTER TABLE OrdersStatus
    ADD CONSTRAINT OrdersStatus_Orders_FK FOREIGN KEY ( OrdersId )
        REFERENCES Orders ( Id )
GO

ALTER TABLE Payments
    ADD CONSTRAINT Payments_Orders_FK FOREIGN KEY ( OrdersId )
        REFERENCES Orders ( Id )
GO

ALTER TABLE Payments
    ADD CONSTRAINT Payments_PaymentsTyps_FK FOREIGN KEY ( PaymentsTypsId )
        REFERENCES PaymentsTyps ( Id )
GO

ALTER TABLE ProductsPrices
    ADD CONSTRAINT ProductsPrices_Products_FK FOREIGN KEY ( ProductsId )
        REFERENCES Products ( Id )
GO

ALTER TABLE PromotionCodes
    ADD CONSTRAINT PromotionCodes_Clients_FK FOREIGN KEY ( ClientsLogin )
        REFERENCES Clients ( Login )
GO

ALTER TABLE PromotionCodes
    ADD CONSTRAINT PromotionCodes_Products_FK FOREIGN KEY ( ProductsId )
        REFERENCES Products ( Id )
GO

ALTER TABLE PromotionCodes
	ADD CONSTRAINT PromotionCodes_Orders_FK FOREIGN KEY (OrdersId)
		REFERENCES Orders ( Id )
GO

ALTER TABLE Ratings
    ADD CONSTRAINT Ratings_Clients_FK FOREIGN KEY ( ClientsLogin )
        REFERENCES Clients ( Login )
	ON DELETE CASCADE
    ON UPDATE CASCADE 
GO

ALTER TABLE Ratings
    ADD CONSTRAINT Ratings_Products_FK FOREIGN KEY ( ProductsId )
        REFERENCES Products ( Id )
	ON DELETE CASCADE 
    ON UPDATE CASCADE 
GO

ALTER TABLE Sales
    ADD CONSTRAINT Sales_Products_FK FOREIGN KEY ( ProductsId )
        REFERENCES Products ( Id )
	ON DELETE CASCADE 
    ON UPDATE CASCADE
GO

ALTER TABLE Services
    ADD CONSTRAINT Services_Categories_FK FOREIGN KEY ( CategoriesId )
        REFERENCES Categories ( Id )
GO

ALTER TABLE OrdersStatus
	ADD CONSTRAINT OrdersStatus_Status_FK FOREIGN KEY (StatusId)
		REFERENCES Status(Id)
GO

ALTER TABLE Employees 
	ADD CONSTRAINT Employees_Employees_FK FOREIGN KEY (BossId)
		REFERENCES Employees(PeopleId)
GO

------------------------------------------------------- KONIEC KLUCZY OBCYCH


------------------------------------------------------- DODATKOWE CONSTRAINY 
ALTER TABLE ItemsInWarehouse ADD CHECK (Quantity >= 0)  
ALTER TABLE ActiveServices ADD CHECK (StartDate <= EndDate)  
ALTER TABLE BonusSalary ADD CHECK (BonusSalary > 0)  
ALTER TABLE Comments ADD CHECK (DATALENGTH(CommentBody) > 0)
ALTER TABLE ExpiredServices ADD CHECK (StartDate <= EndDate)  
ALTER TABLE Logs ADD CHECK (DATALENGTH(Info) > 0)
ALTER TABLE News ADD CHECK (DATALENGTH(NewsBody) > 0)
ALTER TABLE OrdersDetails ADD CHECK (Discount >= 0 AND Discount <= 100)
ALTER TABLE Payments ADD CHECK (Payments > 0)
ALTER TABLE Positions ADD CHECK (Salary > 0)
ALTER TABLE ProductsPrices ADD CHECK (StartDate <= EndDate OR EndDate IS NULL)
ALTER TABLE PromotionCodes ADD CHECK (Discount > 0 AND Discount <= 100)
ALTER TABLE Ratings ADD CHECK (Rating >= 0 AND Discount <= 10)
ALTER TABLE Sales ADD CHECK (UnitPrice >= 0)
ALTER TABLE Services ADD CHECK (Time >= 0)
------------------------------------------------------- KONIEC DODATKOWYCH CONSTRAINÓW 

------------------------------------------------------- SEKWENCJE
CREATE SEQUENCE ProductsSequence 
    START WITH 1  
    INCREMENT BY 1
GO
------------------------------------------------------- KONIEC SEKWENCJI
------------------------------------------------------- INFORMACJE O B£ÊDACH
EXEC sp_addmessage 50001, 16,   
	N'This category does not exists';  
GO  

EXEC sp_addmessage 50002, 16,   
	N'This item is unavailable';  
GO  

IF OBJECT_ID ( 'dbo.uspDisplayErrors', 'P' ) IS NOT NULL   
    DROP PROCEDURE dbo.uspDisplayErrors;  
GO  
-- Procedura wywo³uj¹ca b³êd z poziomu bloku catch 
CREATE PROCEDURE uspDisplayErrors 
AS 
	DECLARE @ErrorMessage NVARCHAR(4000);  
    DECLARE @ErrorSeverity INT;  
    DECLARE @ErrorState INT;  
  
    SELECT   
        @ErrorMessage = ERROR_MESSAGE(),  
        @ErrorSeverity = ERROR_SEVERITY(),  
        @ErrorState = ERROR_STATE()

    RAISERROR (@ErrorMessage, -- Message text.  
               @ErrorSeverity, -- Severity.  
               @ErrorState -- State. 
				);  
GO

------------------------------------------------------- KONIEC INFORMACJI O B£ÊDACH

------------------------------------------------------- FUNKCJE
IF OBJECT_ID ( 'dbo.ufnTopSellers', 'F' ) IS NOT NULL   
    DROP FUNCTION dbo.ufnTopSellers;  
GO 
-- Najlepiej sprzedaj¹ce siê produkty w podanym przedziale
CREATE FUNCTION ufnTopSellers(@startDate DATETIME, @endDate DATETIME)
RETURNS @outputTable TABLE(ProductID INT, UnitsSold INT)
AS
BEGIN
	INSERT INTO @outputTable SELECT OD.ProductsId, SUM(OD.Quantity) AS UnitsSold 
	FROM Orders AS O JOIN OrdersDetails AS OD
	ON O.Id = OD.OrdersId WHERE O.PurchaseDate >= @startDate AND O.PurchaseDate <= @endDate
	GROUP BY OD.ProductsId
	ORDER BY UnitsSold DESC
	RETURN
END
GO

IF OBJECT_ID ( 'dbo.ufnFullMonthsSeparation', 'F' ) IS NOT NULL   
    DROP FUNCTION dbo.ufnFullMonthsSeparation;  
GO 
--Funkcja licz¹ca ile miesiecy minelo
CREATE FUNCTION ufnFullMonthsSeparation 
(
    @DateA DATETIME,
    @DateB DATETIME,
	@HireDate DATETIME
)
RETURNS INT
AS
BEGIN
    DECLARE @Result INT

    DECLARE @DateX DATETIME
    DECLARE @DateY DATETIME

	IF (@HireDate >= @DateB)
		RETURN 0

	if (@HireDate > @DateA)
		SET @DateA = @HireDate

    IF(@DateA < @DateB)
    BEGIN
        SET @DateX = @DateA
        SET @DateY = @DateB
    END
    ELSE
    BEGIN
        SET @DateX = @DateB
        SET @DateY = @DateA
    END

    SET @Result = (
                    SELECT 
                    CASE 
                        WHEN DATEPART(DAY, @DateX) > DATEPART(DAY, @DateY)
                        THEN DATEDIFF(MONTH, @DateX, @DateY) - 1
                        ELSE DATEDIFF(MONTH, @DateX, @DateY)
                    END
                    )

    RETURN @Result
END
GO

IF OBJECT_ID ( 'dbo.ufnSalaries', 'F' ) IS NOT NULL   
    DROP FUNCTION dbo.ufnSalaries;  
GO 
--Funkcja zwracaj¹ca ile zarobili procownicy w danym okresie czasu
CREATE FUNCTION ufnSalaries(@startDate DATETIME, @endDate DATETIME)
RETURNS @outputTable TABLE(Name NVARCHAR(30), Surname NVARCHAR(30), Earnings INT)
AS
BEGIN
	INSERT INTO @outputTable 
	SELECT P.Name, P.Surname, 
	dbo.ufnFullMonthsSeparation(@startDate, @endDate, E.HireDate) * PO.salary + ISNULL(
		(SELECT SUM(BB.BonusSalary) FROM BonusSalary AS BB 
		WHERE BB.EmployeesId = E.PeopleId AND BB.ReceivedDate >= @startDate AND BB.ReceivedDate <= @endDate
		GROUP BY BB.EmployeesId
		),0)
	FROM People AS P JOIN Employees AS E 
	ON P.Id = E.PeopleId JOIN Positions AS PO
	ON E.PositionsId = PO.Id
	RETURN
END
GO

IF OBJECT_ID ( 'dbo.ufnGetProductName', 'F' ) IS NOT NULL   
    DROP FUNCTION dbo.ufnGetProductName;  
GO 
--Zwraca nazwê produktu po zadanym id
CREATE FUNCTION ufnGetProductName(@id INT)
RETURNS NVARCHAR(100)
AS
BEGIN
	DECLARE @output NVARCHAR(100)
	SET @output = (SELECT I.Name FROM Items AS I WHERE I.id = @id)
	IF (@output IS NULL)
	BEGIN
		SET @output = (SELECT S.Name FROM Services AS S WHERE S.id = @id)
	END
	RETURN @output
END
GO

IF OBJECT_ID ( 'dbo.ufnCheckStatus', 'F' ) IS NOT NULL   
    DROP FUNCTION dbo.ufnCheckStatus;  
GO 
--Zwraca statusy zamówieñ wraz z jego datami p³atnoœci
CREATE FUNCTION ufnCheckStatus(@id INT)
RETURNS @output TABLE(OrderID INT, Status TEXT, Name TEXT, PaymentDate DATETIME) 
AS
BEGIN
	INSERT INTO @output SELECT @id, (SELECT S.StatusInfo FROM STATUS AS S WHERE S.Id = OS.StatusID),
		dbo.ufnGetProductName(@id), (SELECT P.PaymentDate FROM Payments AS P WHERE P.Id = OS.OrdersId)  
	FROM OrdersStatus AS OS
	RETURN
END
GO

IF OBJECT_ID ( 'dbo.ufnIsCodeActive', 'F' ) IS NOT NULL   
    DROP FUNCTION dbo.ufnIsCodeActive;  
GO 
--Sprawdza czy dany kod zosta³ ju¿ u¿yty, czy nie
CREATE FUNCTION ufnIsCodeActive(@id INT) RETURNS BIT
AS
BEGIN
	IF (EXISTS (SELECT 1 FROM PromotionCodes AS PC WHERE PC.Id = @id AND PC.ExpirDate > GETDATE() AND PC.ClientsLogin IS NULL))
		RETURN 1
	RETURN 0
END
GO

IF OBJECT_ID ( 'dbo.ufnGetEmployees', 'F' ) IS NOT NULL   
    DROP FUNCTION dbo.ufnGetEmployees;  
GO 
--Zwraca wszystkich pracowników na danej pozycji
CREATE FUNCTION ufnGetEmployees(@positionID INT)
RETURNS @output TABLE(PositionID INT, 
						PositionName NVARCHAR(30), 
						EmployeeID INT, 
						Name NVARCHAR(30), 
						Surname NVARCHAR(30))
AS
BEGIN
	INSERT INTO @output SELECT 
		@positionID AS [PositionID], (SELECT P.Position FROM POSITIONS AS P WHERE P.Id = @positionID), P.Id AS [EmployeeID], P.Name, P.Surname
		FROM Employees AS E JOIN People AS P ON E.PeopleId = P.Id
		WHERE E.PositionsId = @positionID
	RETURN
END
GO

IF OBJECT_ID('dbo.ufnGetActiveClients', 'FN') IS NOT NULL
    DROP FUNCTION dbo.ufnGetActiveClients
GO
-- Zwraca klientów, którzy dokonali zakupów w danym przedziale czasowym
CREATE FUNCTION ufnGetActiveClients(@start DATETIME, @end DATETIME)
RETURNS @output TABLE(ClientID INT,
						ClientName NVARCHAR(30),
						ClientSurname NVARCHAR(30),
						NumberOfOrders INT)
AS
BEGIN
	INSERT INTO @output SELECT DISTINCT C.PeopleId, P.Name, P.Surname, 
	(SELECT COUNT(O.Id) FROM Orders AS O WHERE C.Login = O.ClientsLogin AND O.PurchaseDate >= @start AND O.PurchaseDate <= @end GROUP BY O.ClientsLogin) AS [NumberOfOrders]
	FROM Clients AS C JOIN People AS P ON C.PeopleId = P.Id
	WHERE ((SELECT COUNT(O.Id) FROM Orders AS O WHERE C.Login = O.ClientsLogin AND O.PurchaseDate >= @start AND O.PurchaseDate <= @end GROUP BY O.ClientsLogin) > 0)
	RETURN
END
GO

IF OBJECT_ID('dbo.ufnCountItemsInWarehouse', 'FN') IS NOT NULL
    DROP FUNCTION dbo.ufnCountItemsInWarehouse
GO
-- Zwaraca iloœæ danego przedmiotu w magazynach (z danego kraju)
CREATE FUNCTION dbo.ufnCountItemsInWarehouse (@id INT, @country	NVARCHAR(30) = NULL)
RETURNS INT
AS
BEGIN
	IF @country IS NULL 
		RETURN (SELECT SUM(Quantity) AS ItemCount FROM dbo.ItemsInWarehouse WHERE ItemsId = @id)
	RETURN (SELECT SUM(IW.Quantity) AS ItemCount FROM dbo.ItemsInWarehouse AS IW 
			JOIN Warehouse AS W ON W.Id =  IW.WarehouseId
			WHERE IW.ItemsId = @id AND w.Country LIKE @country)
END
GO

IF OBJECT_ID('dbo.ufnGetLogs', 'FN') IS NOT NULL
    DROP FUNCTION dbo.ufnGetLogs
GO
-- Fukncja zwracaj¹ca logi z danego dnia
CREATE FUNCTION ufnGetLogs(@date DATETIME)
RETURNS @outputTable TABLE (Info TEXT, Level CHAR(1))
AS
BEGIN
	INSERT INTO @outputTable SELECT L.Info, L.Level FROM Logs AS L WHERE CAST(L.Date AS DATE) = CAST(@date AS DATE)
	RETURN
END 
GO

IF OBJECT_ID('dbo.ufnUsedPromotionCodes', 'FN') IS NOT NULL
    DROP FUNCTION dbo.ufnUsedPromotionCodes
GO
-- Zwraca kody u¿yte przez u¿ytkowinika z danym loginem
CREATE FUNCTION ufnUsedPromotionCodes(@Login NVARCHAR(30))
RETURNS @outputTable TABLE (CodeID INT, Code NVARCHAR(10), ProductID INT, Discount INT, OrderID INT)
AS
BEGIN
	INSERT INTO @outputTable SELECT PC.Id, PC.Code, PC.ProductsId, PC.Discount, PC.OrdersID FROM PromotionCodes AS PC 
	WHERE PC.ClientsLogin IS NOT NULL AND PC.ClientsLogin = @Login
	RETURN
END
GO
------------------------------------------------------- KONIEC FUNKCJI

------------------------------------------------------- WIDOKI 

IF OBJECT_ID ( 'Top5Commentators', 'v' ) IS NOT NULL   
    DROP VIEW Top5Commentators;  
GO
-- Najlepsi komentuj¹ce
CREATE VIEW Top5Commentators
AS
	SELECT TOP 5 ClientsLogin, COUNT(ClientsLogin) "Count" FROM dbo.Comments
	GROUP BY ClientsLogin
	ORDER BY COUNT(ClientsLogin) DESC
GO

IF OBJECT_ID ( 'Top5LastComments', 'v' ) IS NOT NULL   
    DROP VIEW Top5LastComments;  
GO
-- Ostatnie kometarze
CREATE VIEW Top5LastComments
AS
	SELECT TOP 5 CommentBody FROM dbo.Comments
	ORDER BY AddDate DESC
GO

IF OBJECT_ID ( 'ItemsToSend', 'v' ) IS NOT NULL   
    DROP VIEW ItemsToSend;  
GO
-- Przedmioty, które nale¿y wys³aæ
CREATE VIEW ItemsToSend
AS
	SELECT O.Id, O.Country, O.City, O.Address, OD.ProductsId, OD.Quantity FROM Status AS S JOIN OrdersStatus AS OS
	ON S.Id = OS.StatusId  JOIN Orders AS O
	ON OS.OrdersId = O.Id JOIN OrdersDetails AS OD
	ON O.Id = OD.OrdersId
	WHERE S.StatusInfo LIKE N'TO SEND' 
GO

IF OBJECT_ID ( 'TopBuyers', 'v' ) IS NOT NULL   
    DROP VIEW TopBuyers;  
GO
-- Najlepsi kupuj¹cy
CREATE VIEW TopBuyers
AS
	SELECT TOP 5 O.ClientsLogin, SUM(ROUND(OD.UnitPrice * OD.Quantity * CAST((1 - OD.Discount) AS MONEY), 2)) AS TotalSpend
	FROM Orders AS O JOIN OrdersDetails AS OD
	ON O.Id = OD.OrdersId 
	GROUP BY O.ClientsLogin
	ORDER BY TotalSpend DESC 
GO

IF OBJECT_ID ( 'SortByRating', 'v' ) IS NOT NULL   
    DROP VIEW SortByRating;  
GO
-- Produkty posortowane po ocenach
CREATE VIEW SortByRating
AS
	SELECT TOP 100 PERCENT R.ProductsId, AVG(R.Rating) AS [AverageRating] FROM Ratings AS R
	GROUP BY R.ProductsId
	ORDER BY [AverageRating]
GO


IF OBJECT_ID ( 'ActiveClients', 'v' ) IS NOT NULL   
    DROP VIEW ActiveClients;  
GO
-- Klienci z aktywnymi us³ugami 
CREATE VIEW ActiveClients
AS
	SELECT P.Id AS [ClientId], A.ServicesId AS [ServiceID], P.Name, P.Surname, A.StartDate, A.EndDate 
	FROM ActiveServices AS A 
	JOIN Clients AS C ON A.ClientsLogin = C.Login
	JOIN People AS P ON P.Id = C.PeopleId
GO


IF OBJECT_ID ( 'SumItems', 'v' ) IS NOT NULL   
    DROP VIEW SumItems;  
GO
--Sumy wszystkich przedmiotów w magazynach
CREATE VIEW SumItems
AS
	SELECT IW.ItemsId AS [Id], (SELECT DISTINCT I.Name FROM Items AS I WHERE I.Id = IW.ItemsId) AS [Name], SUM(IW.Quantity) AS [Sum] 
	FROM ItemsInWarehouse AS IW JOIN Warehouse AS W ON IW.WarehouseId = W.Id
	GROUP BY IW.ItemsId
GO
------------------------------------------------------- KONIEC WIDOKÓW


------------------------------------------------------- PROCEDURY

IF OBJECT_ID('dbo.uspAddItem', 'P') IS NOT NULL
    DROP PROCEDURE dbo.uspAddItem
GO
--Dodawanie przedmiotów do bazy. Nale¿y tego u¿ywaæ zamiast zwyk³ych insertów
CREATE PROCEDURE dbo.uspAddItem (@name NVARCHAR(30), @description TEXT, @category NVARCHAR(30))
AS 
	BEGIN TRY 
		DECLARE @tranCount INT = @@TRANCOUNT
			
		IF @tranCount = 0
			BEGIN TRAN uspAddItem
		ELSE
			SAVE TRAN uspAddItem

			IF NOT EXISTS (SELECT Id FROM dbo.Categories WHERE Category LIKE @category)
				RAISERROR(50001,-1,-1)

			DECLARE @catId INT
			DECLARE @id INT
			SET @id = NEXT VALUE FOR ProductsSequence
			SET @catId = (SELECT TOP 1 Id FROM dbo.Categories WHERE Category LIKE @category)
	
			INSERT INTO dbo.Items VALUES (@id, @name, @catId)
			INSERT INTO dbo.Products VALUES (@id, @description)

			COMMIT TRAN uspAddItem
	END TRY
	BEGIN CATCH 
		ROLLBACK TRAN uspAddItem
		EXEC dbo.uspDisplayErrors
	END CATCH
GO


IF OBJECT_ID('dbo.uspAddService', 'P') IS NOT NULL
    DROP PROCEDURE dbo.uspAddService
GO
--Dodawanie us³ug do bazy. Nale¿y tego u¿ywaæ zamiast zwyk³ych insertów
CREATE PROCEDURE dbo.uspAddService (@name NVARCHAR(30), @time INT, @description TEXT, @category NVARCHAR(30))
AS 
	BEGIN TRY 
			DECLARE @tranCount INT = @@TRANCOUNT
			
			IF @tranCount = 0
				BEGIN TRAN uspAddServicesTran
			ELSE
				SAVE TRAN uspAddServicesTran

				IF NOT EXISTS (SELECT Id FROM dbo.Categories WHERE Category LIKE @category)
				BEGIN 
					RAISERROR(50001,-1,-1)
				END

				DECLARE @catId INT
				DECLARE @id INT
				SET @id = NEXT VALUE FOR dbo.ProductsSequence
				SET @catId = (SELECT TOP 1 Id FROM dbo.Categories WHERE Category LIKE @category)
	
				INSERT INTO dbo.Services(Id, Name, Time, CategoriesID) VALUES (@id, @name, @time, @catId)
				INSERT INTO dbo.Products VALUES (@id, @description)

			COMMIT TRAN uspAddServicesTran
	END TRY
	BEGIN CATCH 
		ROLLBACK TRAN uspAddServicesTran
		EXEC dbo.uspDisplayErrors
	END CATCH
GO

IF OBJECT_ID('dbo.uspSellItem', 'P') IS NOT NULL
    DROP PROCEDURE dbo.uspSellItem
GO
--Sprzedwanie przedmiotu
CREATE PROCEDURE dbo.uspSellItem (@id INT, @warehouse INT = NULL, @quantity INT = 1)
AS
	BEGIN TRY	
		IF @warehouse IS NULL
		BEGIN
			
			DECLARE @SumQuantity INT = dbo.ufnCountItemsInWarehouse(@id,NULL);

			IF @SumQuantity < @quantity 
				RAISERROR(50002,-1,-1)

			DECLARE @IdWar INT
			DECLARE K_WareHouse CURSOR 
			FOR SELECT Id FROM Warehouse FOR READ ONLY
			Open K_WareHouse 
			FETCH K_WareHouse INTO @IdWar 
			
			DECLARE @tempQuant INT = @quantity;
			WHILE (@@FETCH_STATUS<>-1) AND (@tempQuant >= 0)
			BEGIN
				SET @SumQuantity = (SELECT SUM(Quantity) FROM ItemsInWarehouse WHERE ItemsId = @id AND WarehouseId = @IdWar)
				IF (@tempQuant >= @SumQuantity )
				BEGIN
					SET @tempQuant -= @SumQuantity;
					UPDATE ItemsInWarehouse SET quantity = 0 WHERE ItemsId = @id AND WarehouseId = @IdWar
				END
				ELSE
				BEGIN 
					UPDATE ItemsInWarehouse SET quantity -= @tempQuant WHERE ItemsId = @id AND WarehouseId = @IdWar
					SET @tempQuant = 0;	
				END
					FETCH K_WareHouse INTO @IdWar 
			END

			CLOSE K_WareHouse 
			DEALLOCATE K_WareHouse 

		END
		ELSE 
		BEGIN 
				IF NOT EXISTS (SELECT Quantity FROM dbo.ItemsInWarehouse 
								WHERE ItemsId = @id AND WarehouseId = @warehouse AND Quantity >= @quantity)
					RAISERROR(50002,-1,-1)
			

				UPDATE ItemsInWarehouse SET Quantity -= @quantity
				WHERE ItemsId = @id AND WarehouseId = @warehouse

		END
	
		
	END TRY
	BEGIN CATCH
		EXEC dbo.uspDisplayErrors
	END CATCH
GO
------------------------------------------------------- KONIEC PROCEDUR
------------------------------------------------------- TRIGGERY
IF OBJECT_ID ('LogPayments', 'TR') IS NOT NULL
   DROP TRIGGER LogPayments;
GO
-- Dodawanie logów przy p³atnoœci
CREATE TRIGGER LogPayments ON dbo.Payments
AFTER INSERT 
AS 
	INSERT INTO dbo.Logs(Info, Level)
	SELECT N'Zamówienie nr ' +  CONVERT(VARCHAR(20),OrdersId) + N' zosta³o p³acone', 'I' FROM inserted
GO
------------------------------------------------------- KONIEC TRIGGERÓW