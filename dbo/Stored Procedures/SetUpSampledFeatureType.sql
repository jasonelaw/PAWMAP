CREATE PROCEDURE [dbo].[SetUpSampledFeatureType]
AS
	SET NOCOUNT ON;

	MERGE INTO SAMPLED_FEATURE_TYPE AS [target]
	USING (VALUES 
		('Canal Drainage'),
		('Canal Irrigation'),
		('Channelized Stream'),
		('Combined Sewer'),
		('Constructed Wetland'),
		('Estuary'),
		('Facility Industrial'),
		('Facility Municipal Sewage (POTW)'),
		('Facility Other'),
		('Facility Privately Owned Non-industrial'),
		('Facility Public Water Supply (PWS)'),
		('Lake'),
		('Land'),
		('Landfill'),
		('Ground Water'),
		('Other Surface Water'),
		('Pipe, Unspecified Source'),
		('Playa'),
		('Reservoir'),
		('River/Stream'),
		('River/Stream Ephemeral'),
		('River/Stream Intermittent'),
		('River/Stream Perennial'),
		('Riverine Impoundment'),
		('Sanitary Sewer'),
		('Seep'),
		('Spring'),
		('Storm Sewer'),
		('Stormwater Pond'),
		('Waste Pit'),
		('Wetland')
		) AS [source]([sampled_feature_type])
		ON target.sampled_feature_type = source.sampled_feature_type
	WHEN NOT MATCHED BY TARGET THEN 
		INSERT (sampled_feature_type) VALUES (sampled_feature_type)
	WHEN NOT MATCHED BY SOURCE THEN 
		DELETE;
