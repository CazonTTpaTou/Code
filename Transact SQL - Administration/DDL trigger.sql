DROP TRIGGER E_DDL_NOMMAGE 
ON DATABASE
GO

CREATE TRIGGER E_DDL_NOMMAGE
ON DATABASE
FOR CREATE_TABLE, ALTER_TABLE, CREATE_VIEW, ALTER_VIEW
AS
SET NOCOUNT ON;

DECLARE @EVENT XML, @TYPE sysname, @SCHEMA sysname, @NAME sysname;
SET @EVENT = EVENTDATA();
SELECT @TYPE =   @EVENT.value('(/EVENT_INSTANCE/ObjectType)[1]','sysname'),
	   @SCHEMA = @EVENT.value('(/EVENT_INSTANCE/SchemaName)[1]','sysname'),
	   @NAME =   @EVENT.value('(/EVENT_INSTANCE/ObjectName)[1]','sysname');

-- interdiction du schéma dbo :
IF @SCHEMA = 'dbo'
BEGIN
   ROLLBACK;
   RAISERROR('Aucun objet ne peut être créé dans le schéma dbo.', 16, 1)
END;

-- vérification du nommage de la table :
----------------------------------------

--> PHASE 0 : taille minimale 5
IF LEN(@NAME) < 5
BEGIN
   ROLLBACK;
   RAISERROR('Un nom de table ou de vue doit comporter au moins 5 caractères.', 16, 1)
END;

--> PHASE 1 : se composer uniquement de lettres (non diacritiques) en majuscule, de chiffres ou du blanc souligné
DECLARE @C NCHAR, @I TINYINT;
SET @I = 1
WHILE @I < LEN(@NAME)
BEGIN
   SET @C = SUBSTRING(@NAME, @I, 1);
   IF @C COLLATE French_BIN2 NOT BETWEEN 'A' AND 'Z'
   AND @C COLLATE French_BIN2 NOT BETWEEN '0' AND '1'
   AND @C <> '_' 
   BEGIN
	  ROLLBACK;
      RAISERROR('Un nom de table ou de vue doit utiliser les lettres non diacritiques en majuscule, des chiffres (sauf le premier) ou le blanc souligné.', 16, 1)
   END;
   SET @I = @I + 1
END;

--> PHASE 2 : commencer par T_ si c'est une table, V_si c'est une vue
--            se terminer par un trigramme précédé du blanc souligné
IF LEFT(@NAME, 2) <> CASE WHEN @TYPE = 'TABLE' THEN 'T_'
                         WHEN @TYPE = 'VIEW' THEN 'V_'
				    END
OR RIGHT(@NAME, 4) NOT LIKE '?_%' ESCAPE '?' --> un blanc souligné dans le 4e 
OR CHARINDEX('_', RIGHT(@NAME, 3)) <> 0  --> pas de blanc souligné dans les 3 derniers caractères
BEGIN
   ROLLBACK;
   RAISERROR('Un nom commencer par T_ pour une table ou V_ pour une vue et se terminer par un trigramme après un blanc souligné.', 16, 1)
END;

-- PHASE 3 : le trigramme doit être unique 
IF EXISTS(SELECT NULL   
          FROM   INFORMATION_SCHEMA.TABLES
		  WHERE  RIGHT(TABLE_NAME, 3) = RIGHT(@NAME, 3)
		  HAVING COUNT(*) > 1)
BEGIN
   ROLLBACK;
   RAISERROR('Le trigramme de l''objet (table ou vue) doit être unique au sein de la base.', 16, 1)
END;

GO