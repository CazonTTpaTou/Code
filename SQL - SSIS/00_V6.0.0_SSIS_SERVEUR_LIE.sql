-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
--											CREATION DES SERVEURS LIES      	      					
-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

USE [master]
GO

-- -------------------------------------------------------------------------------------------------------------------------------
-- SERVEUR LIE SUR LE POSTE xx.xx.xx.xx
-- -------------------------------------------------------------------------------------------------------------------------------

-- On supprime le serveur lié s'il existe deja
IF  EXISTS (SELECT srv.name FROM sys.servers srv WHERE srv.server_id != 0 AND srv.name = N'xx.xx.xx.xx\POSTGRESQL')
	EXEC master.dbo.sp_dropserver @server=N'xx.xx.xx.xx\POSTGRESQL', @droplogins='droplogins'
GO

-- Création du serveur lié 'xx.xx.xx.xx\POSTGRESQL'
EXEC master.dbo.sp_addlinkedserver 
     @server = N'xx.xx.xx.xx\POSTGRESQL', 
     @srvproduct=N'PostgreSQL Unicode(x64)', 
     @datasrc=N'WAVELABS_1',
     @provider=N'MSDASQL', 
     @provstr=N'Driver=PostgreSQL Unicode(x64);uid=usr_public_write;Server=xx.xx.xx.xx;database=db_wl_results;pwd=WaveLabsWrite;SSLmode=disable;PORT=5432'
GO

-- Création du login pour se connecter à la base POSTGRESQL distante
EXEC master.dbo.sp_addlinkedsrvlogin 
     @rmtsrvname=N'xx.xx.xx.xx\POSTGRESQL',
     @useself=N'True',
     @locallogin=NULL,
     @rmtuser=N'usr_public_write',
     @rmtpassword=N'WaveLabsWrite'
GO

-- Définiition des options du serveur lié
EXEC master.dbo.sp_serveroption 
     @server=N'xx.xx.xx.xx\POSTGRESQL', 
     @optname=N'rpc out', 
     @optvalue=N'true'
GO

-- -------------------------------------------------------------------------------------------------------------------------------
-- SERVEUR LIE SUR LE POSTE xx.xx.xx.xx
-- -------------------------------------------------------------------------------------------------------------------------------

-- On supprime le serveur lié s'il existe deja
IF  EXISTS (SELECT srv.name FROM sys.servers srv WHERE srv.server_id != 0 AND srv.name = N'xx.xx.xx.xx\POSTGRESQL')
	EXEC master.dbo.sp_dropserver @server=N'xx.xx.xx.xx\POSTGRESQL', @droplogins='droplogins'
GO

-- Création du serveur lié 'xx.xx.xx.xx\POSTGRESQL'
EXEC master.dbo.sp_addlinkedserver 
     @server = N'xx.xx.xx.xx\POSTGRESQL', 
     @srvproduct=N'PostgreSQL Unicode(x64)', 
     @datasrc=N'Wavelabs_2',
     @provider=N'MSDASQL', 
     @provstr=N'Driver=PostgreSQL Unicode(x64);uid=usr_public_write;Server=xx.xx.xx.xx;database=db_wl_results;pwd=WaveLabsWrite;SSLmode=disable;PORT=5432'
GO

-- Création du login pour se connecter à la base POSTGRESQL distante
EXEC master.dbo.sp_addlinkedsrvlogin 
     @rmtsrvname=N'xx.xx.xx.xx\POSTGRESQL',
     @useself=N'True',
     @locallogin=NULL,
     @rmtuser=N'usr_public_write',
     @rmtpassword=N'WaveLabsWrite'
GO

-- Définiition des options du serveur lié
EXEC master.dbo.sp_serveroption 
     @server=N'xx.xx.xx.xx\POSTGRESQL', 
     @optname=N'rpc out', 
     @optvalue=N'true'
GO


