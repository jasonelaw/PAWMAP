CREATE TABLE [dbo].[OBSERVATION_COLLECTION] (
    [observation_collection_id] INT IDENTITY(1,1) NOT NULL,
    [collection_id]             INT NOT NULL,
    [observation_id]            INT NOT NULL,
    PRIMARY KEY CLUSTERED ([observation_collection_id] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_OBSERVATION_COLLECTION_COLLECTION] FOREIGN KEY ([collection_id]) REFERENCES [dbo].[COLLECTION] ([collection_id]),
    CONSTRAINT [FK_OBSERVATION_COLLECTION_OBSERVATION] FOREIGN KEY ([observation_id]) REFERENCES [dbo].[OBSERVATION] ([observation_id]),
    CONSTRAINT [AK_OBSERVATION_COLLECTION_collection_id_observation_id] UNIQUE ([collection_id],[observation_id])
);

