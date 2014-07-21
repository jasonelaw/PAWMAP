CREATE PROCEDURE [dbo].[SearchLocations]
	@namespace		VARCHAR(50) = NULL,
	@identifier		VARCHAR(50) = NULL,
	@name			VARCHAR(255) = NULL,
	@location_type	VARCHAR(50) = NULL,
	@bbox			VARCHAR(MAX) = NULL,
	@srid			INT = NULL,
	@property		VARCHAR(50) = NULL,
	@value			VARCHAR(200) = NULL
AS
	SET NOCOUNT ON
	IF @bbox IS NOT NULL AND @srid IS NOT NULL
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
			FROM V_LOCATION AS vl
				LEFT JOIN FEATURE_PROPERTY AS fp
					ON vl.sampling_feature_id = fp.sampling_feature_id
				LEFT JOIN GENERIC_PROPERTY AS gp
					ON fp.generic_property_id = gp.generic_property_id
			WHERE	(gp.property_name = @property OR @property IS NULL)
					AND (fp.property_value = @value OR @value IS NULL)
					AND (vl.feature_namespace = @namespace OR @namespace IS NULL)
					AND (vl.feature_identifier = @identifier OR @identifier IS NULL)
					AND (vl.location_name = @name OR @name IS NULL)
					AND (vl.location_type = @location_type OR @location_type IS NULL)
					AND geography::STGeomFromText(@bbox, @srid).STIntersects(vl.feature_geometry) = 1
			OPTION(RECOMPILE)
	ELSE
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
			FROM V_LOCATION AS vl
				LEFT JOIN FEATURE_PROPERTY AS fp
					ON vl.sampling_feature_id = fp.sampling_feature_id
				LEFT JOIN GENERIC_PROPERTY AS gp
					ON fp.generic_property_id = gp.generic_property_id
			WHERE	(gp.property_name = @property OR @property IS NULL)
					AND (fp.property_value = @value OR @value IS NULL)
					AND (vl.feature_namespace = @namespace OR @namespace IS NULL)
					AND (vl.feature_identifier = @identifier OR @identifier IS NULL)
					AND (vl.location_name = @name OR @name IS NULL)
					AND (vl.location_type = @location_type OR @location_type IS NULL)
			OPTION(RECOMPILE)