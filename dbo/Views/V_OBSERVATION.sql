CREATE VIEW [dbo].[V_OBSERVATION]
	AS
		SELECT	sf.feature_namespace AS [observed_feature_namespace],
				sf.feature_identifier AS [observed_feature_identifier],
				sf.feature_type AS [observed_feature_type],
				obs.phenomenon_time_start,
				obs.phenomenon_time_end,
				ph.phenomenon_name AS [observed_property_name],
				ph.phenomenon_code AS [observed_property_code],
				ph.result_type,
				pr.process_name AS [procedure],
				obs.observer,
				obs.quality_control_level,
				obs.observation_status,
				obs.observation_comment,
				vr.result,
				vr.qualifier,
				vr.unit,
				vr.component_property_name,
				vr.component_property_code,
				vr.result_time_utc,
				vr.result_time_local,
				vr.result_time_local_offset,
				sf.sampling_feature_id,
				obs.observation_id,
				pr.process_id,
				ph.phenomenon_id
		FROM	[dbo].[OBSERVATION] AS obs
				LEFT JOIN [dbo].[SAMPLING_FEATURE] sf 
					ON obs.sampling_feature_id = sf.sampling_feature_id
				LEFT JOIN [dbo].[PHENOMENON] AS ph
					ON obs.[phenomenon_id] = ph.phenomenon_id
				LEFT JOIN [dbo].[PROCESS] AS pr
					ON [obs].[process_id] = pr.process_id
				LEFT JOIN [dbo].[V_RESULT] as vr
					ON obs.observation_id = vr.observation_id
