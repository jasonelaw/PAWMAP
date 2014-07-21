CREATE TABLE [dbo].[TAXON] (
    [taxon_id]                  INT           IDENTITY (1, 1) NOT NULL,
    [taxon_code]                VARCHAR (150)  NOT NULL,
    [bench_name]                VARCHAR (150) NOT NULL,
    [taxon_name]                VARCHAR (150) NOT NULL,
    [scientific_name]           VARCHAR (100) NOT NULL,
    [scientific_name_authority] VARCHAR (100) NULL,
    [itis_tsn]                  INT           NULL,
    [parent_itis_tsn]           INT           NULL,
    [taxon_level]               VARCHAR (50)  NULL,
    [phylum]                    VARCHAR (50)  NULL,
    [class]                     VARCHAR (50)  NULL,
    [order]                     VARCHAR (50)  NULL,
    [family]                    VARCHAR (50)  NULL,
    [genus]                     VARCHAR (50)  NULL,
    [species]                   VARCHAR (50)  NULL,
    [common_name]               VARCHAR (150) NULL,
    CONSTRAINT [TAXONOMY_PK] PRIMARY KEY CLUSTERED ([taxon_id] ASC) WITH (FILLFACTOR = 90), 
    CONSTRAINT [AK_TAXON_bench_name] UNIQUE ([bench_name]),
	CONSTRAINT [AK_TAXON_taxon_code] UNIQUE ([taxon_code])
);




GO
EXECUTE sp_addextendedproperty @name = N'Description', @value = N'The TAXON table stores the conrolled vocabulary for all taxa of biological organisms.  It can be used as a controlled vocabulary for validating values in biological data.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TAXON';

