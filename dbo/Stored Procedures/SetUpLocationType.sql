CREATE PROCEDURE [dbo].[SetUpLocationType]
AS
SET NOCOUNT ON;

	MERGE INTO LOCATION_TYPE AS [target]
	USING (VALUES
		('Borehole'),
		('Plot'),
		('Profile'),
		('Sensor'),
		('Station'),
		('Transect'),
		('Well')
		/*('Test Pit'),etc*/
		) AS [source]([location_type])
		ON target.location_type = source.location_type
	WHEN NOT MATCHED BY TARGET THEN 
		INSERT (location_type) VALUES (location_type) 
	WHEN NOT MATCHED BY SOURCE THEN 
		DELETE;
