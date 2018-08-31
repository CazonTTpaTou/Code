-- créer une fonction qui nettoie les caractères autres que les chiffres et remplace le + par 00
CREATE FUNCTION F_CLEAN_TEL (@NUMERO VARCHAR(32)
RETURNS VARCHAR(32)
AS
BEGIN

END;
GO

CREATE TABLE T_TEL
(TEL_ID     INT IDENTITY PRIMARY KEY,
 TEL_NUM    VARCHAR(30))
GO

-- créer le déclencheur
CREATE TRIGGER E_IU_TEL
ON T_TEL
FOR INSERT, UPDATE
AS
SET NOCOUNT ON;
...

GO

-- test :
INSERT INTO T_TEL VALUES
('67.98.45.33.89'), ('+33 6 45 67 89 34'), ('06-56-34-23-12');
