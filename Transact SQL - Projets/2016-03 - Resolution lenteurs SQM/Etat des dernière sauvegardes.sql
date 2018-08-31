-- voire les dernières complète des bases
SELECT  database_name, MAX(backup_finish_date)
FROM    msdb.dbo.backupset
WHERE   type = 'D'
GROUP   BY database_name;

-- voire les dernières transactionnelle des bases
SELECT  database_name, MAX(backup_finish_date)
FROM    msdb.dbo.backupset
WHERE   type = 'L'
GROUP   BY database_name;

-- voire les dernières différentielle des bases
SELECT  database_name, MAX(backup_finish_date)
FROM    msdb.dbo.backupset
WHERE   type = 'I'
GROUP   BY database_name;
