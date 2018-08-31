/* ============================================================= */
/* SUPPRESSION DES TRAVAUX                                       */
/* ============================================================= */

/* Utilisation de la base SSIS_DB */
USE [SSIS_DB]
GO

/* ============================================================= */
/* CREATION DES CATEGORIE ET DES TRAVAUX                         */
/* ============================================================= */

BEGIN TRANSACTION

/* Déclaration des variables */
DECLARE @ReturnCAT		INT

/* ------------------------------------------------------------- */
/* - Catégorie : IMPORT                                          */
/* ------------------------------------------------------------- */

/* Initialisation des variables */
SELECT @ReturnCAT = 0

/* Création de la catégorie dans laquelle les travaux vont être créées */
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[IMPORT]' AND category_class=1)
BEGIN
	EXEC @ReturnCAT = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[IMPORT]'
	IF (@@ERROR <> 0 OR @ReturnCAT <> 0) GOTO QuitWithRollback
END

/* Validation de la transaction */
COMMIT TRANSACTION

/* ============================================================= */
/* Travail : [IMPORT] WAFER - WAVELABS                           */
/* ============================================================= */

BEGIN TRANSACTION

/* Déclaration des variables */
DECLARE @ReturnWAF		INT
DECLARE @jobIdWAF		BINARY(16)

/* Suppression du job */
IF  EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'[IMPORT] WAFER - WAVELABS')
	EXEC msdb.dbo.sp_delete_job @job_name=N'[IMPORT] WAFER - WAVELABS', @delete_unused_schedule=1, @delete_history=1 

/* Initialisation des variables */
SELECT @ReturnWAF = 0

/* Création du travail */
EXEC @ReturnWAF =  msdb.dbo.sp_add_job @job_name=N'[IMPORT] WAFER - WAVELABS', 
		@enabled=0, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Intégration des résultats générés par le WAVELABS.', 
		@category_name=N'[IMPORT]', 
		@job_id = @jobIdWAF OUTPUT
IF (@@ERROR <> 0 OR @ReturnWAF <> 0) GOTO QuitWithRollback

/* Création de l'étape */
EXEC @ReturnWAF = msdb.dbo.sp_add_jobstep @job_id=@jobIdWAF, @step_name=N'WAFER - WAVELABS', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'SSIS', 
		@command=N'/SQL "\Maintenance Plans\Imports\_LANCEUR\IMPORTER" /SERVER "SRV-SSIS-IMP" /CHECKPOINTING OFF /SET "\package.variables[IdTypeImport].Value";17 /REPORTING E', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnWAF <> 0) GOTO QuitWithRollback

/* Association de l'étape et du travail */
EXEC @ReturnWAF = msdb.dbo.sp_update_job @job_id = @jobIdWAF, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnWAF <> 0) GOTO QuitWithRollback

/* Planification du travail */
IF (@@ERROR <> 0 OR @ReturnWAF <> 0) GOTO QuitWithRollback
EXEC @ReturnWAF = msdb.dbo.sp_add_jobschedule @job_id=@jobIdWAF, @name=N'[IMPORT] WAFER - WAVELABS', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=4, 
		@freq_subday_interval=2, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20140101, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959
IF (@@ERROR <> 0 OR @ReturnWAF <> 0) GOTO QuitWithRollback

/* Création du travail dans le serveur */
EXEC @ReturnWAF = msdb.dbo.sp_add_jobserver @job_id = @jobIdWAF, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnWAF <> 0) GOTO QuitWithRollback

/* Validation de la transaction */
COMMIT TRANSACTION

/* ============================================================= */
/* Travail : [IMPORT] RECIPE - WAVELABS                          */
/* ============================================================= */

BEGIN TRANSACTION

/* Déclaration des variables */
DECLARE @ReturnREC		INT
DECLARE @jobIdREC		BINARY(16)

/* Suppression du job */
IF  EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'[IMPORT] RECIPE - WAVELABS')
	EXEC msdb.dbo.sp_delete_job @job_name=N'[IMPORT] RECIPE - WAVELABS', @delete_unused_schedule=1, @delete_history=1 

/* Initialisation des variables */
SELECT @ReturnREC = 0

/* Création du travail */
EXEC @ReturnREC =  msdb.dbo.sp_add_job @job_name=N'[IMPORT] RECIPE - WAVELABS', 
		@enabled=0, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Intégration des configurations de la recette utilisée sur le WAVALABS.', 
		@category_name=N'[IMPORT]', 
		@job_id = @jobIdREC OUTPUT
IF (@@ERROR <> 0 OR @ReturnREC <> 0) GOTO QuitWithRollback

/* Création de l'étape */
EXEC @ReturnREC = msdb.dbo.sp_add_jobstep @job_id=@jobIdREC, @step_name=N'RECIPE - WAVELABS', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'SSIS', 
		@command=N'/SQL "\Maintenance Plans\Imports\_LANCEUR\IMPORTER" /SERVER "SRV-SSIS-IMP" /CHECKPOINTING OFF /SET "\package.variables[IdTypeImport].Value";18 /REPORTING E', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnREC <> 0) GOTO QuitWithRollback

/* Association de l'étape et du travail */
EXEC @ReturnREC = msdb.dbo.sp_update_job @job_id = @jobIdREC, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnREC <> 0) GOTO QuitWithRollback

/* Planification du travail */
IF (@@ERROR <> 0 OR @ReturnREC <> 0) GOTO QuitWithRollback
EXEC @ReturnREC = msdb.dbo.sp_add_jobschedule @job_id=@jobIdREC, @name=N'[IMPORT] RECIPE - WAVELABS', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=4, 
		@freq_subday_interval=2, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20140101, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959
IF (@@ERROR <> 0 OR @ReturnREC <> 0) GOTO QuitWithRollback

/* Création du travail dans le serveur */
EXEC @ReturnREC = msdb.dbo.sp_add_jobserver @job_id = @jobIdREC, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnREC <> 0) GOTO QuitWithRollback

/* Validation de la transaction */
COMMIT TRANSACTION

GOTO EndSave

QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
	
EndSave:

GO

/* ============================================================= */
/* Travail : [IMPORT] WAFER - CLASSIFICATION                    */
/* ============================================================= */

BEGIN TRANSACTION

/* Déclaration des variables */
DECLARE @ReturnREC		INT
DECLARE @jobIdREC		BINARY(16)

/* Suppression du job */
IF  EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'[IMPORT] WAFER - CLASSIFICATION')
	EXEC msdb.dbo.sp_delete_job @job_name=N'[IMPORT] WAFER - CLASSIFICATION', @delete_unused_schedule=1, @delete_history=1 

/* Initialisation des variables */
SELECT @ReturnREC = 0

/* Création du travail */
EXEC @ReturnREC =  msdb.dbo.sp_add_job @job_name=N'[IMPORT] WAFER - CLASSIFICATION', 
		@enabled=0, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Intégration de la classification des cellules sur le TRI 6.', 
		@category_name=N'[IMPORT]', 
		@job_id = @jobIdREC OUTPUT
IF (@@ERROR <> 0 OR @ReturnREC <> 0) GOTO QuitWithRollback

/* Création de l'étape */
EXEC @ReturnREC = msdb.dbo.sp_add_jobstep @job_id=@jobIdREC, @step_name=N'WAFER - CLASSIFICATION', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'SSIS', 
		@command=N'/SQL "\Maintenance Plans\Imports\_LANCEUR\IMPORTER" /SERVER "SRV-SSIS-IMP" /CHECKPOINTING OFF /SET "\package.variables[IdTypeImport].Value";19 /REPORTING E', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnREC <> 0) GOTO QuitWithRollback

/* Association de l'étape et du travail */
EXEC @ReturnREC = msdb.dbo.sp_update_job @job_id = @jobIdREC, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnREC <> 0) GOTO QuitWithRollback

/* Planification du travail */
IF (@@ERROR <> 0 OR @ReturnREC <> 0) GOTO QuitWithRollback
EXEC @ReturnREC = msdb.dbo.sp_add_jobschedule @job_id=@jobIdREC, @name=N'[IMPORT] WAFER - CLASSIFICATION', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=4, 
		@freq_subday_interval=2, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20140101, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959
IF (@@ERROR <> 0 OR @ReturnREC <> 0) GOTO QuitWithRollback

/* Création du travail dans le serveur */
EXEC @ReturnREC = msdb.dbo.sp_add_jobserver @job_id = @jobIdREC, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnREC <> 0) GOTO QuitWithRollback

/* Validation de la transaction */
COMMIT TRANSACTION

GOTO EndSave

QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
	
EndSave:

GO

/* ============================================================= */
/* Travail : [IMPORT] WAFER - CLOTURE                    		 */
/* ============================================================= */

BEGIN TRANSACTION

/* Déclaration des variables */
DECLARE @ReturnREC		INT
DECLARE @jobIdREC		BINARY(16)

/* Suppression du job */
IF  EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'[IMPORT] WAFER - CLOTURE')
	EXEC msdb.dbo.sp_delete_job @job_name=N'[IMPORT] WAFER - CLOTURE', @delete_unused_schedule=1, @delete_history=1 

/* Initialisation des variables */
SELECT @ReturnREC = 0

/* Création du travail */
EXEC @ReturnREC =  msdb.dbo.sp_add_job @job_name=N'[IMPORT] WAFER - CLOTURE', 
		@enabled=0, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Intégration des informations sur les lots clôturés.', 
		@category_name=N'[IMPORT]', 
		@job_id = @jobIdREC OUTPUT
IF (@@ERROR <> 0 OR @ReturnREC <> 0) GOTO QuitWithRollback

/* Création de l'étape */
EXEC @ReturnREC = msdb.dbo.sp_add_jobstep @job_id=@jobIdREC, @step_name=N'WAFER - CLOTURE', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'SSIS', 
		@command=N'/SQL "\Maintenance Plans\Imports\_LANCEUR\IMPORTER" /SERVER "SRV-SSIS-IMP" /CHECKPOINTING OFF /SET "\package.variables[IdTypeImport].Value";20 /REPORTING E', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnREC <> 0) GOTO QuitWithRollback

/* Association de l'étape et du travail */
EXEC @ReturnREC = msdb.dbo.sp_update_job @job_id = @jobIdREC, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnREC <> 0) GOTO QuitWithRollback

/* Planification du travail */
IF (@@ERROR <> 0 OR @ReturnREC <> 0) GOTO QuitWithRollback
EXEC @ReturnREC = msdb.dbo.sp_add_jobschedule @job_id=@jobIdREC, @name=N'[IMPORT] WAFER - CLOTURE', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=4, 
		@freq_subday_interval=2, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20140101, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959
IF (@@ERROR <> 0 OR @ReturnREC <> 0) GOTO QuitWithRollback

/* Création du travail dans le serveur */
EXEC @ReturnREC = msdb.dbo.sp_add_jobserver @job_id = @jobIdREC, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnREC <> 0) GOTO QuitWithRollback

/* Validation de la transaction */
COMMIT TRANSACTION

GOTO EndSave

QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
	
EndSave:

GO