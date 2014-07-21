CREATE FUNCTION [dbo].[GetSamplesByCollectionProcedure]
(
	@name VARCHAR(200)
)
RETURNS TABLE AS RETURN
(
	SELECT	*
		FROM	V_SAMPLE AS vs
		WHERE	vs.sample_collection_procedure = @name
);
