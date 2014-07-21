CREATE PROCEDURE [dbo].[AddCollection]
	@name VARCHAR(50),
	@description VARCHAR(255)
AS
	SET NOCOUNT ON;
	INSERT INTO COLLECTION (collection_name, collection_description) 
		VALUES (@name, @description);
