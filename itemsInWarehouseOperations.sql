IF OBJECT_ID('dbo.ufnCountItemsInWarehouse', 'FN') IS NOT NULL
    DROP FUNCTION dbo.ufnCountItemsInWarehouse
GO
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

/* TEGO NIE MA BO DANIEL ZROBIL LEPSZE
IF OBJECT_ID('dbo.uspSellItem', 'P') IS NOT NULL
    DROP PROCEDURE dbo.uspSellItem
GO
CREATE PROCEDURE dbo.uspSellItem (@id INT, @warehouse INT = NULL, @quantity INT = 1)
AS
	BEGIN TRY
		IF @warehouse IS NULL
		BEGIN
			SET @warehouse = (SELECT TOP 1 WarehouseId FROM dbo.ItemsInWarehouse
							  WHERE ItemsId = @id ORDER BY Quantity DESC)
			IF @warehouse IS NULL
				RAISERROR(50002,-1,-1)
		END
		ELSE 
		BEGIN 
			IF NOT EXISTS (SELECT Quantity FROM dbo.ItemsInWarehouse 
							WHERE ItemsId = @id AND WarehouseId = @warehouse)
				RAISERROR(50002,-1,-1)
		END
	
		UPDATE ItemsInWarehouse SET Quantity -= @quantity
		WHERE ItemsId = @id AND WarehouseId = @warehouse
	END TRY
	BEGIN CATCH
		EXEC dbo.uspDisplayErrors
	END CATCH

EXEC dbo.uspSellItem 11, 2, 100
SELECT * FROM ItemsInWarehouse
*/