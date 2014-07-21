CREATE FUNCTION [dbo].[GetObservationsBySamplingFeature]
(
	@namespace VARCHAR(50),
	@identifier VARCHAR(50)
)
RETURNS TABLE 
AS 
RETURN	
(
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
		FROM [dbo].[V_OBSERVATION] as vo
		WHERE	vo.observed_feature_namespace = @namespace
				AND vo.observed_feature_identifier = @identifier
);

