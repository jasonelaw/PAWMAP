CREATE PROCEDURE [dbo].[AddTaxon]
	@taxon_code VARCHAR(150),
	@bench_name VARCHAR(150),
	@taxon_name VARCHAR(150),
	@scientific_name VARCHAR(100),
	@scientific_name_authority VARCHAR(100),
	@itis_tsn INT,
	@parent_itis_tsn INT,
	@taxon_level VARCHAR(50),
	@phylum VARCHAR(50),
	@class VARCHAR(50),
	@order VARCHAR(50),
	@family VARCHAR(50),
	@genus VARCHAR(50),
	@species VARCHAR(50),
	@common_name VARCHAR(150)
AS
	SET NOCOUNT ON;
	SET XACT_ABORT ON;
	INSERT INTO TAXON (taxon_code, bench_name, taxon_name, scientific_name, scientific_name_authority, itis_tsn, parent_itis_tsn, taxon_level, phylum, class, [order], family, genus, species, common_name)
		VALUES (@taxon_code, @bench_name, @taxon_name, @scientific_name, @scientific_name_authority, @itis_tsn, @parent_itis_tsn, @taxon_level, @phylum, @class, @order, @family, @genus, @species, @common_name);

