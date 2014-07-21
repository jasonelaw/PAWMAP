CREATE VIEW [dbo].[V_LOCATION]
	AS 
	SELECT	sf.feature_namespace, 
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
				ON sf.sampling_feature_id = l.sampling_feature_id;