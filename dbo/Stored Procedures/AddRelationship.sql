CREATE PROCEDURE [dbo].[AddRelationship]
	@name VARCHAR(30),
	@description VARCHAR(500)
AS
	INSERT INTO RELATIONSHIP (relationship_name, relationship_description) VALUES (@name, @description);
