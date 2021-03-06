Declare @dbname varchar(32)
Declare @sql varchar(512)

DECLARE db_cursor CURSOR FOR SELECT name FROM master.dbo.sysdatabases
	WHERE name not in ('dbamaint','master','model','msdb','OPS')


OPEN db_cursor
FETCH NEXT FROM db_cursor INTO @dbname

WHILE (@@fetch_status <> -1)

BEGIN

--print @dbname
select @sql = 'Use ' + @dbname + char(13) + char(10)
select @sql = @sql + ' IF  EXISTS (SELECT * FROM dbo.sysusers WHERE name = N"HOME_OFFICE\dexstagiis") EXEC dbo.sp_revokedbaccess N"HOME_OFFICE\dexstagiis"'
print @sql


FETCH NEXT FROM db_cursor INTO @dbname

END

CLOSE db_cursor
DEALLOCATE db_cursor