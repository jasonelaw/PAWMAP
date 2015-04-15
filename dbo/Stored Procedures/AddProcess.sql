CREATE PROCEDURE [dbo].[AddProcess]
	@name VARCHAR(200),
	@description VARCHAR(MAX) = NULL,
	@method_name VARCHAR(200),
	@method_publisher VARCHAR(50),
	@method_code VARCHAR(50),
	@method_version VARCHAR(30),
	@instrument VARCHAR(100) = NULL,
	@nemi_method_id VARCHAR(100) = NULL,
	@process_type VARCHAR(30)
AS
	SET NOCOUNT ON;
	INSERT INTO [dbo].[PROCESS]
		(
			[dbo].[PROCESS].[process_name], 
			[dbo].[PROCESS].[process_description], 
			[dbo].[PROCESS].[method_name], 
			[dbo].[PROCESS].[method_publisher], 
			[dbo].[PROCESS].[method_code], 
			[dbo].[PROCESS].[method_version], 
			[dbo].[PROCESS].[instrument], 
			[dbo].[PROCESS].[nemi_method_id], 
			[dbo].[PROCESS].[process_type]
		) 
		VALUES 
			(
				@name, 
				@description, 
				@method_name,
				@method_publisher,
				@method_code,
				@method_version, 
				@instrument, 
				@nemi_method_id, 
				@process_type
			);