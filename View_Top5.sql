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
