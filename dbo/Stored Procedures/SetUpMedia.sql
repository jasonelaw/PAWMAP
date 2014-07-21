CREATE PROCEDURE [dbo].[SetUpMedia]
AS
	SET NOCOUNT ON;

	MERGE INTO MEDIA AS [target]
	USING (VALUES
		('Air'), 
		('Biological'),
		('Habitat'),
		('Other'),
		('Sediment'),
		('Soil'),
		('Tissue'),
		('Water'),
		('Ambient Air'),
		('Borrow Soil, Waste Rock, and Protore material'),
		('Const. Material'),
		('Drinking Water'),
		('Dry Fall Material'),
		('Filter Residue'),
		('Finished Water'),
		('Groundwater'),
		('Indoor Air'),
		('Industrial Effluent'),
		('Industrial Waste'),
		('Interstitial Water'),
		('Lake Sediment'),
		('Leachate'),
		('Municipal Waste'),
		('Oil/Oily Sludge'),
		('Rainwater'),
		('Septic Effluent'),
		('Sieved Sediment'),
		('Sludge'),
		('Snowmelt'),
		('Soil Gas'),
		('Stormwater'),
		('Subsurface Soil/Sediment'),
		('Surface Soil/Sediment'),
		('Surface Water'),
		('UnSieved Sediment'),
		('Wastewater Treatment Plant Effluent'),
		('Wastewater Treatment Plant Influent'),
		('Wet Fall Material'),
		('Wipe')
		) AS [source]([media])
		ON target.media = source.media
	WHEN NOT MATCHED BY TARGET THEN 
		INSERT (media) VALUES (media) 
	WHEN NOT MATCHED BY SOURCE THEN 
		DELETE;
