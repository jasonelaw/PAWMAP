CREATE TABLE [dbo].[CLASSIFICATION_SCHEME] (
    [classification_scheme_id] INT          IDENTITY (1, 1) NOT NULL,
    [scheme_name]              VARCHAR (50) NOT NULL,
    CONSTRAINT [PK_CLASSIFICATION_SCHEME] PRIMARY KEY CLUSTERED ([classification_scheme_id] ASC) WITH (FILLFACTOR = 90), 
    CONSTRAINT [AK_CLASSIFICATION_SCHEME_scheme_name] UNIQUE ([scheme_name])
);



