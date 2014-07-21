/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

EXEC	[dbo].[SetUpResultTypes]
EXEC	[dbo].[SetUpMedia]
EXEC	[dbo].[SetUpSampleType]  
EXEC	[dbo].[SetUpLocationType]
EXEC	[dbo].[SetUpSampledFeatureType]
EXEC	[dbo].[SetUpQualityControlLevel]
EXEC	[dbo].[SetUpRelationship]
EXEC	[dbo].[SetUpStatus]
EXEC	[dbo].[SetUpQualityControlLevel]
EXEC	[dbo].[SetUpRelationship]
EXEC	[dbo].[SetUpProcessType]

