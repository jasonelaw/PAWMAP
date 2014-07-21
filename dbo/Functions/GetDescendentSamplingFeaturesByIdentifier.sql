CREATE FUNCTION [dbo].[GetDescendentSamplingFeaturesByIdentifier]
(
	@namespace VARCHAR(50),
	@identifier VARCHAR(50)
)
RETURNS TABLE AS RETURN
(
	WITH DESCENDANTS(ancestor_feature_namespace, ancestor_feature_identifier, relationship, feature_namespace, feature_identifier, to_feature)
	AS
	(
		SELECT sfl.feature_namespace, sfl.feature_identifier, r.relationship_name, sfr.feature_namespace, sfr.feature_identifier,  sfr.sampling_feature_id 
			FROM SAMPLING_FEATURE_RELATION AS rel
				INNER JOIN SAMPLING_FEATURE AS sfl
					ON sfl.sampling_feature_id = rel.from_sampling_feature_id
				INNER JOIN SAMPLING_FEATURE AS sfr
					ON sfr.sampling_feature_id = rel.to_sampling_feature_id
				INNER JOIN RELATIONSHIP as r
					ON rel.relationship_id = r.relationship_id
			WHERE	(sfl.feature_namespace = @namespace OR @namespace IS NULL)
					AND (sfl.feature_identifier = @identifier OR @identifier IS NULL)
    
		UNION ALL

		SELECT D1.feature_namespace, D1.feature_identifier, r.relationship_name, sfr.feature_namespace, sfr.feature_identifier, rel.[to_sampling_feature_id]
			FROM SAMPLING_FEATURE_RELATION AS rel
				INNER JOIN SAMPLING_FEATURE as sfr
					ON rel.to_sampling_feature_id = sfr.sampling_feature_id
				INNER JOIN RELATIONSHIP AS r
					on rel.relationship_id = r.relationship_id
				INNER JOIN DESCENDANTS AS D1
					ON rel.[from_sampling_feature_id] = D1.to_feature
	)
	-- Statement that executes the CTE
	SELECT	D2.ancestor_feature_namespace,
			D2.ancestor_feature_identifier,
			D2.relationship,
			D2.feature_namespace,
			D2.feature_identifier,
			D2.to_feature as sampling_feature_id
		FROM DESCENDANTS D2
	UNION
	SELECT	NULL as ancestor_feature_namespace,
			NULL as ancestor_feature_identifier,
			NULL as relationship,
			feature_namespace, 
			feature_identifier, 
			sampling_feature_id 
		FROM SAMPLING_FEATURE 
		WHERE feature_namespace = @namespace AND feature_identifier = @identifier
);