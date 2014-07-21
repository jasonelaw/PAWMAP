CREATE PROCEDURE [dbo].[SetUpStatus]
AS
	SET NOCOUNT ON;

	MERGE INTO OBSERVATION_STATUS AS [target]
	USING (VALUES
		('Preliminary'),
		('Accepted'),
		('Final'),
		('Rejected'),
		('Validated')
		) AS [source]([observation_status])
		ON target.observation_status = source.observation_status
	WHEN NOT MATCHED BY TARGET THEN 
		INSERT (observation_status) VALUES (observation_status) 
	WHEN NOT MATCHED BY SOURCE THEN 
		DELETE;


