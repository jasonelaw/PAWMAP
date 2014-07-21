CREATE FUNCTION [dbo].[GetDescendentSamplingFeatures]
(
	@namespace VARCHAR(50),
	@identifier VARCHAR(50)
)
RETURNS TABLE AS RETURN
(
	WITH DESCENDANTS(to_feature, feature_namespace, feature_identifier, feature_type)
	AS
	(
		SELECT	rel.[to_sampling_feature_id], 
				sfr.feature_namespace,
				sfr.feature_identifier,
				sfr.feature_type
			FROM SAMPLING_FEATURE_RELATION AS rel
				INNER JOIN SAMPLING_FEATURE AS sfl
					ON rel.from_sampling_feature_id = sfl.sampling_feature_id
				INNER JOIN SAMPLING_FEATURE AS sfr
					ON rel.to_sampling_feature_id = sfr.sampling_feature_id
			WHERE sfl.feature_namespace = @namespace AND sfl.feature_identifier = @identifier
    
		UNION ALL

		SELECT	rel.[to_sampling_feature_id], 
				sfr.feature_namespace, 
				sfr.feature_identifier, 
				sfr.feature_type
			FROM SAMPLING_FEATURE_RELATION AS rel
				INNER JOIN SAMPLING_FEATURE AS sfr
					ON rel.to_sampling_feature_id = sfr.sampling_feature_id
				INNER JOIN DESCENDANTS AS D1
					ON rel.[from_sampling_feature_id] = D1.to_feature
	)
	-- Statement that executes the CTE
	SELECT	D2.to_feature as sampling_feature_id,
			D2.feature_namespace,
			D2.feature_identifier,
			D2.feature_type
	FROM DESCENDANTS D2
);