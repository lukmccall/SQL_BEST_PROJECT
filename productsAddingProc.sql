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
