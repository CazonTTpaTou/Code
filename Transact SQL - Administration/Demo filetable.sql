CREATE DATABASE DB_FILES;
GO

-- cr�ation d'un r�pertoire comme point d'entr�e du stockage FS
EXEC xp_cmdshell 'MKDIR "C:\FILETABLE\"';
GO

-- ajout d'un groupe de fichier FILESTREAM
ALTER DATABASE DB_FILES
   ADD FILEGROUP FG_FT 
   CONTAINS FILESTREAM;
GO

-- ajout d'un point d'entr�e du FILESTREAM (FG)
ALTER DATABASE DB_FILES
   ADD FILE
      (NAME = FS_FT_FILES,
       FILENAME='C:\FILETABLE\')
TO FILEGROUP FG_FT;

-- modification de l'�tat du FILESTREAM pour les FILETABLE
ALTER DATABASE DB_FILES
SET FILESTREAM (NON_TRANSACTED_ACCESS = FULL,
                DIRECTORY_NAME = N'FILES');
GO

USE DB_FILES;
GO

-- cr�ation d'une table de type FILETABLE
CREATE TABLE T_FIL AS FileTable
    WITH ( 
          FileTable_Directory = 'FILES',
          FileTable_Collate_Filename = French_CI_AS
         );
GO

-- contenur de la table apr�s avoir ajouter des fichiers dans le r�pertoire 
-- via l'explorateur WINDOWS
SELECT * 
FROM   T_FIL;

-- insertion d'un fichier en racine
INSERT INTO dbo.T_FIL(name, file_stream)
SELECT 'Note.txt', CAST('le petit chat est mort' AS VARBINARY(max));

-- insertion d'un r�pertoire
INSERT INTO dbo.T_FIL(name, is_directory)
SELECT 'Mon Rep', 1;


-- insertion d'un fichier dans un r�pertoire particulier
DECLARE @path        HIERARCHYID; --> r�cup�ration du chemin binaire du r�pertoire
DECLARE @new_path    VARCHAR(675);--> calcul du nouveau chemin pour le fichier relatif au chemin du r�pertoire consid�r�

-- on r�cup�re le chemin du rep
SELECT @path = path_locator
FROM   dbo.T_FIL
WHERE  name = 'Mon Rep';

-- on calcul le nouveau chemin du fichier
SELECT @new_path = @path.ToString()     +
	CONVERT(VARCHAR(20), CONVERT(BIGINT, SUBSTRING(CONVERT(BINARY(16), NEWID()), 1, 6))) + '.' +
	CONVERT(VARCHAR(20), CONVERT(BIGINT, SUBSTRING(CONVERT(BINARY(16), NEWID()), 7, 6))) + '.' +
	CONVERT(VARCHAR(20), CONVERT(BIGINT, SUBSTRING(CONVERT(BINARY(16), NEWID()), 13, 4))) + '/';
	 
-- insertion du fichier
INSERT INTO dbo.T_FIL(name, file_stream, path_locator)
SELECT 'Notes2.txt', CAST('Les sanglots desviolons de l''automne, 
bercent mon coeur d''une langeur monotone' AS VARBINARY(max)), @new_path;

