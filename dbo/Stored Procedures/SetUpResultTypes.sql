CREATE PROCEDURE [dbo].[SetUpResultTypes]
AS
	SET NOCOUNT ON;

	MERGE INTO RESULT_TYPE AS [target]
	USING (VALUES 
		('Quantity'), 
		('Count'),
		('Category'),
		('Time Series'),
		('Complex')
		/*('Text'),
		('Time'),
		('Geometry'),*/
		/*TimeInterval,File*/
		) AS [source]([result_type])
		ON target.result_type = source.result_type
	WHEN NOT MATCHED BY TARGET THEN 
		INSERT (result_type) VALUES (result_type) 
	WHEN NOT MATCHED BY SOURCE THEN 
		DELETE;
