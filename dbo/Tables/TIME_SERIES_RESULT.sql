CREATE TABLE [dbo].[TIME_SERIES_RESULT]
(
	[time_series_result_id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [result_time_utc] DATETIME NOT NULL, 
	[result_time_local] DATETIME NOT NULL,
	[result_time_local_offset] VARCHAR(6) NOT NULL,
    [result] FLOAT NOT NULL, 
	[unit_id] INT NOT NULL,
    [qualifier] VARCHAR(30) NULL, 
    [observation_id] INT NOT NULL, 
    CONSTRAINT [FK_TIME_SERIES_RESULT_OBSERVATION] FOREIGN KEY ([observation_id]) REFERENCES [OBSERVATION]([observation_id]) ON DELETE CASCADE, 
    CONSTRAINT [FK_TIME_SERIES_RESULT_UNIT] FOREIGN KEY ([unit_id]) REFERENCES [UNIT]([unit_id]), 
    CONSTRAINT [AK_TIME_SERIES_RESULT_observation_id_result_time_utc] UNIQUE ([observation_id],[result_time_utc])
)

GO

CREATE INDEX [IX_TIME_SERIES_RESULT_observation_id] ON [dbo].[TIME_SERIES_RESULT] ([observation_id])
