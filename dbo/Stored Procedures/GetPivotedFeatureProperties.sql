CREATE PROCEDURE [dbo].[GetPivotedFeatureProperties]
	@featureid IdTable READONLY
AS
	DECLARE	@cols AS NVARCHAR(MAX),
			@query  AS NVARCHAR(MAX);

	CREATE TABLE #properties (sampling_feature_id INT, property_name VARCHAR(50), property_value VARCHAR(200))
	INSERT INTO #properties
		SELECT	fp.sampling_feature_id, 
				gp.property_name,
                fp.property_value
        FROM FEATURE_PROPERTY as fp 
			INNER JOIN GENERIC_PROPERTY gp
				ON fp.generic_property_id = gp.generic_property_id
			INNER JOIN @featureid fid
				on fp.sampling_feature_id = fid.id
SET @cols = STUFF((	SELECT distinct ',' + QUOTENAME(c.property_name) 
					FROM #properties c
					FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 1, '')

set @query =	'SELECT sampling_feature_id, ' + @cols + ' from 
				(SELECT sampling_feature_id, property_name, property_value FROM #properties)
				pivot 
				(
					max(property_value)
					for property_name in (' + @cols + ')
				) p '

EXECUTE sp_executesql @query
