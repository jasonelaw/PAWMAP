CREATE PROCEDURE [dbo].[AddCollection]
	@name VARCHAR(50),
	@description VARCHAR(255)
AS
	SET NOCOUNT ON;
	INSERT INTO [dbo].[COLLECTION] ([dbo].[COLLECTION].[collection_name], [dbo].[COLLECTION].[collection_description]) 
		VALUES (@name, @description);
