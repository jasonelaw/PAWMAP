CREATE TABLE [dbo].[GENERIC_PROPERTY] (
    [generic_property_id]  INT           IDENTITY (1, 1) NOT NULL,
    [property_name]        VARCHAR (50)  NOT NULL,
    [property_description] VARCHAR (MAX) NOT NULL,
    CONSTRAINT [PK_GENERIC_PROPERTY] PRIMARY KEY CLUSTERED ([generic_property_id] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [AK_GENERIC_PROPERTY_property_name] UNIQUE NONCLUSTERED ([property_name] ASC) WITH (FILLFACTOR = 90)
);



