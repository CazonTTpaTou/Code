USE SQC_DB
GO

SELECT [Atelier],

 (select Max(v)
  FROM (VALUES ([Carton Num]),([Format]),([Embc Qte])) AS value(v)) AS [MaxDate]
FROM [dbo].[V_CARTON];
GO





