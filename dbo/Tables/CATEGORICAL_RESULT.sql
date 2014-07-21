CREATE TABLE [dbo].[CATEGORICAL_RESULT]
(
	[category_result_id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [result_category_id] INT NOT NULL, 
    [qualifier] VARCHAR(30) NULL, 
    [observation_id] INT NOT NULL, 
    [phenomenon_id] INT NULL, 
    CONSTRAINT [FK_CATEGORY_RESULT_OBSERVATION] FOREIGN KEY ([observation_id]) REFERENCES [OBSERVATION]([observation_id]) ON DELETE CASCADE, 
    CONSTRAINT [FK_CATEGORY_RESULT_PHENOMENON] FOREIGN KEY ([phenomenon_id]) REFERENCES [PHENOMENON]([phenomenon_id]), 
    CONSTRAINT [FK_CATEGORICAL_RESULT_RESULT_CATEGORY] FOREIGN KEY ([result_category_id]) REFERENCES [RESULT_CATEGORY]([result_category_id]), 
    CONSTRAINT [AK_CATEGORICAL_RESULT_observation_id_phenomenon_id] UNIQUE ([observation_id],[phenomenon_id])
)

GO


CREATE INDEX [IX_CATEGORICAL_RESULT_phenomenon_id] ON [dbo].[CATEGORICAL_RESULT] ([phenomenon_id])

GO

CREATE INDEX [IX_CATEGORICAL_RESULT_result_category_id] ON [dbo].[CATEGORICAL_RESULT] ([result_category_id])
