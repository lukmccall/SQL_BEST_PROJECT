CREATE SEQUENCE ProductsSequence 
    START WITH 1  
    INCREMENT BY 1
GO

IF OBJECT_ID('dbo.uspAddItem', 'P') IS NOT NULL
    DROP PROCEDURE dbo.uspAddItem
GO
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
		EXEC uspDisplayErrors
	END CATCH
GO


IF OBJECT_ID('dbo.uspAddService', 'P') IS NOT NULL
    DROP PROCEDURE dbo.uspAddService
GO
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
		EXEC uspDisplayErrors
	END CATCH
GO
	
IF OBJECT_ID('dbo.uspSellItem', 'P') IS NOT NULL
    DROP PROCEDURE dbo.uspSellItem
GO
--Sprzedwanie przedmiotu
CREATE PROCEDURE dbo.uspSellItem (@id INT, @warehouse INT = NULL, @quantity INT = 1)
AS
	BEGIN TRY	
		PRINT @warehouse
	
		IF @warehouse IS NULL
		BEGIN
			
			DECLARE @SumQuantity INT = dbo.ufnCountItemsInWarehouse(@id,NULL);
		
			IF @SumQuantity < @quantity OR @SumQuantity IS NULL
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
		RETURN 1
	END TRY
	BEGIN CATCH
		EXEC dbo.uspDisplayErrors
		RETURN -1
	END CATCH
GO
												 
