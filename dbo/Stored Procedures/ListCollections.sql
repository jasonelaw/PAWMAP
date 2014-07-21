CREATE PROCEDURE [dbo].[ListCollections]
	@all BIT = 0
AS
	SET NOCOUNT ON;
	SELECT collection_name, collection_description, date_created, collection_id 
		FROM COLLECTION
		WHERE user = SYSTEM_USER OR @all = 1;