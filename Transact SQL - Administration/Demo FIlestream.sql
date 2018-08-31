CREATE DATABASE DB_GED;
GO

USE DB_GED;
GO

-- ajout d'un "storage" FILESTREAM
ALTER  DATABASE DB_GED
   ADD FILEGROUP FG_FS_GED
       CONTAINS FILESTREAM;
GO

-- création d'un répertoire comme point d'entrée du stockage FS
EXEC xp_cmdshell 'MKDIR "C:\FILESTREAM\GED"';
GO

-- création du REPERTOIRE FS pour la base 
ALTER DATABASE DB_GED
   ADD FILE
	   (NAME     = 'F_FS_GED',
	    FILENAME = 'C:\FILESTREAM\GED\DIR_GED')
   TO FILEGROUP FG_FS_GED;
GO

-- création de la table 
CREATE TABLE dbo.T_GED
(GED_ID          INT IDENTITY PRIMARY KEY,
 GED_NAME        VARCHAR(128) NOT NULL,
 GED_DESC        VARCHAR(1024),
 GED_TYPE        CHAR(16) NOT NULL CHECK(GED_TYPE IN ('doc', 'ppt', 'pdf', 'jpg')),
 GED_UID         UNIQUEIDENTIFIER DEFAULT NEWID() ROWGUIDCOL UNIQUE NOT NULL,
 GED_DATA        VARBINARY(max) FILESTREAM
 ) 

 ON [PRIMARY]
    FILESTREAM_ON FG_FS_GED;
GO

--test :
INSERT INTO dbo.T_GED (GED_NAME, GED_TYPE, GED_DATA)
SELECT 'IP ORSYS', 'jpg', BulkColumn
FROM   OPENROWSET(BULK N'C:\! FB\IP ORSYS.jpg', SINGLE_BLOB) AS F

-- résultat
SELECT * FROM dbo.T_GED;

-- rajout du chemin vers le fichier interprétable uniquement via .net
SELECT *, GED_DATA.PathName() AS PATH_TO_FILE_AS_FS
FROM   dbo.T_GED;





