/*
	Backup and shrink Banking and Boodschappen

	Banking: 4 / 8
	Boodschappen: 8 / 8
*/

-- Make the backup files with date/time stamp
DECLARE @Date varchar(20) = (SELECT REPLACE(CONVERT(varchar(19), GETDATE(), 21), ':', ''))
DECLARE @Banking varchar(128) = 'C:\Users\Kees\OneDrive\Environment\SQL Backup\Banking ' + @Date + '.bak'
DECLARE @Boodschappen varchar(128) = 'C:\Users\Kees\OneDrive\Environment\SQL Backup\Boodschappen ' + @Date + '.bak'

-- Backup files
BACKUP DATABASE [Banking] TO DISK = @Banking WITH NOFORMAT,
	NOFORMAT,
	NOINIT,
	NAME = N'Banking-Full Database Backup',
	SKIP,
	NOREWIND,
	NOUNLOAD,
	STATS = 10

BACKUP DATABASE [Banking] TO DISK = @Banking WITH DIFFERENTIAL,
	NOFORMAT,
	NOINIT,
	NAME = N'Banking-Diff Database Backup',
	SKIP,
	NOREWIND,
	NOUNLOAD,
	STATS = 10

BACKUP LOG [Banking] TO DISK = @Banking WITH NOFORMAT,
	NOINIT,
	NAME = N'Banking-Log Database Backup',
	SKIP,
	NOREWIND,
	NOUNLOAD,
	STATS = 10

BACKUP DATABASE [Boodschappen] TO DISK = @Boodschappen WITH DIFFERENTIAL,
	NOFORMAT,
	NOINIT,
	NAME = N'Boodschappen-Full Database Backup',
	SKIP,
	NOREWIND,
	NOUNLOAD,
	STATS = 10

BACKUP DATABASE [Boodschappen] TO DISK = @Boodschappen WITH DIFFERENTIAL,
	NOFORMAT,
	NOINIT,
	NAME = N'Boodschappen-Diff Database Backup',
	SKIP,
	NOREWIND,
	NOUNLOAD,
	STATS = 10

BACKUP LOG [Boodschappen] TO DISK = @Boodschappen WITH NOFORMAT,
	NOINIT,
	NAME = N'Boodschappen-Log Database Backup',
	SKIP,
	NOREWIND,
	NOUNLOAD,
	STATS = 10
GO

-- Shrink the files
USE [Banking]
GO
DBCC SHRINKFILE (N'Banking', 0, TRUNCATEONLY)
GO
DBCC SHRINKFILE (N'Banking_log', 0)
GO
DBCC SHRINKFILE (N'Banking_log' , 0, TRUNCATEONLY)
GO

USE [Boodschappen]
GO
DBCC SHRINKFILE (N'Boodschappen', 0, TRUNCATEONLY)
GO
DBCC SHRINKFILE (N'Boodschappen_log', 0)
GO
DBCC SHRINKFILE (N'Boodschappen_log' , 0, TRUNCATEONLY)
GO
