CREATE PROCEDURE [dbo].[AddUnit]
	@print VARCHAR(30),
	@description VARCHAR(255),
	@ucum VARCHAR(30)
AS
	SET NOCOUNT ON;

	INSERT INTO UNIT (unit_print, unit_description, unit_ucum) VALUES (@print, @description, @ucum);
