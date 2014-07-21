CREATE TABLE [dbo].[FEATURE_PROPERTY] (
    [sampling_feature_id]          INT           NOT NULL,
    [generic_property_id]         INT           NOT NULL,
    [property_value]      VARCHAR (200) NOT NULL,
    PRIMARY KEY CLUSTERED ([sampling_feature_id] ASC, [generic_property_id] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_FEATURE_PROPERTY_GENERIC_PROPERTY] FOREIGN KEY ([generic_property_id]) REFERENCES [dbo].[GENERIC_PROPERTY] ([generic_property_id]),
    CONSTRAINT [FK_FEATURE_PROPERTY_SAMPLING_FEATURE] FOREIGN KEY ([sampling_feature_id]) REFERENCES [dbo].[SAMPLING_FEATURE] ([sampling_feature_id]) 
);

