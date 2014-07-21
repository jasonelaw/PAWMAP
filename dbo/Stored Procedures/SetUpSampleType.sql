CREATE PROCEDURE [dbo].[SetUpSampleType]
AS
SET NOCOUNT ON;

	MERGE INTO SAMPLE_TYPE AS [target]
	USING (VALUES
		('Equipment Rinsate Blank'),
		('Blind Duplicate'),
		('Equipment Blank'),
		('Field Ambient Conditions Blank'),
		('Field Blank'),
		('Field Replicate'),
		('Field Spike'),
		('Field Surrogate Spike'),
		('Inter-lab Split'),
		('Lab Blank'),
		('Lab Duplicate'),
		('Lab Matrix Spike'),
		('Lab Re-Analysis'),
		('Lab Spike'),
		('Lab Split'),
		('Quality Control Sample-Other'),
		('Post-preservative Blank'),
		('Pre-preservative Blank'),
		('Reagent Blank'),
		('Trip Blank'),
		('Composite With Parents'),
		('Composite Without Parents'),
		('Depletion Replicate'),
		('Field Subsample'),
		('Integrated Cross-Sectional Profile'),
		('Integrated Flow Proportioned'),
		('Integrated Horizontal Profile'),
		('Integrated Time Series'),
		('Integrated Vertical Profile'),
		('Negative Control'),
		('Positive Control'),
		('Routine'),
		('Other'),
		('Field Split')
		) AS [source]([sample_type])
		ON target.sample_type = source.sample_type
	WHEN NOT MATCHED BY TARGET THEN 
		INSERT (sample_type) VALUES (sample_type) 
	WHEN NOT MATCHED BY SOURCE THEN 
		DELETE;

