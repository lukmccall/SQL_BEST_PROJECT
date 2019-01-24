CREATE VIEW Top5Commentators
AS
	SELECT TOP 5 ClientsLogin, COUNT(ClientsLogin) "Count" FROM dbo.Comments
	GROUP BY ClientsLogin
	ORDER BY COUNT(ClientsLogin) DESC
GO

CREATE VIEW Top5LastComments
AS
	SELECT TOP 5 CommentBody FROM dbo.Comments
	ORDER BY AddDate DESC
GO

--bardzo ładny tutaj view jak mnie uczyli na zajeciach mi sie podoba nie zadna funkcja
CREATE VIEW ItemsToSend
AS
	SELECT O.Id, O.Country, O.City, O.Address, OD.ProductsId, OD.Quantity FROM Status AS S JOIN OrdersStatus AS OS
	ON S.Id = OS.StatusId  JOIN Orders AS O
	ON OS.OrdersId = O.Id JOIN OrdersDetails AS OD
	ON O.Id = OD.OrdersId
	WHERE S.StatusInfo LIKE N'TO SEND' 
GO

--zajebisty widoczek tylko mozna z niego zrobic funkcje ale nie wiem w sumie czy telega woli widoki czy funkcje
CREATE VIEW TopBuyers
AS
	SELECT TOP 5 O.ClientsLogin, SUM(ROUND(OD.UnitPrice * OD.Quantity * CAST((1 - OD.Discount) AS MONEY), 2)) AS TotalSpend
	FROM Orders AS O JOIN OrdersDetails AS OD
	ON O.Id = OD.OrdersId 
	GROUP BY O.ClientsLogin
	ORDER BY TotalSpend DESC 
GO

--superancko
--Returns top selling items at a given time
CREATE FUNCTION TopSellers(@startDate DATETIME, @endDate DATETIME, @number INT = 5)
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

--funkcyja liczy ile miesiecy minelo bo potrzebuje do nastepnej funkcji (super zastosowanie tomek polecam)
--Return how many full months there are between two dates
CREATE FUNCTION FullMonthsSeparation 
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

--Boze jaka super funkcja jakbym mial kiedys baze danych chcialbym zeby taka w niej byla
--Returns how much each employee has earned in a given time 
--	(we assume that the salary was paid to employee after 1 month of work and not on like 10th of each month)
CREATE FUNCTION Salaries(@startDate DATETIME, @endDate DATETIME)
RETURNS @outputTable TABLE(Name NVARCHAR(30), Surname NVARCHAR(30), Earnings INT)
AS
BEGIN
	INSERT INTO @outputTable 
	SELECT P.Name, P.Surname, 
	dbo.FullMonthsSeparation(@startDate, @endDate, E.HireDate) * PO.salary + ISNULL(
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

--Returns name from given ID
CREATE FUNCTION GetName(@id INT)
RETURNS VARCHAR(100)
AS
BEGIN
	DECLARE @output VARCHAR(100)
	SET @output = (SELECT I.Name FROM Items AS I WHERE I.id = @id)
	IF (@output IS NULL)
	BEGIN
		SET @output = (SELECT S.Name FROM Services AS S WHERE S.id = @id)
	END
	RETURN @output
END
GO

--Sel-explanatory returns best rated products
CREATE VIEW SortByRating
AS
	SELECT TOP 100 PERCENT R.ProductsId, AVG(R.Rating) AS [Average Rating] FROM Ratings AS R 
	GROUP BY R.ProductsId
	ORDER BY [Average Rating]
GO

--Returns status of an order with name of ordered product and payment date to verify that the order has been paid for
CREATE FUNCTION CheckStatus(@id INT)
RETURNS @output TABLE(OrderID INT, Status TEXT, Name TEXT, PaymentDate DATETIME) 
AS
BEGIN
	INSERT INTO @output SELECT @id, (SELECT S.StatusInfo FROM STATUS AS S WHERE S.Id = OS.StatusID),
		dbo.GetName(@id), (SELECT P.PaymentDate FROM Payments AS P WHERE P.Id = OS.OrdersId)  
	FROM OrdersStatus AS OS
	RETURN
END
GO

--Returns active services combined with client informations
CREATE VIEW ActiveClients
AS
	SELECT P.Id AS [ClientID], A.ServicesId AS [ServiceID], P.Name, P.Surname, A.StartDate, A.EndDate 
	FROM ActiveServices AS A 
	JOIN Clients AS C ON A.ClientsLogin = C.Login
	JOIN People AS P ON P.Id = C.PeopleId
GO

--Returns wheter code is still active right now
CREATE FUNCTION IsCodeActive(@id INT) RETURNS BIT
AS
BEGIN
	IF (EXISTS (SELECT 1 FROM PromotionCodes AS PC WHERE PC.Id = @id AND PC.ExpirDate > GETDATE()))
		RETURN 1
	RETURN 0
END
GO

--Returns sum of all items in all warehouses
CREATE VIEW SumItems
AS
	SELECT IW.ItemsId AS [ID], (SELECT DISTINCT I.Name FROM Items AS I WHERE I.Id = IW.ItemsId) AS [Name], SUM(IW.Quantity) AS [Sum] 
	FROM ItemsInWarehouse AS IW JOIN Warehouse AS W ON IW.WarehouseId = W.Id
	GROUP BY IW.ItemsId
GO

--Returns all employees that work at given position
CREATE FUNCTION GetEmployees(@positionID INT)
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
		    
