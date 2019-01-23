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
