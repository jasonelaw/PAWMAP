CREATE TABLE [dbo].[LOCATION] (
    [location_id]			INT IDENTITY (1, 1) NOT NULL,
    [location_name]			VARCHAR (255) NOT NULL,
    [sampled_feature_type]	VARCHAR (50) NOT NULL,
	[location_type]			VARCHAR(50) NOT NULL,
    [geographic_feature]	[sys].[geography] NULL,
    [sampling_feature_id]	INT NOT NULL,
    CONSTRAINT [LOCATION_PK] PRIMARY KEY CLUSTERED ([location_id] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_LOCATION_SAMPLING_FEATURE] FOREIGN KEY ([sampling_feature_id]) REFERENCES [dbo].[SAMPLING_FEATURE] ([sampling_feature_id]) ON DELETE CASCADE
);




GO
EXECUTE sp_addextendedproperty @name = N'Description', @value = N'The LOCATION table stores attribute information for physical locations.  It does not store spatial properties (coordinates, spatial reference, etc.) but can store references to GIS data using the GEOMETRY_SOURCE and GIS_OBJECT_ID.  All LOCATION records must have a LOCATION_CODE as well as a SAMPLING_FEATURE_ID.  There will be one record in the SAMPLING_FEATURE table for each LOCATION record.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LOCATION';


GO

CREATE SPATIAL INDEX [SPATIAL_LOCATION_geographic_feature] ON [dbo].[LOCATION] ([geographic_feature])
