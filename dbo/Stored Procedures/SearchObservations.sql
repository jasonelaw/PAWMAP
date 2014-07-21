CREATE PROCEDURE [dbo].[SearchObservations]
	@feature_namespace varchar(50) = NULL,
	@feature_identifier varchar(50) = NULL,
	@observed_property_code varchar(50) = NULL,
	@observed_property_name varchar(100) = NULL,
	@procedure varchar(200) = NULL,
	@mindate datetime = NULL,
	@maxdate datetime = NULL
AS	
	SET NOCOUNT ON
	SELECT	vo.observed_feature_namespace,
			vo.observed_feature_identifier,
			vo.observed_feature_type,
			vo.phenomenon_time_start,
			vo.phenomenon_time_end,
			vo.observed_property_name,
			vo.observed_property_code,
			vo.result_type,
			vo.[procedure],
			vo.observer,
			vo.quality_control_level,
			vo.observation_status,
			vo.observation_comment,
			vo.result,
			vo.qualifier,
			vo.unit,
			vo.component_property_name,
			vo.component_property_code,
			vo.result_time_utc,
			vo.result_time_local,
			vo.result_time_local_offset,
			vo.sampling_feature_id,
			vo.observation_id,
			vo.process_id,
			vo.phenomenon_id
		FROM	[dbo].[V_OBSERVATION] AS vo
		WHERE	(vo.phenomenon_time_end >= @mindate OR @mindate IS NULL)
				AND (vo.phenomenon_time_start <= @maxdate OR @maxdate IS NULL)
				AND (vo.[procedure] = @procedure OR @procedure IS NULL)
				AND (vo.observed_property_code = @observed_property_code OR @observed_property_code IS NULL)
				AND (vo.observed_property_name = @observed_property_name OR @observed_property_name IS NULL)
				AND (vo.observed_feature_namespace = @feature_namespace OR @feature_namespace IS NULL)
				AND (vo.observed_feature_identifier = @feature_identifier OR @feature_identifier IS NULL)
	OPTION (RECOMPILE)
		
