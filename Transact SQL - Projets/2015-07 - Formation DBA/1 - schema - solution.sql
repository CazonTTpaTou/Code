-- jouer avec les schemas

-- Créez un nouveau schema de nom S_PUB (pour les objets qui serviront à tous le monde).

USE DB_GRAND_HOTEL;
GO
CREATE SCHEMA S_PUB;
GO

-- Transférez les tables [dbo].[DUAL] et [dbo].[T_NUM] dans ce nouveau schema

ALTER SCHEMA S_PUB TRANSFER [dbo].[DUAL];
GO
ALTER SCHEMA S_PUB TRANSFER [dbo].[T_NUM];
GO

-- Créez un nouveau schema de nom S_ADM (pour adminsitration)
-- composé d'une table de nom T_USER_USR définie comme suit :
CREATE SCHEMA S_ADM
	CREATE VIEW V_USR
	AS
	SELECT PP.*, USR_ALIAS, USR_PASSWORD, USR_CREATE_DATE, USR_LAST_LOGIN
	FROM   T_USER_USR AS U
		   JOIN S_PRS.T_PERSONNE_PHYSIQUE_PSP AS PP
				ON U.PRS_ID = PP.PRS_ID
	CREATE TABLE T_USER_USR 
	(PRS_ID          INT PRIMARY KEY REFERENCES S_PRS.T_PERSONNE_PHYSIQUE_PSP (PRS_ID),
	 USR_ALIAS       NVARCHAR(16) NOT NULL,
	 USR_PASSWORD    NVARCHAR(16) COLLATE French_BIN,
	 USR_CREATE_DATE DATETIME2 DEFAULT GETDATE(),
	 USR_LAST_LOGIN  DATETIME2);
 -- et d'une vue (V_USR) synthétisant les informations des tables USR et PSP
