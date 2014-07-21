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
	INSERT INTO PROCESS (process_name, process_description, method_name, method_publisher, method_code, method_version, instrument, nemi_method_id, process_type) 
		VALUES (@name, @description, @method_name, @method_publisher, @method_code, @method_version, @instrument, @nemi_method_id, @process_type);