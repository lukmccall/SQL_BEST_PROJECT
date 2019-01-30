IF OBJECT_ID ('LogPayments', 'TR') IS NOT NULL
   DROP TRIGGER LogPayments;
GO
CREATE TRIGGER LogPayments ON dbo.Payments
AFTER INSERT 
AS 
	INSERT INTO Logs(Info, Level)
	SELECT N'Zamówienie nr ' +  CONVERT(VARCHAR(20),OrdersId) + N' zosta³o p³acone', 'I' FROM inserted
GO