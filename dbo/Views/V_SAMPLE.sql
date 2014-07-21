CREATE VIEW [dbo].[V_SAMPLE]
	AS 
	SELECT	sf.feature_type,
			sf.feature_namespace,
			sf.feature_identifier,
			sa.collection_date,
			sa.media,
			sa.sample_type,
			sa.laboratory_identifier,
			pr1.process_name AS sample_collection_procedure,
			pr2.process_name AS sample_handling_procedure,
			sf.feature_description,
			sa.is_compliance,
			sa.is_qc,
			sf.sampling_feature_id,
			sa.sample_id,
			sa.collection_process_id,
			sa.handling_process_id
	FROM [dbo].[SAMPLING_FEATURE] AS sf
		INNER JOIN [dbo].[SAMPLE] AS sa
			ON sf.sampling_feature_id = sa.sampling_feature_id
		LEFT JOIN [dbo].[PROCESS] AS pr1
			ON sa.[collection_process_id] = pr1.process_id
		LEFT JOIN [dbo].[PROCESS] AS pr2
			on sa.[handling_process_id] = pr2.process_id;