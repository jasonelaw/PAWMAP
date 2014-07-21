CREATE FUNCTION [dbo].[GetAncestorSamplingFeaturesByIdentifier]
(
	@namespace VARCHAR(50),
	@identifier VARCHAR(50)
)
RETURNS TABLE AS RETURN
(
	WITH ANCESTORS(ancestor_feature_namespace, ancestor_feature_identifier, relationship, feature_namespace, feature_identifier, from_feature, to_feature)
	AS
	(
		SELECT sfl.feature_namespace, sfl.feature_identifier, r.relationship_name, sfr.feature_namespace, sfr.feature_identifier, rel.[from_sampling_feature_id], rel.[to_sampling_feature_id]
			FROM SAMPLING_FEATURE_RELATION AS rel
				INNER JOIN SAMPLING_FEATURE AS sfl
					ON sfl.sampling_feature_id = rel.from_sampling_feature_id
				INNER JOIN SAMPLING_FEATURE AS sfr
					ON sfr.sampling_feature_id = rel.to_sampling_feature_id
				INNER JOIN RELATIONSHIP as r
					ON rel.relationship_id = r.relationship_id
			WHERE	(sfr.feature_namespace = @namespace OR @namespace IS NULL)
					AND (sfr.feature_identifier = @identifier OR @identifier IS NULL)
    
		UNION ALL

		SELECT sfl.feature_namespace, sfl.feature_identifier, r.relationship_name, A1.ancestor_feature_namespace, A1.ancestor_feature_identifier, sfl.[sampling_feature_id], A1.[from_feature]
			FROM SAMPLING_FEATURE_RELATION AS rel
				INNER JOIN SAMPLING_FEATURE as sfl
					ON rel.from_sampling_feature_id = sfl.sampling_feature_id
				INNER JOIN RELATIONSHIP AS r
					on rel.relationship_id = r.relationship_id
				INNER JOIN ANCESTORS AS A1
					ON rel.[to_sampling_feature_id] = A1.from_feature
	)
	-- Statement that executes the CTE
	SELECT	A2.ancestor_feature_namespace,
			A2.ancestor_feature_identifier,
			A2.relationship,
			A2.feature_namespace,
			A2.feature_identifier,
			A2.to_feature as sampling_feature_id
		FROM ANCESTORS A2
);
