CREATE PROCEDURE [dbo].[AddClassificationScheme]
	@name VARCHAR(50)
AS
	SET NOCOUNT ON;

	INSERT INTO CLASSIFICATION_SCHEME (scheme_name) VALUES (@name);

