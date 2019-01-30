IF OBJECT_ID ('LogPayments', 'TR') IS NOT NULL
   DROP TRIGGER LogPayments;
GO
CREATE TRIGGER LogPayments ON dbo.Payments
AFTER INSERT 
AS 
	INSERT INTO Logs(Info, Level)
	SELECT N'Zam�wienie nr ' +  CONVERT(VARCHAR(20),OrdersId) + N' zosta�o p�acone', 'I' FROM inserted
GO