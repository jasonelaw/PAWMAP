CREATE VIEW [dbo].[V_RESULT]
	AS
	SELECT	qr.result as result, 
			qr.qualifier as qualifier,
			u.unit_print as unit,
			p1.phenomenon_name as component_property_name, 
			p1.phenomenon_code as component_property_code,
			Null as result_time_utc,
			Null as result_time_local,
			Null as result_time_local_offset,
			qr.observation_id
		FROM [dbo].[QUANTITY_RESULT] AS qr
			LEFT JOIN [dbo].[PHENOMENON] as p1
				ON qr.phenomenon_id = p1.phenomenon_id
			LEFT JOIN [dbo].[UNIT] as u
				ON qr.unit_id = u.unit_id
	
	UNION ALL
	
	SELECT	rc.category_code as result, 
			cr.qualifier,
			'None' as unit,
			p2.phenomenon_name as component_property_name, 
			p2.phenomenon_code as component_property_code,
			Null as result_time_utc,
			Null as result_time_local,
			Null as result_time_local_offset,
			cr.observation_id
		FROM [dbo].[CATEGORICAL_RESULT] AS cr
			LEFT JOIN [dbo].[RESULT_CATEGORY] AS rc
				ON cr.category_result_id = rc.result_category_id
			LEFT JOIN [dbo].[PHENOMENON] as p2
				ON cr.phenomenon_id = p2.phenomenon_id
	
	UNION ALL
	
	SELECT	cnt.result,
			cnt.qualifier,
			'None' as unit,
			p3.phenomenon_name as component_property_name, 
			p3.phenomenon_code as component_property_code,
			Null as result_time_utc,
			Null as result_time_local,
			Null as result_time_local_offset,
			cnt.observation_id
		FROM [dbo].[COUNT_RESULT] AS cnt
			LEFT JOIN [dbo].[PHENOMENON] as p3
				ON cnt.phenomenon_id = p3.phenomenon_id

	UNION ALL
	
	SELECT	ts.result,
			ts.qualifier,
			u.unit_print as unit,
			Null as component_property_name, 
			Null as component_property_code,
			ts.result_time_utc,
			ts.result_time_local,
			ts.result_time_local_offset,
			ts.observation_id
		FROM [dbo].[TIME_SERIES_RESULT] AS ts
			LEFT JOIN [dbo].[UNIT] as u
				ON ts.unit_id = u.unit_id