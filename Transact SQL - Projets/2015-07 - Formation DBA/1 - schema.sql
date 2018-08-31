-- jouer avec les schemas

-- Créez un nouveau schema de nom S_PUB (pour public).

-- Transférez les tables [dbo].[DUAL] et [dbo].[T_NUM] dans ce nouveau schema

-- Créez un nouveau schema de nom S_ADM (pour adminsitration)
-- composé d'une table de nom T_USER_USR définie comme suit :
(PRS_ID          INT PRIMARY KEY REFERENCES S_PRS.T_PERSONNE_PHYSIQUE_PSP (PRS_ID),
 USR_ALIAS       NVARCHAR(16) NOT NULL,
 USR_PASSWORD    NVARCHAR(16) COLLATE French_BIN,
 USR_CREATE_DATE DATETIME2 DEFAULT GETDATE(),
 USR_LAST_LOGIN  DATETIME2);
 -- et d'une vue (V_USR) synthétisant les informations des tables USR et PSP
