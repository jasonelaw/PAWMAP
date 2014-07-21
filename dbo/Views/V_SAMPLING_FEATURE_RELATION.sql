CREATE VIEW [dbo].[V_SAMPLING_FEATURE_RELATION]
	AS 
	
	SELECT	sfl.feature_namespace AS [parent_feature_namespace], 
			sfl.feature_identifier AS [parent_feature_identifier],
			sfr.feature_namespace,
			sfr.feature_identifier,
			r.relationship_name,
			rel.from_sampling_feature_id,
			rel.to_sampling_feature_id
		FROM SAMPLING_FEATURE_RELATION AS rel
			INNER JOIN SAMPLING_FEATURE AS sfl
				ON rel.from_sampling_feature_id = sfl.sampling_feature_id
			INNER JOIN SAMPLING_FEATURE AS sfr
				ON rel.to_sampling_feature_id = sfr.sampling_feature_id
			INNER JOIN RELATIONSHIP r
				on rel.relationship_id = r.relationship_id
