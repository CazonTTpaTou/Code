-- voire les derni�res compl�te des bases
SELECT  database_name, MAX(backup_finish_date)
FROM    msdb.dbo.backupset
WHERE   type = 'D'
GROUP   BY database_name;

-- voire les derni�res transactionnelle des bases
SELECT  database_name, MAX(backup_finish_date)
FROM    msdb.dbo.backupset
WHERE   type = 'L'
GROUP   BY database_name;

-- voire les derni�res diff�rentielle des bases
SELECT  database_name, MAX(backup_finish_date)
FROM    msdb.dbo.backupset
WHERE   type = 'I'
GROUP   BY database_name;
