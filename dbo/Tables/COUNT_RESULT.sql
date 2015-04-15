CREATE TABLE [dbo].[COUNT_RESULT]
(
	[count_result_id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [result] INT NOT NULL, 
    [qualifier] VARCHAR(30) NULL, 
    [phenomenon_id] INT NULL, 
    [observation_id] INT NOT NULL, 
    CONSTRAINT [FK_COUNT_RESULT_PHENOMENON] FOREIGN KEY ([phenomenon_id]) REFERENCES [PHENOMENON]([phenomenon_id]), 
    CONSTRAINT [FK_COUNT_RESULT_OBSERVATION] FOREIGN KEY ([observation_id]) REFERENCES [OBSERVATION]([observation_id]) ON DELETE CASCADE, 
    CONSTRAINT [AK_COUNT_RESULT_observation_id_phenomenon_id] UNIQUE ([observation_id],[phenomenon_id])
)


GO

CREATE INDEX [IX_COUNT_RESULT_phenomenon_id] 
	ON [dbo].[COUNT_RESULT] ([phenomenon_id])
	WHERE [phenomenon_id] IS NOT NULL;
