IF OBJECT_ID('dbo.uspAddPeople', 'P') IS NOT NULL
    DROP PROCEDURE dbo.uspAddPeople
GO
--Tworzenie ludzi, procedura pomocnicza
CREATE PROCEDURE dbo.uspAddPeople (@id INT OUTPUT, @name NVARCHAR(30), @surname NVARCHAR(30), @email NVARCHAR(30),
								   @phone NVARCHAR(12), @country NVARCHAR(30), @city NVARCHAR(30), @adress NVARCHAR(30))
AS 
	BEGIN TRY 
		DECLARE @tranCount INT = @@TRANCOUNT			
		IF @tranCount = 0
			BEGIN TRAN uspAddPeople
		ELSE
			SAVE TRAN uspAddPeople

			INSERT INTO People(Name,Surname,Email,Phone,Country,City,Adress)
			VALUES (@name,@surname,@email,@phone,@country,@city,@adress)
			SET @id = SCOPE_IDENTITY()

			IF @tranCount = 0 
				COMMIT TRAN uspAddPeople
	END TRY
	BEGIN CATCH 
		ROLLBACK TRAN uspAddPeople
		RAISERROR(50003,-1,-1)
	END CATCH
GO

IF OBJECT_ID('dbo.uspAddClients', 'P') IS NOT NULL
    DROP PROCEDURE dbo.uspAddClients
GO
--Rejestracja nowych u¿ytkowników
CREATE PROCEDURE dbo.uspAddClients (@login NVARCHAR(30), @password NVARCHAR(30) ,@name NVARCHAR(30), @surname NVARCHAR(30), @email NVARCHAR(30),
								   @phone NVARCHAR(12) = NULL, @country NVARCHAR(30) = NULL, @city NVARCHAR(30) = NULL, @adress NVARCHAR(30) = NULL)
AS 
	BEGIN TRY 
		DECLARE @tranCount INT = @@TRANCOUNT
		DECLARE @id INT
			
		IF @tranCount = 0
			BEGIN TRAN uspAddClients
		ELSE
			SAVE TRAN uspAddClients

			EXEC dbo.uspAddPeople @id OUTPUT, @name, @surname, @email, @phone, @country, @city, @adress
			INSERT INTO Clients(Login, PeopleId, Password) VALUES(@login, @id, @password)

			IF @tranCount = 0 
				COMMIT TRAN uspAddClients
	END TRY
	BEGIN CATCH
		RAISERROR(50004,-1,-1)
		ROLLBACK
	END CATCH
GO

IF OBJECT_ID('dbo.uspAddEmployees', 'P') IS NOT NULL
    DROP PROCEDURE dbo.uspAddEmployees
GO
--Zatrudnianie nowego pracownika
CREATE PROCEDURE dbo.uspAddEmployees (@name NVARCHAR(30), @surname NVARCHAR(30), @email NVARCHAR(30),  @position NVARCHAR(30),
								   @phone NVARCHAR(12) = NULL, @country NVARCHAR(30) = NULL, @city NVARCHAR(30) = NULL, @adress NVARCHAR(30) = NULL,
								   @hireDate DATE = NULL, @BossId INT = NULL)
AS 
	BEGIN TRY 
		DECLARE @tranCount INT = @@TRANCOUNT
		DECLARE @id INT
		DECLARE @positionId INT

		IF @tranCount = 0
			BEGIN TRAN uspAddEmployees
		ELSE
			SAVE TRAN uspAddEmployees

			IF NOT EXISTS (SELECT Id FROM Positions WHERE Position LIKE @position)
				RAISERROR(50006,-1,-1)
			IF @hireDate IS NULL 
				SET @hireDate = GETDATE()

			SET @positionId = (SELECT TOP 1 Id FROM Positions WHERE Position LIKE @position)
			EXEC dbo.uspAddPeople @id OUTPUT, @name, @surname, @email, @phone, @country, @city, @adress
			INSERT INTO Employees(PeopleId, HireDate, PositionsId, BossId) 
			VALUES(@id,@hireDate, @positionId, @BossId)

			IF @tranCount = 0 
				COMMIT TRAN uspAddEmployees
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN uspAddEmployees
		IF ERROR_NUMBER () = 50006
			RAISERROR(50006,-1,-1)
		ELSE
			RAISERROR(50005,-1,-1)
	END CATCH
GO