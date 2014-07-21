CREATE TABLE [dbo].[PHENOMENON] (
    [phenomenon_id]          INT IDENTITY(1,1)            NOT NULL,
    [phenomenon_code]        VARCHAR (50)   NOT NULL,
    [phenomenon_name]        VARCHAR (100)  NOT NULL,
    [phenomenon_description] VARCHAR (1000) NULL,
    [component]              VARCHAR (200)  NULL,
    [quantity]               VARCHAR (100)  NULL,
    [state]                  VARCHAR (100)  NULL,
    [medium]                 VARCHAR (100)  NULL,
    [representation]         VARCHAR (100)  NULL,
    [parent_phenomenon_id]      INT            NULL,
    [result_type] VARCHAR(30) NOT NULL, 
    [classification_scheme_id] INT NULL, 
    CONSTRAINT [PK_PHENOMENON] PRIMARY KEY CLUSTERED ([phenomenon_id] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_PHENOMENON_PHENOMENON] FOREIGN KEY ([parent_phenomenon_id]) REFERENCES [dbo].[PHENOMENON] ([phenomenon_id]),
    CONSTRAINT [AK_PHENOMENON_phenomenon_code] UNIQUE NONCLUSTERED ([phenomenon_code] ASC) WITH (FILLFACTOR = 90), 
    CONSTRAINT [FK_PHENOMENON_CLASSIFICATION_SCHEME] FOREIGN KEY ([classification_scheme_id]) REFERENCES [CLASSIFICATION_SCHEME]([classification_scheme_id]), 
    CONSTRAINT [FK_PHENOMENON_RESULT_TYPE] FOREIGN KEY ([result_type]) REFERENCES [RESULT_TYPE]([result_type])
);


GO
EXECUTE sp_addextendedproperty @name = N'Description', @value = N'DOMAIN_CATEGORY stores the controlled vocabulary for OBSERVATIONS and VALUES in a single table.  The CODE is a short name while the NAME is a longer name.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PHENOMENON';


GO

CREATE INDEX [IX_PHENOMENON_phenomenon_code] 
	ON [dbo].[PHENOMENON] ([phenomenon_code])
	INCLUDE (phenomenon_name,result_type)

GO

CREATE INDEX [IX_PHENOMENON_phenomenon_name] 
	ON [dbo].[PHENOMENON] ([phenomenon_name])
	INCLUDE (phenomenon_code,result_type)
