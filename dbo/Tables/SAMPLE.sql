CREATE TABLE [dbo].[SAMPLE] (
    [sample_id]                 INT           IDENTITY (1, 1) NOT NULL,
    [sampling_feature_id]       INT           NOT NULL,
    [collection_date]           DATETIME      NOT NULL,
    [media]                     VARCHAR (50)  NOT NULL,
    [sample_type]               VARCHAR (100) NOT NULL,
    [collection_process_id]      INT           NOT NULL,
    [laboratory_identifier]     VARCHAR (50)  NULL,
    [is_qc]                     BIT     NOT NULL,
    [is_compliance]             BIT     NOT NULL,
    [handling_process_id] INT           NULL,
    CONSTRAINT [SAMPLE_PK] PRIMARY KEY CLUSTERED ([sample_id] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_SAMPLE_PROCESS1] FOREIGN KEY ([handling_process_id]) REFERENCES [dbo].[PROCESS] ([process_id]),
    CONSTRAINT [FK_SAMPLE_PROCESS2] FOREIGN KEY ([collection_process_id]) REFERENCES [dbo].[PROCESS] ([process_id]),
    CONSTRAINT [FK_SAMPLE_SAMPLING_FEATURE] FOREIGN KEY ([sampling_feature_id]) REFERENCES [dbo].[SAMPLING_FEATURE] ([sampling_feature_id]), 
    CONSTRAINT [FK_SAMPLE_MEDIA] FOREIGN KEY ([media]) REFERENCES [MEDIA]([media]), 
    CONSTRAINT [FK_SAMPLE_SAMPLE_TYPE] FOREIGN KEY ([sample_type]) REFERENCES [SAMPLE_TYPE]([sample_type])
);

GO
EXECUTE sp_addextendedproperty @name = N'Description', @value = N'The SAMPLE table stores data for physical samples collected either in the field or composed from other samples (aggrigates or subsets).  This includes Trip Blanks, soil, water, algae, insect, fish or other physical samples.  Each SAMPLE is collected according to a single sampling PROTOCOL.  All SAMPLE records must have a SAMPLE_CODE, PROTOCOL_ID and a SAMPLING_FEATURE_ID.  There will be one record in the SAMPLING_FEATURE table for each SAMPLE record.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'SAMPLE';

GO

CREATE INDEX [IX_SAMPLE_handling_process_id] ON [dbo].[SAMPLE] ([handling_process_id])

GO

CREATE INDEX [IX_SAMPLE_collection_process_id] ON [dbo].[SAMPLE] ([collection_process_id])

GO

CREATE INDEX [IX_SAMPLE_sampling_feature_id] ON [dbo].[SAMPLE] ([sampling_feature_id])
