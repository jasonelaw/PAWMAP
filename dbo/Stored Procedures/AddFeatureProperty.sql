CREATE PROCEDURE [dbo].[AddFeatureProperty]
	@feature_namespace VARCHAR(50),
	@feature_identifier VARCHAR(50),
	@property VARCHAR(50),
	@value VARCHAR(200)
AS
	SET XACT_ABORT ON;
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION
			DECLARE @fid [int];
			DECLARE @pid [int];
			SET @fid =	(SELECT	TOP 1 [dbo].[SAMPLING_FEATURE].[sampling_feature_id] 
						 FROM	[dbo].[SAMPLING_FEATURE]
						 WHERE	[dbo].[SAMPLING_FEATURE].[feature_namespace] = @feature_namespace
							AND [dbo].[SAMPLING_FEATURE].[feature_identifier] = @feature_identifier);
			SET @pid = (SELECT TOP 1 [dbo].[GENERIC_PROPERTY].[generic_property_id] 
						FROM [dbo].[GENERIC_PROPERTY]
						WHERE [dbo].[GENERIC_PROPERTY].[property_name] = @property);
			INSERT INTO [dbo].[FEATURE_PROPERTY] ([dbo].[FEATURE_PROPERTY].[sampling_feature_id], [dbo].[FEATURE_PROPERTY].[generic_property_id], [dbo].[FEATURE_PROPERTY].[property_value]) VALUES (@fid, @pid, @value);
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
    		ROLLBACK TRANSACTION;

		DECLARE
    		@ERROR_SEVERITY INT,
    		@ERROR_STATE	INT,
    		@ERROR_NUMBER	INT,
    		@ERROR_LINE		INT,
    		@ERROR_MESSAGE	NVARCHAR(4000);

		SELECT
    		@ERROR_SEVERITY = ERROR_SEVERITY(),
    		@ERROR_STATE	= ERROR_STATE(),
    		@ERROR_NUMBER	= ERROR_NUMBER(),
    		@ERROR_LINE		= ERROR_LINE(),
    		@ERROR_MESSAGE	= ERROR_MESSAGE();

		RAISERROR('Msg %d, Line %d, :%s',
    		@ERROR_SEVERITY,
    		@ERROR_STATE,
    		@ERROR_NUMBER,
    		@ERROR_LINE,
    		@ERROR_MESSAGE);;
	END CATCH
