
SELECT * FROM V_LOCATION;

SELECT * FROM dbo.GetObservationsBySamplingFeature('ABC', '123')
SELECT * FROM dbo.GetObservationsByObservedProperty('color')

EXEC	[dbo].[SearchLocations]
		@namespace = N'ABC',
		@bbox = N'POLYGON((175.0 44,185 44,185 46,175 46,175 44))',
		@srid = 4326

EXEC	[dbo].[SearchSamples]
		@namespace = N'DEF'

EXEC	[dbo].[SearchObservations]
		@observed_property_name = N'color'

SELECT *
	FROM V_LOCATION AS vl
		LEFT JOIN FEATURE_PROPERTY AS fp
			ON vl.sampling_feature_id = fp.sampling_feature_id
		LEFT JOIN GENERIC_PROPERTY AS gp
			ON fp.generic_property_id = gp.generic_property_id

SELECT * FROM V_SAMPLE

SELECT vo.*
	FROM dbo.GetDescendentSamplingFeatures2(N'ABC', N'123') AS f
		INNER JOIN V_OBSERVATION AS vo
			ON f.sampling_feature_id = vo.sampling_feature_id

SELECT * FROM dbo.GetDescendentSamplingFeatures(N'ABC', N'123');

SELECT * FROM dbo.GetDescendentSamplingFeaturesPivoted(N'ABC', N'123')

SELECT * FROM dbo.GetAncestorSamplingFeatures(N'DEF', N'001');

SELECT sfl.feature_namespace, sfl.feature_identifier, sfr.feature_identifier, sfr.feature_namespace
	FROM SAMPLING_FEATURE_RELATION as rel
		RIGHT JOIN SAMPLING_FEATURE as sfl
			ON rel.from_sampling_feature_id = sfl.sampling_feature_id
		INNER JOIN SAMPLING_FEATURE as sfr
			ON rel.to_sampling_feature_id = sfr.sampling_feature_id
		INNER JOIN GetDescendentSamplingFeaturesById(136862) as d
			ON rel.to_sampling_feature_id = d.sampling_feature_id

SELECT sfl.feature_namespace, sfl.feature_identifier, sfr.feature_identifier, sfr.feature_namespace
	FROM SAMPLING_FEATURE_RELATION as rel
		RIGHT JOIN SAMPLING_FEATURE as sfl
			ON rel.from_sampling_feature_id = sfl.sampling_feature_id
		INNER JOIN SAMPLING_FEATURE as sfr
			ON rel.to_sampling_feature_id = sfr.sampling_feature_id
		INNER JOIN GetDescendentSamplingFeaturesById(136862) as d
			ON rel.to_sampling_feature_id = d.sampling_feature_id

SELECT * FROM SAMPLING_FEATURE
	INNER JOIN dbo.GetAncestorSamplingFeatures('DEF', '001') as a
		ON SAMPLING_FEATURE.sampling_feature_id = a.sampling_feature_id

SELECT * FROM dbo.GetDescendentSamplingFeatures('ABC', '123')
SELECT * FROM dbo.GetAncestorSamplingFeatures('ABC', '124')
SELECT * FROM dbo.GetAncestorSamplingFeatures('DEF', '002')

SELECT *
	FROM V_SAMPLING_FEATURE_RELATION AS v
		INNER JOIN dbo.GetAncestorSamplingFeatures('DEF', '002') AS anc
			ON v.from_sampling_feature_id = anc.sampling_feature_id;

SELECT sf.*, anc.feature_identifier, anc.feature_namespace, anc.feature_type
FROM SAMPLING_FEATURE as sf
    CROSS APPLY GetAncestorSamplingFeatures(sf.feature_namespace, sf.feature_identifier) AS anc
WHERE sf.feature_namespace = 'DEF';

EXEC	SearchObservations
		@observed_property_code = 'color',
		@maxdate = '2014-07-01 11:16:53'

DECLARE @g geography = 'LINESTRING(-120 45, -120 0, -90 0)'; 
SELECT @g.EnvelopeAngle(), @g.EnvelopeCenter().Lat;

DECLARE @g1 geography = 'CIRCULARSTRING(-122.358 47.653, -122.348 47.649, -122.348 47.658, -122.358 47.658, -122.358 47.653)';
DECLARE @g2 geography = 'LINESTRING(-119.119263 46.183634, -119.273071 47.107523, -120.640869 47.569114, -122.200928 47.454094)';
SELECT @g1.ShortestLineTo(@g2).ToString();

EXEC	GetNearestLocations
		@latitude = 45,
		@longitude = 180,
		@n = 2