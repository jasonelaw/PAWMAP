CREATE PROCEDURE [dbo].[SearchSamples]
	@namespace		VARCHAR(50) = NULL,
	@identifier		VARCHAR(50) = NULL,
	@start_date		DATETIME = NULL,
	@end_date		DATETIME = NULL,
	@media			VARCHAR(50) = NULL,
	@sample_type	VARCHAR(100) = Null,
	@is_compliance	BIT = NULL,
	@is_qc			BIT = NULL,
	@property		VARCHAR(50) = NULL,
	@value			VARCHAR(200) = NULL
AS
	SET NOCOUNT ON
	SELECT	vs.feature_namespace,
			vs.feature_identifier,
			vs.collection_date,
			vs.media,
			vs.sample_type,
			vs.laboratory_identifier,
			vs.sample_collection_procedure,
			vs.sample_handling_procedure,
			vs.feature_description,
			vs.is_compliance,
			vs.is_qc,
			vs.sampling_feature_id,
			vs.sample_id,
			vs.collection_process_id,
			vs.handling_process_id
		FROM V_SAMPLE AS vs
			LEFT JOIN FEATURE_PROPERTY AS fp
				ON vs.sampling_feature_id = fp.sampling_feature_id
			LEFT JOIN GENERIC_PROPERTY AS gp
				ON fp.generic_property_id = gp.generic_property_id
		WHERE	(gp.property_name = @property OR @property IS NULL)
				AND (fp.property_value = @value OR @value IS NULL)
				AND (vs.feature_namespace = @namespace OR @namespace IS NULL)
				AND (vs.feature_identifier = @identifier OR @identifier IS NULL)
				AND (vs.collection_date >= @start_date OR @start_date IS NULL)
				AND (vs.collection_date <= @end_date OR @end_date IS NULL)
				AND (vs.media = @media OR @media IS NULL)
				AND (vs.sample_type = @sample_type OR @sample_type IS NULL)
				AND (vs.is_compliance = @is_compliance OR @is_compliance IS NULL)
				AND (vs.is_qc = @is_qc OR @is_qc IS NULL)
		OPTION(RECOMPILE)

