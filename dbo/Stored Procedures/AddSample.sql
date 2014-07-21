CREATE PROCEDURE [dbo].[AddSample]
	@namespace VARCHAR(50),
	@identifier VARCHAR(50),
	@description VARCHAR(MAX),
	@media VARCHAR(50),
	@sample_type VARCHAR(100),
	@collection_date DATETIME,
	@collection_procedure VARCHAR(200),
	@sample_handling_procedure VARCHAR(200) = NULL,
	@laboratory_identifier VARCHAR(50),
	@is_qc BIT,
	@is_compliance BIT,
	@location_namespace VARCHAR(50) = NULL,
	@location_identifier VARCHAR(50) = NULL,
	@duplicate_identifier VARCHAR(50) = NULL,
	@trip_blank_identifier VARCHAR(50) = NULL,
	@composite_identifier VARCHAR(50) = NULL
AS
	SET NOCOUNT ON;
	SET XACT_ABORT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
			DECLARE @id [INT];
			DECLARE @procid [INT];
			DECLARE @handid [INT];

			SET @procid =	(SELECT TOP 1 process_id 
							 FROM PROCESS 
							 WHERE process_name = @collection_procedure);
			IF @sample_handling_procedure IS NOT NULL
				BEGIN
					SET @handid =	(SELECT TOP 1 process_id 
									 FROM PROCESS 
									 WHERE process_name = @sample_handling_procedure);
					IF @handid IS NULL
						RAISERROR('A matching process for @sample_handling_procedure (%s) was not found.', 11, 1, @sample_handling_procedure);
				END

			INSERT INTO [SAMPLING_FEATURE] (feature_namespace, feature_identifier, feature_type, feature_description) 
				VALUES (@namespace, @identifier, 'Sample', @description);
			SELECT @id = SCOPE_IDENTITY();
			INSERT INTO [SAMPLE] (sampling_feature_id, media, sample_type, collection_date, [collection_process_id], [handling_process_id], laboratory_identifier, is_qc, is_compliance) 
				VALUES (@id, @media, @sample_type, @collection_date, @procid, @handid, @laboratory_identifier, @is_qc, @is_compliance);
			IF @location_namespace IS NOT NULL AND @location_namespace IS NOT NULL
				EXEC AddSamplingFeatureRelation @location_namespace, @location_identifier, @namespace, @identifier, 'Location - Sample';
			IF @duplicate_identifier IS NOT NULL
				EXEC AddSamplingFeatureRelation @namespace, @identifier, @namespace, @duplicate_identifier, 'Sample - Field Duplicate';
			IF @trip_blank_identifier IS NOT NULL
				EXEC AddSamplingFeatureRelation @namespace, @identifier, @namespace, @trip_blank_identifier, 'Sample - Trip Blank';
			IF @composite_identifier IS NOT NULL
				EXEC AddSamplingFeatureRelation @namespace, @identifier, @namespace, @composite_identifier, 'Sample - Composite Sample';
		COMMIT TRANSACTION;
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
    		@ERROR_MESSAGE);
	END CATCH;