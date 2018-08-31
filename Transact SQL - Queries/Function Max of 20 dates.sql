CREATE FUNCTION GetMaxOfDates20 (
@value01 DateTime = NULL,  
@value02 DateTime = NULL,
@value03 DateTime = NULL,
@value04 DateTime = NULL,
@value05 DateTime = NULL,
@value06 DateTime = NULL,
@value07 DateTime = NULL,
@value08 DateTime = NULL,
@value09 DateTime = NULL,
@value10 DateTime = NULL,
@value11 DateTime = NULL,
@value12 DateTime = NULL,
@value13 DateTime = NULL,
@value14 DateTime = NULL,
@value15 DateTime = NULL,
@value16 DateTime = NULL,
@value17 DateTime = NULL,
@value18 DateTime = NULL,
@value19 DateTime = NULL,
@value20 DateTime = NULL
)
RETURNS DateTime
AS
BEGIN
RETURN (
SELECT TOP 1 value
FROM (
SELECT @value01 AS value UNION ALL
SELECT @value02 UNION ALL
SELECT @value03 UNION ALL
SELECT @value04 UNION ALL
SELECT @value05 UNION ALL
SELECT @value06 UNION ALL
SELECT @value07 UNION ALL
SELECT @value08 UNION ALL
SELECT @value09 UNION ALL
SELECT @value10 UNION ALL
SELECT @value11 UNION ALL
SELECT @value12 UNION ALL
SELECT @value13 UNION ALL
SELECT @value14 UNION ALL
SELECT @value15 UNION ALL
SELECT @value16 UNION ALL
SELECT @value17 UNION ALL
SELECT @value18 UNION ALL
SELECT @value19 UNION ALL
SELECT @value20 
) AS [values]
ORDER BY value DESC    
)
END --FUNCTION
GO

