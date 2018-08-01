backup database Test
to disk = N'c:\temp\test.bak'
with format, init,
name = N'Test-Full',
stats = 5, checksum, compression
go
backup log Test
to disk = N'c:\temp\test.trn'
with format, init,
name = N'Test-Log',
stats = 5, checksum, compression
go
-- Restore
use master
go
alter database  TestDev set single_user with rollback immediate
go
restore database TestDev
from disk = N'c:\temp\test.bak' with file = 1, replace,
-- hvis filerne skal ende et andet sted end hvor de kom fra, eller
-- hvis databasen skal restores i andet navn 
-- move N'Test' to N'c:\temp\data\testDev.mdf',
-- move N'Test_log' to N'c:\temp\data\testDev_log.ldf',
norecovery, nounload, stats = 5
go
restore log TestDev
from disk = N'C:\temp\test.trn'
with nounload, norecovery, stats = 5
--,stopat = N'2018-07-31T18:00:00.000'
go
restore database TestDev with recovery
go
alter database TestDev set multi_user
go