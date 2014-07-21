CREATE TABLE [dbo].[SAMPLING_FEATURE_RELATION] (
    [sampling_feature_relation_id] INT IDENTITY (1, 1) NOT NULL,
    [from_sampling_feature_id]                 INT NOT NULL,
    [to_sampling_feature_id]                   INT NOT NULL,
    [relationship_id]              INT NOT NULL,
    CONSTRAINT [SAMPLING_FEATURE_RELATION_PK] PRIMARY KEY CLUSTERED ([sampling_feature_relation_id] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_SAMPLING_FEATURE_RELATION_SAMPLINGFEATURE1] FOREIGN KEY ([from_sampling_feature_id]) REFERENCES [dbo].[SAMPLING_FEATURE] ([sampling_feature_id]),
    CONSTRAINT [FK_SAMPLING_FEATURE_RELATION_SAMPLINGFEATURE2] FOREIGN KEY ([to_sampling_feature_id]) REFERENCES [dbo].[SAMPLING_FEATURE] ([sampling_feature_id]) ON DELETE CASCADE,
    CONSTRAINT [RELATIONSHIP_SAMPLING_FEATURE_RELATION_FK1] FOREIGN KEY ([relationship_id]) REFERENCES [dbo].[RELATIONSHIP] ([relationship_id]), 
    CONSTRAINT [AK_SAMPLING_FEATURE_RELATION_unique_rows] UNIQUE ([from_sampling_feature_id], [to_sampling_feature_id])
);


GO
EXECUTE sp_addextendedproperty @name = N'Description', @value = N'The SAMPLING_FEATURE_RELATION table stores the hierarchical relationship among LOCATIONS and SAMPLES by storing related SAMPLING_FEATURE records as simple to and from relationships.  Relationship types are defined in the RELATIONSHIP table.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'SAMPLING_FEATURE_RELATION';

