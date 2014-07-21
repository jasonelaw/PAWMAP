CREATE PROCEDURE [dbo].[SetUpRelationship]
AS
	SET NOCOUNT ON;

	MERGE INTO RELATIONSHIP AS [target]
	USING (VALUES 
		('Location - Sample', 'A sample is a piece of physical material collected from a physical location.'), 
		('Parent Location - Sublocation', 'A location that is in some way dependant on a parent location (e.g., a sample point on a transect, a station within a polygon, a sensor location within a larger monitoring station, etc) and usually gains location information through it''s parent'),
		('Location - Composite Sample', 'A sample created from subsamples collected from multiple locations, where the subsamples are ephemeral and not represented in the data management system.'),
		('Sample - Composite Sample', 'A sample composed of independent samples collected over either space or time.'),
		('Sample - Field Duplicate', 'A sample that is collected at the same time and place and performed for quality control.'),
		('Sample - Trip Blank', 'A quality control sample that is intended to measure whether samples were contaminated in transit from the field to the laboratory.')
		) AS [source]([relationship_name], [relationship_description])
		ON target.relationship_name = source.relationship_name
	WHEN NOT MATCHED BY TARGET THEN 
		INSERT (relationship_name, relationship_description) VALUES (relationship_name, relationship_description) 
	WHEN NOT MATCHED BY SOURCE THEN 
		DELETE;
