EXEC sp_addmessage 50001, 16,   
	N'This category does not exists';  
GO  

EXEC sp_addmessage 50002, 16,   
	N'This item is unavailable';  
GO  

IF OBJECT_ID ( 'uspDisplayErrors', 'P' ) IS NOT NULL   
    DROP PROCEDURE uspDisplayErrors;  
GO  

CREATE PROCEDURE uspDisplayErrors 
AS 
	DECLARE @ErrorMessage NVARCHAR(4000);  
    DECLARE @ErrorSeverity INT;  
    DECLARE @ErrorState INT;  
  
    SELECT   
        @ErrorMessage = ERROR_MESSAGE(),  
        @ErrorSeverity = ERROR_SEVERITY(),  
        @ErrorState = ERROR_STATE()

    RAISERROR (@ErrorMessage, -- Message text.  
               @ErrorSeverity, -- Severity.  
               @ErrorState -- State. 
				);  
GO