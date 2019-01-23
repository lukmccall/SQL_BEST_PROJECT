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

!--bardzo ładny tutaj view jak mnie uczyli na zajeciach mi sie podoba nie zadna funkcja
CREATE VIEW itemsToSend
AS
	SELECT O.Id, O.Country, O.City, O.Address, OD.ProductsId, OD.Quantity FROM Status AS S JOIN OrdersStatus AS OS
	ON S.Id = OS.StatusId  JOIN Orders AS O
	ON OS.OrdersId = O.Id JOIN OrdersDetails AS OD
	ON O.Id = OD.OrdersId
	WHERE S.StatusInfo LIKE N'TO SEND' 
GO

!--zajebisty widoczek tylko mozna z niego zrobic funkcje ale nie wiem w sumie czy telega woli widoki czy funkcje
DROP VIEW topBuyers
CREATE VIEW topBuyers
AS
	SELECT TOP 5 O.ClientsLogin, SUM(ROUND(OD.UnitPrice * OD.Quantity * CAST((1 - OD.Discount) AS MONEY), 2)) AS TotalSpend
	FROM Orders AS O JOIN OrdersDetails AS OD
	ON O.Id = OD.OrdersId 
	GROUP BY O.ClientsLogin
	ORDER BY TotalSpend DESC 
GO

!--superancko
CREATE FUNCTION topSellers(@startDate DATETIME, @endDate DATETIME, @number INT = 5)
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

!--funkcyja liczy ile miesiecy minelo bo potrzebuje do nastepnej funkcji (super zastosowanie tomek polecam)
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

!--Boze jaka super funkcja jakbym mial kiedys baze danych chcialbym zeby taka w niej byla
CREATE FUNCTION salaries(@startDate DATETIME, @endDate DATETIME)
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
