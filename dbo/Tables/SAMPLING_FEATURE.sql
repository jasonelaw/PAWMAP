CREATE TABLE [dbo].[SAMPLING_FEATURE] (
    [sampling_feature_id] INT           IDENTITY (1, 1) NOT NULL,
    [feature_type]        VARCHAR (255) NOT NULL,
	[feature_namespace]   VARCHAR (50)  NOT NULL,
    [feature_identifier]  VARCHAR (50)  NOT NULL,
    [feature_description] VARCHAR (MAX) NULL,
    CONSTRAINT [SAMPLING_FEATURE_PK] PRIMARY KEY CLUSTERED ([sampling_feature_id] ASC) WITH (FILLFACTOR = 90), 
    CONSTRAINT [AK_SAMPLING_FEATURE_FEATURE_IDENTIFIER] UNIQUE ([feature_namespace], [feature_identifier])
);


GO
EXECUTE sp_addextendedproperty @name = N'Description', @value = N'The SAMPLING_FEATURE table represents an abstraction of LOCATIONs and SAMPLEs.  It stores one record for each LOCATION and SAMPLE record, providing a common data type for relating both of these data types.  It is referenced by LOCATION, SAMPLE, OBSERVATION and SAMPLING_FEATURE_RELATION records.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'SAMPLING_FEATURE';


GO

CREATE INDEX [IX_SAMPLING_FEATURE_identifier] 
	ON [dbo].[SAMPLING_FEATURE] ([feature_namespace],[feature_identifier])
	INCLUDE (feature_type)
