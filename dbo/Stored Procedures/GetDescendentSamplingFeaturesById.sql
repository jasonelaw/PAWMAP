CREATE PROCEDURE [dbo].[GetDescendentSamplingFeaturesById2] 
	@id int
AS
	SET NOCOUNT ON;

	WITH DESCENDANTS(to_feature)
	AS
	(
		SELECT SFR.[to_sampling_feature_id]
		FROM SAMPLING_FEATURE_RELATION AS SFR
		WHERE SFR.[from_sampling_feature_id] = @id
    
		UNION ALL

		SELECT SFR.[to_sampling_feature_id]
		FROM SAMPLING_FEATURE_RELATION AS SFR	
		INNER JOIN DESCENDANTS AS D1
			ON SFR.[from_sampling_feature_id] = D1.to_feature
	)
	-- Statement that executes the CTE
	SELECT D2.to_feature as sampling_feature_id
	FROM DESCENDANTS D2
	UNION
	SELECT sampling_feature_id FROM SAMPLING_FEATURE WHERE sampling_feature_id = @id;
