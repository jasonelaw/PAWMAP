CREATE PROCEDURE [dbo].[AddPhenomenon]
	@code VARCHAR(50),
	@name VARCHAR(100),
	@description VARCHAR(1000),
	@quantity VARCHAR(100) = NULL,
	@component VARCHAR(200) = NULL,
	@state VARCHAR(1000) = NULL,
	@medium VARCHAR(1000) = NULL,
	@representation VARCHAR(1000) = NULL,
	@parent_phenomenon VARCHAR(50) = NULL,
	@result_type VARCHAR(30),
	@classification_scheme VARCHAR(50) = NULL
AS
	SET NOCOUNT ON;
	SET XACT_ABORT ON;
	BEGIN TRY
		BEGIN TRANSACTION
			DECLARE
				@pid [INT],
				@scid [INT];
			IF @parent_phenomenon IS NOT NULL
				BEGIN
					SET @pid =	(SELECT TOP 1 [dbo].[PHENOMENON].[phenomenon_id]
								 FROM [dbo].[PHENOMENON]
								 WHERE [dbo].[PHENOMENON].[phenomenon_code] = @parent_phenomenon);
					IF @pid IS NULL
						RAISERROR('A matching phenomenon for parent phenomenon code (%s) was not found.', 11, 1, @parent_phenomenon)
				END
			IF @classification_scheme IS NOT NULL
				BEGIN
					SET @scid =	(SELECT TOP 1 [dbo].[CLASSIFICATION_SCHEME].[classification_scheme_id] 
								 FROM [dbo].[CLASSIFICATION_SCHEME]
								 WHERE [dbo].[CLASSIFICATION_SCHEME].[scheme_name] = @classification_scheme);
					IF @scid IS NULL
						RAISERROR('A matching classification scheme for (%s) was not found.', 11, 1, @classification_scheme)
				END
			INSERT INTO [dbo].[PHENOMENON] 
				(
					[dbo].[PHENOMENON].[phenomenon_code],
					[dbo].[PHENOMENON].[phenomenon_name],
					[dbo].[PHENOMENON].[phenomenon_description],
					[dbo].[PHENOMENON].[quantity],
					[dbo].[PHENOMENON].[component],
					[dbo].[PHENOMENON].[state],
					[dbo].[PHENOMENON].[medium],
					[dbo].[PHENOMENON].[representation],
					[dbo].[PHENOMENON].[parent_phenomenon_id],
					[dbo].[PHENOMENON].[result_type], 
					[dbo].[PHENOMENON].[classification_scheme_id]
				) 
				VALUES (@code, @name, @description, @quantity, @component, @state, @medium, @representation, @pid, @result_type, @scid);
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
