CREATE PROCEDURE [dbo].[ListProcesses]
AS
	SET NOCOUNT ON;
	SELECT	[dbo].[PROCESS].[process_name], 
			[dbo].[PROCESS].[process_description], 
			[dbo].[PROCESS].[method_name], 
			[dbo].[PROCESS].[method_publisher], 
			[dbo].[PROCESS].[method_code], 
			[dbo].[PROCESS].[method_version], 
			[dbo].[PROCESS].[instrument], 
			[dbo].[PROCESS].[nemi_method_id], 
			[dbo].[PROCESS].[process_id]
		FROM [dbo].[PROCESS];