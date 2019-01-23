
CREATE PROCEDURE InitOrder(@person INT, @Cauntry NVarchar(30), @Address NVarchar(30),@City NVarchar(30))
AS
	INSERT INTO Orders VALUES(GETDATE(),@City,@Cauntry,@Address,(SELECT Login FROM Clients WHERE @person = PeopleId));
GO
