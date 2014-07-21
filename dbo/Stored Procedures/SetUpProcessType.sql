CREATE PROCEDURE [dbo].[SetUpProcessType]
AS
	SET NOCOUNT ON;

	MERGE INTO PROCESS_TYPE AS [target]
	USING (VALUES
		('Sample Collection'),
		('Sample Handling'),
		('Observation')
		) AS [source]([process_type])
		ON target.process_type = source.process_type
	WHEN NOT MATCHED BY TARGET THEN 
		INSERT (process_type) VALUES (process_type) 
	WHEN NOT MATCHED BY SOURCE THEN 
		DELETE;


