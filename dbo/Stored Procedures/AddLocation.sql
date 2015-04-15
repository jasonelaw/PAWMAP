CREATE PROCEDURE [dbo].[AddLocation]
	@namespace  varchar(50),
	@identifier varchar(50),
	@description varchar(MAX),
	@name varchar(255),
	@sampled_feature_type varchar(50),
	@location_type varchar(50),
	@latitude float = NULL,
	@longitude float = NULL,
	@srid int,
	@wkt varchar(1000) = NULL,
	@ancestor_feature varchar(50) = NULL
AS
	SET NOCOUNT ON;
	SET XACT_ABORT ON;
	BEGIN TRY
		BEGIN TRANSACTION
			DECLARE @id [int];
			INSERT INTO [dbo].[SAMPLING_FEATURE] ([dbo].[SAMPLING_FEATURE].[feature_namespace], [dbo].[SAMPLING_FEATURE].[feature_identifier], [dbo].[SAMPLING_FEATURE].[feature_type], [dbo].[SAMPLING_FEATURE].[feature_description])
				VALUES (@namespace, @identifier, 'Location', @description);
			SELECT @id = SCOPE_IDENTITY();

			IF @latitude IS NOT NULL AND @longitude IS NOT NULL
				INSERT INTO [dbo].[LOCATION] ([dbo].[LOCATION].[sampling_feature_id], [dbo].[LOCATION].[location_name], [dbo].[LOCATION].[sampled_feature_type], [dbo].[LOCATION].[location_type], [dbo].[LOCATION].[geographic_feature]) 
					VALUES (@id, @name, @sampled_feature_type, @location_type, geography::Point(@latitude, @longitude, @srid));
			ELSE IF @wkt IS NOT NULL
				INSERT INTO [dbo].[LOCATION] ([dbo].[LOCATION].[sampling_feature_id], [dbo].[LOCATION].[location_name], [dbo].[LOCATION].[sampled_feature_type], [dbo].[LOCATION].[location_type], [dbo].[LOCATION].[geographic_feature]) 
					VALUES (@id, @name, @sampled_feature_type, @location_type, geography::STGeomFromText(@wkt, @srid));
			ELSE
				INSERT INTO [dbo].[LOCATION] ([dbo].[LOCATION].[sampling_feature_id], [dbo].[LOCATION].[location_name], [dbo].[LOCATION].[sampled_feature_type], [dbo].[LOCATION].[location_type]) 
					VALUES (@id, @name, @sampled_feature_type, @location_type);

			IF @ancestor_feature IS NOT NULL
				EXEC [dbo].[AddSamplingFeatureRelation] @namespace, @ancestor_feature, @namespace, @identifier, 'Parent Location - Sublocation'
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