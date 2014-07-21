CREATE PROCEDURE [dbo].[GetNearestLocations]
	@latitude float,
	@longitude float,
	@n int
AS
	SET NOCOUNT ON;
	DECLARE @g geography = geography::Point(@latitude, @longitude, 4326);
	SELECT TOP(@n)	sf.feature_namespace, 
					sf.feature_identifier, 
					l.location_name, 
					l.location_type, 
					l.sampled_feature_type, 
					sf.feature_description, 
					l.geographic_feature.Lat as latitude,
					l.geographic_feature.Long as longitude,
					l.geographic_feature.STAsText() as feature_geometry,
					sf.sampling_feature_id
		FROM [dbo].[SAMPLING_FEATURE] as sf
			INNER JOIN [dbo].[LOCATION] as l
				ON sf.sampling_feature_id = l.sampling_feature_id
		WHERE l.geographic_feature.STDistance(@g) IS NOT NULL
		ORDER BY l.geographic_feature.STDistance(@g);
