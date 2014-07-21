CREATE TABLE [dbo].[QUANTITY_RESULT]
(
	[quantity_result_id] INT NOT NULL PRIMARY KEY IDENTITY(1,1), 
    [result] FLOAT NOT NULL, 
    [unit_id] INT NOT NULL, 
    [qualifier] VARCHAR(30) NULL, 
    [observation_id] INT NOT NULL, 
    [phenomenon_id] INT NULL, 
    CONSTRAINT [FK_QUANTITY_RESULT_OBSERVATION] FOREIGN KEY ([observation_id]) REFERENCES [OBSERVATION]([observation_id]) ON DELETE CASCADE, 
    CONSTRAINT [FK_QUANTITY_RESULT_PHENOMENON] FOREIGN KEY ([phenomenon_id]) REFERENCES [PHENOMENON]([phenomenon_id]), 
    CONSTRAINT [FK_QUANTITY_RESULT_UNIT] FOREIGN KEY ([unit_id]) REFERENCES [UNIT]([unit_id]), 
    CONSTRAINT [AK_QUANTITY_RESULT_observation_id_phenomenon_id] UNIQUE ([observation_id],[phenomenon_id])
)

GO

CREATE INDEX [IX_QUANTITY_RESULT_phenomenon_id] ON [dbo].[QUANTITY_RESULT] ([phenomenon_id])

GO

CREATE INDEX [IX_QUANTITY_RESULT_unit_id] ON [dbo].[QUANTITY_RESULT] ([unit_id])
