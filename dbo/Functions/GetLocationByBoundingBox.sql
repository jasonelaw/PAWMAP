CREATE FUNCTION [dbo].[GetLocationByBoundingBox]
(
	@bbox VARCHAR(MAX) = "POLYGON((-123.0 45.33,-122.0 45.33,-122.0 45.67,-123.0 45.67,-123.0 45.33))",
	@srid INT = 4326
)
RETURNS TABLE AS RETURN
(
	SELECT	vl.feature_namespace,
			vl.feature_identifier,
			vl.location_name,
			vl.location_type,
			vl.sampled_feature_type,
			vl.feature_description,
			vl.latitude,
			vl.longitude,
			vl.feature_geometry,
			vl.sampling_feature_id
		FROM V_LOCATION as vl
		WHERE geography::STGeomFromText(@bbox, @srid).STIntersects(vl.feature_geometry) = 1
)
