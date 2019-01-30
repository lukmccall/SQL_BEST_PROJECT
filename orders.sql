
CREATE PROCEDURE InitOrder(@person INT, @Cauntry NVarchar(30), @Address NVarchar(30),@City NVarchar(30))
AS
	INSERT INTO Orders VALUES(GETDATE(),@City,@Cauntry,@Address,(SELECT Login FROM Clients WHERE @person = PeopleId));
GO

								     
								     
CREATE TRIGGER OrderDetailsGetPrice ON OrdersDetails
INSTEAD OF INSERT
AS

BEGIN TRY
	DECLARE @ProductId INT
	DECLARE @OrderId INT
	DECLARE @Discount INT
	DECLARE @Quantity INT

	DECLARE K_NextInser CURSOR 
	FOR SELECT OrdersId, ProductsId, Discount, Quantity FROM inserted 
	FOR READ ONLY
		
	Open K_NextInser 
	FETCH K_NextInser INTO @OrderId, @ProductId, @Discount, @Quantity
			
	WHILE (@@FETCH_STATUS<>-1)
	BEGIN
		DECLARE @Login nVARCHAR(30) = (SELECT ClientsLogin FROM Orders WHERE Id = @OrderId)

		DECLARE @result int;  
		EXECUTE @result = dbo.uspSellItem @ProductId, NULL, @Quantity;  


		IF (@result = 1 AND @result IS NOT NULL)
		BEGIN 
		
			--EXEC dbo.uspActiveCode @CodeId, @Login, @Discount OUT

			DECLARE @UnitPrice MONEY = dbo.GetPrice(@ProductId,GETDATE())
			INSERT INTO OrdersDetails VALUES(@OrderId,@ProductId,@UnitPrice, @Quantity,@Discount)
			
		END
		ELSE
		BEGIN
			RAISERROR(50002,-1,-1) 
		END	

 		
		FETCH K_NextInser INTO @OrderId, @ProductId, @Discount, @Quantity
	END
	CLOSE K_NextInser 
	DEALLOCATE K_NextInser 

END TRY
BEGIN CATCH
	EXEC dbo.uspDisplayErrors
END CATCH
GO

								
CREATE TRIGGER NewPrice ON ProductsPrices
INSTEAD OF INSERT 
AS 
	DECLARE @Time DATETIME = GETDATE()
	UPDATE ProductsPrices SET EndDate=@Time
	FROM inserted I JOIN ProductsPrices PP ON I.ProductsId=PP.ProductsId
 	WHERE PP.EndDate = NULL

	INSERT INTO ProductsPrices SELECT I.ProductsId, @Time, NULL, I.UnitPrice 
	FROM inserted I 

GO					
