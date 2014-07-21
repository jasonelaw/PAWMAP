CREATE FUNCTION [dbo].[GetDescendentSamplingFeaturesPivoted]
(
	@namespace VARCHAR(50),
	@identifier VARCHAR(50)
)
RETURNS TABLE AS RETURN
(
	SELECT	feature_namespace, 
			feature_identifier, 
			[Location - Sample] as sample_location, 
			[Parent Location - Sublocation] as parent_location, 
			[Location - Composite Sample] as [location of composite], 
			[Sample - Composite Sample] as [parent_sample (of composite)], 
			[Sample - Field Duplicate] as [parent_sample (of duplicate)], 
			[Sample - Trip Blank] as [parent_sample (of trip blank)]
		FROM	(SELECT	ancestor_feature_namespace + ':' + ancestor_feature_identifier AS parent_feature_identifier, 
						feature_namespace, 
						feature_identifier, 
						relationship
					FROM dbo.GetDescendentSamplingFeaturesByIdentifier(@namespace, @identifier)) as p
		PIVOT
		(
			MAX(p.parent_feature_identifier)
			FOR relationship in (	[Location - Sample], 
									[Parent Location - Sublocation],
									[Location - Composite Sample],
									[Sample - Composite Sample],
									[Sample - Field Duplicate],
									[Sample - Trip Blank])
		) AS PivotTable
)
