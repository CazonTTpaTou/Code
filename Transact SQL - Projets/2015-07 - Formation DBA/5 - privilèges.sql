-- privilèges	

-- base [DB_GRAND_HOTEL]
-- donnez le privilège de lire les tables du schema S_PUB à tout utilisateur présent et à venir

-- nouvelle base...
-- Créez une nouvelle base de nom DB_COMMON et créez une table des codes postaux de la sorte :
CREATE TABLE T_CODE_POSTAL_CPL
(CPL_ID          INT IDENTITY PRIMARY KEY,
 CPL_OBOSLETE    DATE,
 CPL_CODE        CHAR(5) COLLATE French_BIN NOT NULL 
                 CHECK(CPL_CODE LIKE '[0-9][0-9AB][0-9][0-9][0-9]'),
 CPL_VILLE       VARCHAR(38) COLLATE French_BIN NOT NULL  
                 CHECK(CPL_VILLE = UPPER(CPL_VILLE)));
-- donnez la possibilité à tous de lire les données de cette table

-- donnez a lecteur le role de lecture, écrivain, le rôle d'écrivain
-- et admin le rôle admin, impex et secur


