CREATE TABLE [dbo].[COLLECTION] (
    [collection_id]          INT           IDENTITY (1, 1) NOT NULL,
    [collection_name]        VARCHAR (50) NOT NULL,
    [date_created]           DATETIME      DEFAULT (getdate()) NOT NULL,
    [collection_description] VARCHAR (255) NULL,
    [user] VARCHAR(30) NOT NULL DEFAULT (suser_sname()), 
    CONSTRAINT [PK_COLLECTION] PRIMARY KEY CLUSTERED ([collection_id] ASC) WITH (FILLFACTOR = 90), 
    CONSTRAINT [AK_COLLECTION_collection_name] UNIQUE ([collection_name],[user])
);

