CREATE PROCEDURE [dbo].[AddResultCategory]
	@code VARCHAR(50),
	@description VARCHAR(50),
	@scheme VARCHAR(50),
	@taxon VARCHAR(150) = NULL
AS
	BEGIN TRY
		BEGIN TRANSACTION
			SET NOCOUNT ON;
			SET XACT_ABORT ON;

			DECLARE 
				@scid INT,
				@tid  INT;
			SET @scid =	(SELECT TOP 1 [dbo].[CLASSIFICATION_SCHEME].[classification_scheme_id] 
							FROM [dbo].[CLASSIFICATION_SCHEME] 
							WHERE [dbo].[CLASSIFICATION_SCHEME].[scheme_name] = @scheme);
			IF @scid IS NULL
				RAISERROR('A matching classification scheme for @scheme (%s) was not found.', 11, 1, @scheme)
			IF @taxon IS NOT NULL
				BEGIN
					SET @tid =	(SELECT TOP 1 [dbo].[TAXON].[taxon_id] 
									FROM [dbo].[TAXON]
									WHERE [dbo].[TAXON].[taxon_code] = @taxon);
					IF @tid IS NULL
						RAISERROR('A matching taxon for @taxon (%s) was not found.', 11, 1, @taxon)
				END
			INSERT INTO	[dbo].[RESULT_CATEGORY]
				VALUES (@code, @description, @scid, @tid);
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

