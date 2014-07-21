CREATE PROCEDURE [dbo].[ListPhenomena]
AS
	BEGIN
		SET NOCOUNT ON;
		SELECT	[dbo].[PHENOMENON].[phenomenon_code], 
				[dbo].[PHENOMENON].[phenomenon_name], 
				[dbo].[PHENOMENON].[phenomenon_description], 
				[dbo].[PHENOMENON].[quantity], 
				[dbo].[PHENOMENON].[state], 
				[dbo].[PHENOMENON].[component], 
				[dbo].[PHENOMENON].[medium], 
				[dbo].[PHENOMENON].[representation], 
				[dbo].[PHENOMENON].[phenomenon_id], 
				[dbo].[PHENOMENON].[parent_phenomenon_id], 
				[dbo].[PHENOMENON].[result_type],
				[dbo].[PHENOMENON].[classification_scheme_id]
			FROM [dbo].[PHENOMENON];
	END