-- privil�ges	

-- base [DB_GRAND_HOTEL]
-- donnez le privil�ge de lire les tables du schema S_PUB � tout utilisateur pr�sent et � venir

-- nouvelle base...
-- Cr�ez une nouvelle base de nom DB_COMMON et cr�ez une table des codes postaux de la sorte :
CREATE TABLE T_CODE_POSTAL_CPL
(CPL_ID          INT IDENTITY PRIMARY KEY,
 CPL_OBOSLETE    DATE,
 CPL_CODE        CHAR(5) COLLATE French_BIN NOT NULL 
                 CHECK(CPL_CODE LIKE '[0-9][0-9AB][0-9][0-9][0-9]'),
 CPL_VILLE       VARCHAR(38) COLLATE French_BIN NOT NULL  
                 CHECK(CPL_VILLE = UPPER(CPL_VILLE)));
-- donnez la possibilit� � tous de lire les donn�es de cette table

-- donnez a lecteur le role de lecture, �crivain, le r�le d'�crivain
-- et admin le r�le admin, impex et secur


