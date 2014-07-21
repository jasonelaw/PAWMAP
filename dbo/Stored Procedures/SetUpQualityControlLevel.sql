CREATE PROCEDURE [dbo].[SetUpQualityControlLevel]
AS
SET NOCOUNT ON;

	MERGE INTO QUALITY_CONTROL_LEVEL AS [target]
	USING (VALUES
		('Raw Data'),
		('Quality Controlled Data'),
		('Derived Products'),
		('Interpreted Products'),
		('Knowledge Products')
		) AS [source]([quality_control_level])
		ON target.quality_control_level = source.quality_control_level
	WHEN NOT MATCHED BY TARGET THEN 
		INSERT (quality_control_level) VALUES (quality_control_level) 
	WHEN NOT MATCHED BY SOURCE THEN 
		DELETE;
