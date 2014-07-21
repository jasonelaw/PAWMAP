CREATE TABLE [dbo].[OBSERVATION] (
    [observation_id]        INT              IDENTITY (1, 1) NOT NULL,
    sampling_feature_id   INT              NOT NULL,
    [phenomenon_id]     INT              NOT NULL,
    [process_id]          INT              NOT NULL,
    [phenomenon_time_start] DATETIME         NOT NULL,
    [phenomenon_time_end]   DATETIME         NOT NULL ,
    [observer]              VARCHAR (255)    NOT NULL,
	[observation_time]		DATETIME	NOT NULL,
    [observation_uuid]      UNIQUEIDENTIFIER NULL,
    [observation_comment]   VARCHAR (500)    NULL,
    [quality_control_level] VARCHAR (30)     NOT NULL,
    [observation_status] VARCHAR(20) NOT NULL, 
    [load_date] DATETIME NOT NULL, 
    [source_file] VARCHAR(128) NOT NULL, 
    CONSTRAINT [OBSERVATION_PK] PRIMARY KEY CLUSTERED ([observation_id] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_OBSERVATION_PHENOMENON] FOREIGN KEY ([phenomenon_id]) REFERENCES [dbo].[PHENOMENON] ([phenomenon_id]),
    CONSTRAINT [FK_OBSERVATION_PROCESS] FOREIGN KEY ([process_id]) REFERENCES [dbo].[PROCESS] ([process_id]),
    CONSTRAINT [FK_OBSERVATION_SAMPLING_FEATURE] FOREIGN KEY (sampling_feature_id) REFERENCES [dbo].[SAMPLING_FEATURE] ([sampling_feature_id]), 
    CONSTRAINT [FK_OBSERVATION_QUALITY_CONTROL_LEVEL] FOREIGN KEY ([quality_control_level]) REFERENCES [QUALITY_CONTROL_LEVEL]([quality_control_level]), 
    CONSTRAINT [FK_OBSERVATION_OBSERVATION_STATUS] FOREIGN KEY ([observation_status]) REFERENCES [OBSERVATION_STATUS]([observation_status])
);






GO
EXECUTE sp_addextendedproperty @name = N'Description', @value = N'An OBSERVATION is an execution of a single PROTOCOL, and is associated with a particular SAMPLING_FEATURE (representing either a LOCATION or a SAMPLE).  It is characterized using a single DOMAIN_CATEGORY and typically will have associated VALUES.  There may be multiple OBSERVATIONS at a given LOCATION or on a given SAMPLE.  ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'OBSERVATION';


GO

CREATE INDEX [IX_OBSERVATION_phenomenon_id] ON [dbo].[OBSERVATION] ([phenomenon_id])

GO

CREATE INDEX [IX_OBSERVATION_process_id] ON [dbo].[OBSERVATION] ([process_id])

GO

CREATE INDEX [IX_OBSERVATION_sampling_feature_id] ON [dbo].[OBSERVATION] ([sampling_feature_id])

GO


CREATE INDEX [IX_OBSERVATION_time] ON [dbo].[OBSERVATION] ([phenomenon_time_start],[phenomenon_time_end])
