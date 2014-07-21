CREATE PROCEDURE [dbo].[AddSamplingFeatureRelation]
	@from_namespace VARCHAR(50),	
	@from_identifier VARCHAR(50),
	@to_namespace VARCHAR(50),
	@to_identifier VARCHAR(50),
	@relation_name VARCHAR(30)
AS
	SET NOCOUNT ON;
	SET XACT_ABORT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
			DECLARE @fid [INT];
			DECLARE @tid [INT];
			DECLARE @relid [INT];
			SET @fid =	(SELECT TOP 1 sampling_feature_id 
							FROM SAMPLING_FEATURE
							WHERE feature_namespace = @from_namespace AND feature_identifier = @from_identifier);
			SET @tid =	(SELECT TOP 1 sampling_feature_id 
							FROM SAMPLING_FEATURE
							WHERE feature_namespace = @to_namespace AND feature_identifier = @to_identifier);
			SET @relid =	(SELECT TOP 1 relationship_id
								FROM RELATIONSHIP
								WHERE relationship_name = @relation_name);
			IF @fid IS NULL
				RAISERROR('A matching sampling feature for (%s %s) was not found.', 11, 1, @from_namespace, @from_identifier)
			IF @tid IS NULL
				RAISERROR('A matching sampling feature for (%s %s) was not found.', 11, 1, @to_namespace, @to_identifier)
			IF @relid IS NULL
				RAISERROR('A relationship_id was not found for ''%s'' relation: make sure that the relation you''re attempting to use exists in the database.', 11, 1, @relation_name)
			INSERT INTO [SAMPLING_FEATURE_RELATION] ([from_sampling_feature_id], [to_sampling_feature_id], relationship_id) VALUES (@fid, @tid, @relid);
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
    		@ERROR_MESSAGE);
	END CATCH
