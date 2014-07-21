CREATE TABLE [dbo].[RESULT_CATEGORY] (
    [result_category_id]    INT           IDENTITY (1, 1) NOT NULL,
    [category_code]         VARCHAR (150) NOT NULL,
    [category_description]  VARCHAR (300) NULL,
    [classification_scheme_id] INT           NOT NULL,
    [taxon_id]              INT           NULL,
    CONSTRAINT [PK_RESULT_CATEGORY] PRIMARY KEY CLUSTERED ([result_category_id] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_RESULT_CATEGORY_CLASSIFICATION_SCHEME] FOREIGN KEY ([classification_scheme_id]) REFERENCES [dbo].[CLASSIFICATION_SCHEME] ([classification_scheme_id]),
    CONSTRAINT [FK_RESULT_CATEGORY_TAXON] FOREIGN KEY ([taxon_id]) REFERENCES [dbo].[TAXON] ([taxon_id]), 
    CONSTRAINT [AK_RESULT_CATEGORY_category_code] UNIQUE ([classification_scheme_id], [category_code])
);





