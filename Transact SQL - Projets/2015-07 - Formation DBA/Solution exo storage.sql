-- restaurer la base DB_GRAND_HOTEL par l'IHM

-- cr�er deux storages (FG_DATA et FG_INDX)
ALTER DATABASE DB_GRAND_HOTEL
   ADD FILEGROUP FG_DATA;

ALTER DATABASE DB_GRAND_HOTEL
   ADD FILEGROUP FG_INDEX;

-- dans le storage FG_DATA cr�er deux fichiers de 1 Go, pas de croissance 50 Mo
ALTER DATABASE DB_GRAND_HOTEL
   ADD FILE
      (NAME       = 'F_DATA1',
	   FILENAME   = 'C:\DB_HOTEL\DATA\F_HOTEL_DATA1.tartemuche',
	   SIZE       = 1 GB,
	   FILEGROWTH = 50 MB
	  ),
	  (NAME       = 'F_DATA2',
	   FILENAME   = 'C:\DB_HOTEL\DATA\F_HOTEL_DATA2.tartemuche',
	   SIZE       = 1 GB,
	   FILEGROWTH = 50 MB
	  ) TO FILEGROUP FG_DATA;

-- dans le storage FG_INDX cr�er un fichier de 1 Go, pas de croissance 50 Mo
ALTER DATABASE DB_GRAND_HOTEL
   ADD FILE
      (NAME       = 'F_INDX1',
	   FILENAME   = 'C:\DB_HOTEL\DATA\F_HOTEL_INDX1.tartemuche',
	   SIZE       = 1 GB,
	   FILEGROWTH = 50 MB
	  ) TO FILEGROUP FG_INDX;

-- faites en sorte que le storage par d�faut soit FG_DATA
ALTER DATABASE DB_GRAND_HOTEL
   MODIFY FILEGROUP FG_DATA DEFAULT;

-- dimensionnez le journal de transaction � 1 Go et pas de croissance de 50 Mo
ALTER DATABASE DB_GRAND_HOTEL
   MODIFY FILE (NAME = 'DB_GRAND_HOTEL_log',
                SIZE = 1 GB,
				FILEGROWTH = 50 MB);

-- d�placez les tables dans FG_DATA et les index dans FG_INDEX � l'aide de la requ�te fournie

--> OK

-- r�duisez le fichier primaire � 2 Mo

SELECT * FROM sys.database_files

USE DB_GRAND_HOTEL;
DBCC SHRINKFILE ('DB_GRAND_HOTEL', 2);

---------------------------------------------------------------------------------------------

-- modification de structure de la base tempdb

-- notez les emplacements des fichiers 

SELECT * FROM tempdb.sys.database_files

/*
C:\tempdb\DATA\data_temp.mdf
C:\SQL Server\2012F\MSSQL11.SQL2012FBIN2\MSSQL\DATA\templog.ldf
*/

-- cr�er deux r�pertoires : C:\tempdb\DATA et C:\tempdb\TRAN
EXEC xp_cmdshell 'MKDIR "C:\tempdb\DATA"';
EXEC xp_cmdshell 'MKDIR "C:\tempdb\TRAN"';

-- d�placer le JT de tempdb vers le r�pertoire C:\tempdb\TRAN 
-- et redimensionnez le � 500 Mo avec pas de croissance � 25 Mo
ALTER DATABASE tempdb 
   MODIFY FILE (NAME = 'templog', 
                FILENAME = 'C:\tempdb\TRAN\tran_temp.ldf',
				SIZE = 500 MB,
				FILEGROWTH = 25 MB);

-- d�placer le fichier de donn�es de tempdb vers le r�pertoire C:\tempdb\DATA 
-- et redimensionnez le � 500 Mo avec pas de croissance � 25 Mo
ALTER DATABASE tempdb 
   MODIFY FILE (NAME = 'tempdev', 
                FILENAME = 'C:\tempdb\DATA\data_temp.mdf',
				SIZE = 500 MB,
				FILEGROWTH = 25 MB);

-- red�marrez le service SQL Server

SHUTDOWN;
--> red�marrer manuellement !

-- supprimez les fichiers obsol�tes

EXEC xp_cmdshell 'DEL "C:\tempdb\DATA\data_temp.mdf"';
EXEC xp_cmdshell 'DEL "C:\SQL Server\2012F\MSSQL11.SQL2012FBIN2\MSSQL\DATA\templog.ldf"';

-- ajoutez un 2e fichier de donn�es � PRIMARY et dimensionnez le � 500 Mo avec pas de croissance � 25 Mo

ALTER DATABASE tempdb 
   ADD FILE (NAME = 'tempdev2', 
             FILENAME = 'C:\tempdb\DATA\data_temp2.ndf',
			 SIZE = 500 MB,
			 FILEGROWTH = 25 MB);