CREATE TABLE [dbo].[COMPLEX_PHENOMENA]
(
	[parent_phenomena] INT NOT NULL , 
    [child_phenomena] INT NOT NULL, 
    PRIMARY KEY ([parent_phenomena],[child_phenomena])
)
