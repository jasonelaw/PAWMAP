CREATE TABLE [dbo].[RELATIONSHIP] (
    [relationship_id]          INT           IDENTITY (1, 1) NOT NULL,
    [relationship_name]        VARCHAR (30)  NOT NULL,
    [relationship_description] VARCHAR (500) NULL,
    CONSTRAINT [RELATIONSHIP_PK] PRIMARY KEY CLUSTERED ([relationship_id] ASC) WITH (FILLFACTOR = 90), 
    CONSTRAINT [AK_RELATIONSHIP_relationship_name] UNIQUE ([relationship_name])
);




GO
EXECUTE sp_addextendedproperty @name = N'Description', @value = N'The RELATIONSHIP table stores the relationship types which are available for defining relationships among LOCATIONs and SAMPLEs.  Examples include Trip Blank, Split Sample, Duplicate Sample, Child Location, etc.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'RELATIONSHIP';

