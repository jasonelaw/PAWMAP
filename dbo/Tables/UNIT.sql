CREATE TABLE [dbo].[UNIT] (
    [unit_id]          INT           IDENTITY (1, 1) NOT NULL,
    [unit_print]       NVARCHAR(30) NOT NULL,
    [unit_description] VARCHAR (255) NULL,
    [unit_ucum]        VARCHAR (30)  NULL,
    CONSTRAINT [PK_UNIT] PRIMARY KEY CLUSTERED ([unit_id] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [AK_UNIT_unit_print] UNIQUE NONCLUSTERED ([unit_print] ASC) WITH (FILLFACTOR = 90)
);






GO
EXECUTE sp_addextendedproperty @name = N'Description', @value = N'The UNIT table stores information about measurement units, including their name and abreviation.  UNIT records are referenced by VALUE records.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UNIT';

