CREATE FUNCTION [dbo].[GetAncestorSamplingFeatures]
(
	@namespace VARCHAR(50),
	@identifier VARCHAR(50)
)
RETURNS TABLE AS RETURN
(
	WITH ANCESTORS(ancestor_sampling_feature_id, ancestor_feature_namespace, ancestor_feature_identifier, ancestor_feature_type)
	AS
	(
		SELECT REL.[from_sampling_feature_id], sfl.feature_namespace, sfl.feature_identifier, sfl.feature_type
		FROM SAMPLING_FEATURE_RELATION AS rel
			INNER JOIN SAMPLING_FEATURE AS sfr
				ON rel.to_sampling_feature_id = sfr.sampling_feature_id
			INNER JOIN SAMPLING_FEATURE AS sfl
				ON rel.from_sampling_feature_id = sfl.sampling_feature_id
		WHERE sfr.feature_namespace = @namespace AND sfr.feature_identifier = @identifier
    
		UNION ALL

		SELECT rel.[from_sampling_feature_id], sfl.feature_namespace, sfl.feature_identifier, sfl.feature_type
		FROM SAMPLING_FEATURE_RELATION AS rel
			INNER JOIN SAMPLING_FEATURE AS sfl
				ON rel.from_sampling_feature_id = sfl.sampling_feature_id	
			INNER JOIN ANCESTORS AS A1
				ON REL.[to_sampling_feature_id] = A1.ancestor_sampling_feature_id
	)
	-- Statement that executes the CTE
	SELECT	D2.ancestor_sampling_feature_id,
			D2.ancestor_feature_namespace,
			D2.ancestor_feature_identifier,
			D2.ancestor_feature_type
	FROM ANCESTORS AS D2
);

