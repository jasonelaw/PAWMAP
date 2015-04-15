CREATE TABLE [dbo].[PROCESS] (
    [process_id]          INT           IDENTITY (1, 1) NOT NULL,
    [process_name]        VARCHAR (200) NOT NULL,
    [process_description] VARCHAR (MAX) NULL,
    [method_version]      VARCHAR (30)  NULL,
    [method_code]         VARCHAR (50)  NOT NULL,
    [method_name]         VARCHAR (200) NOT NULL,
    [method_publisher]    VARCHAR (50)  NOT NULL,
    [instrument]          VARCHAR (100) NULL,
    [nemi_method_id]      VARCHAR (100) NULL,
    [process_type] VARCHAR(30) NOT NULL, 
    CONSTRAINT [PROTOCOL_PK] PRIMARY KEY CLUSTERED ([process_id] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [AK_PROCESS_process_name] UNIQUE NONCLUSTERED ([process_name] ASC) WITH (FILLFACTOR = 90), 
    CONSTRAINT [FK_PROCESS_PROCESS_TYPE] FOREIGN KEY ([process_type]) REFERENCES [PROCESS_TYPE]([process_type])
);






GO
EXECUTE sp_addextendedproperty @name = N'Description', @value = N'The PROTOCOL table stores data for protocols used for collecting samples and making measurements (both in the field and on samples).  All fields are required.  PROTOCOL records are referenced by SAMPLE and OBSERVATION records.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PROCESS';


GO

CREATE INDEX [IX_PROCESS_process_name] ON [dbo].[PROCESS] ([process_name])
