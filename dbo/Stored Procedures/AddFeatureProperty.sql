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
			SET @fid =	(SELECT	TOP 1 sampling_feature_id 
						 FROM	SAMPLING_FEATURE
						 WHERE	feature_namespace = @feature_namespace
							AND feature_identifier = @feature_identifier);
			SET @pid = (SELECT TOP 1 generic_property_id 
						FROM GENERIC_PROPERTY
						WHERE property_name = @property);
			INSERT INTO [FEATURE_PROPERTY] ([sampling_feature_id], [generic_property_id], property_value) VALUES (@fid, @pid, @value);
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
