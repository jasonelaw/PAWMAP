DELETE FROM OBSERVATION;
DELETE FROM COUNT_RESULT;
DELETE FROM SAMPLING_FEATURE_RELATION;
DELETE FROM FEATURE_PROPERTY;
DELETE FROM [dbo].[SAMPLE];
DELETE FROM LOCATION
DELETE FROM SAMPLING_FEATURE;
DELETE FROM PROCESS;
DELETE FROM GENERIC_PROPERTY;
DELETE FROM PHENOMENON;
DELETE FROM OBSERVATION;
-- Add test Locations
EXEC	[dbo].[AddLocation]
		@namespace = N'ABC',
		@identifier = N'123',
		@description = N'my description',
		@name = N'Site ABC 123',
		@sampled_feature_type = N'River/Stream',
		@location_type = N'Station',
		@latitude = 45.0,
		@longitude = 180.0,
		@srid = 4326

EXEC	[dbo].[AddLocation]
		@namespace = N'ABC',
		@identifier = N'124',
		@description = N'my description',
		@name = N'Site ABC 124',
		@sampled_feature_type = N'River/Stream',
		@location_type = N'Station',
		@latitude = 45.0,
		@longitude = 180.0,
		@srid = 4326,
		@ancestor_feature = N'123'

-- Add Processes
EXEC	[dbo].[AddProcess]
		@name = N'Collect grab sample',
		@description = N'Dip it',
		@method_name = N'Collect grab sample',
		@method_publisher = N'EPA',
		@method_code = N'123',
		@method_version = NULL,
		@instrument = NULL,
		@nemi_method_id = NULL,
		@process_type = N'Sample Collection'

EXEC	[dbo].[AddProcess]
		@name = N'Measure color',
		@description = N'With yes',
		@method_name = N'Measure color',
		@method_publisher = N'FO',
		@method_code = N'1.0',
		@method_version = NULL,
		@instrument = NULL,
		@nemi_method_id = NULL,
		@process_type = N'Observation'

EXEC	[dbo].[AddProcess]
		@name = N'Measure temp',
		@description = N'carefully',
		@method_name = N'Measure temp',
		@method_publisher = N'FO',
		@method_code = N'1.1',
		@method_version = NULL,
		@instrument = N'thermometer',
		@nemi_method_id = NULL,
		@process_type = N'Observation'

-- Add samples
EXEC	[dbo].[AddSample]
		@namespace = N'DEF',
		@identifier = N'001',
		@description = N'my description',
		@media = N'Water',
		@sample_type = N'Routine',
		@collection_date = N'2014-01-01 13:00:00',
		@collection_procedure = N'Collect grab sample',
		@laboratory_identifier = N'001',
		@is_qc = 0,
		@is_compliance = 1,
		@location_namespace = N'ABC',
		@location_identifier = N'124'

EXEC	[dbo].[AddSample]
		@namespace = N'DEF',
		@identifier = N'002',
		@description = N'my description',
		@media = N'Water',
		@sample_type = N'Routine',
		@collection_date = N'2014-01-01 13:00:00',
		@collection_procedure = N'Collect grab sample',
		@laboratory_identifier = N'001',
		@is_qc = 0,
		@is_compliance = 1,
		@location_namespace = N'ABC',
		@location_identifier = N'123'

-- Add Location properties
INSERT INTO GENERIC_PROPERTY VALUES (N'Hansen ID', N'An id for hansen')

EXEC	[dbo].[AddFeatureProperty]
		@feature_namespace = N'ABC',
		@feature_identifier = N'123',
		@property = N'Hansen ID',
		@value = N'ABC123'

EXEC	[dbo].[AddFeatureProperty]
		@feature_namespace = N'ABC',
		@feature_identifier = N'124',
		@property = N'Hansen ID',
		@value = N'ABC124'

-- Add a complex phenomena (color), a simple one (temperature), and a TimeSeries (temperature).
EXEC	[dbo].[AddPhenomenon]
		@code = N'color',
		@name = N'Color',
		@description = N'Color of something',
		@result_type = N'Complex'

EXEC	[dbo].[AddPhenomenon]
		@code = N'red',
		@name = N'Red',
		@description = N'Red part of color',
		@result_type = N'Count',
		@parent_phenomenon = N'color'

EXEC	[dbo].[AddPhenomenon]
		@code = N'blue',
		@name = N'Blue',
		@description = N'Blue part of color',
		@result_type = N'Count',
		@parent_phenomenon = N'color'

EXEC	[dbo].[AddPhenomenon]
		@code = N'green',
		@name = N'Green',
		@description = N'Green part of color',
		@result_type = N'Count',
		@parent_phenomenon = N'color'

EXEC	[dbo].[AddPhenomenon]
		@code = N'temp',
		@name = N'Temperature',
		@description = N'Temperature of something',
		@result_type = N'Quantity'

EXEC	[dbo].[AddPhenomenon]
		@code = N'temp2',
		@name = N'Temperature',
		@description = N'Temperature of something',
		@result_type = N'Time Series'

-- Add observations

DECLARE @sfid1	INT,
		@sfid2	INT,
		@sfid3	INT,
		@col	INT,
		@temp	INT,
		@colpr	INT,
		@temppr	INT;

SET @sfid1 = (SELECT TOP 1 sampling_feature_id FROM SAMPLING_FEATURE WHERE feature_identifier = N'123');
SET @sfid2 = (SELECT TOP 1 sampling_feature_id FROM SAMPLING_FEATURE WHERE feature_identifier = N'124');
SET @sfid3 = (SELECT TOP 1 sampling_feature_id FROM SAMPLING_FEATURE WHERE feature_identifier = N'001');
SET @col = (SELECT TOP 1 phenomenon_id FROM PHENOMENON WHERE phenomenon_code = N'color');
SET @temp = (SELECT TOP 1 phenomenon_id FROM PHENOMENON WHERE phenomenon_code = N'temp');
SET @colpr = (SELECT TOP 1 process_id FROM PROCESS WHERE process_name = N'Measure color');
SET @temppr = (SELECT TOP 1 process_id FROM PROCESS WHERE process_name = N'Measure temp');

INSERT INTO OBSERVATION 
	VALUES 
		(@sfid1, @col, @colpr, '2000-01-01 00:00', '2000-01-01 00:00', 'FO', '2000-01-01 00:00', Null, N'No comment', 'Raw Data', 'Preliminary', GETDATE() , 'None'),
		(@sfid1, @temp, @temppr, '2000-01-01 00:00', '2000-01-01 01:00', 'FO', '2000-01-01 01:00', Null, N'No comment', 'Raw Data', 'Preliminary', GETDATE() , 'None');

DECLARE @oid	INT,
		@red	INT,
		@blue	INT,
		@green	INT;
SET	@oid = (SELECT TOP 1 observation_id FROM OBSERVATION WHERE phenomenon_id = @col);
SET	@red = (SELECT TOP 1 phenomenon_id FROM PHENOMENON WHERE phenomenon_code = 'red');
SET	@blue = (SELECT TOP 1 phenomenon_id FROM PHENOMENON WHERE phenomenon_code = 'blue');
SET	@green = (SELECT TOP 1 phenomenon_id FROM PHENOMENON WHERE phenomenon_code = 'green');
INSERT INTO COUNT_RESULT 
	VALUES 
		(150, Null, @red, @oid),
		(150, Null, @blue, @oid),
		(150, Null, @green, @oid);


