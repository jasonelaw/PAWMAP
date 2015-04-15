CREATE PROCEDURE [dbo].[AddClassificationScheme]
	@name VARCHAR(50)
AS
	SET NOCOUNT ON;

	INSERT INTO [dbo].[CLASSIFICATION_SCHEME] ([dbo].[CLASSIFICATION_SCHEME].[scheme_name]) VALUES (@name);

