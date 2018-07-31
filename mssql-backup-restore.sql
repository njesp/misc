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
restore database TestDev
from disk = N'c:\temp\test.bak' with file = 1,
move N'Test' to N'c:\temp\data\test.mdf',
move N'Test_log' to N'c:\temp\data\test_log.ldf',
norecovery, nounload, stats = 5
go
restore log TestDev
from disk = N'C:\temp\test.trn'
with nounload, norecovery, stats = 5
--,stopat = N'2018-07-31T18:00:00.000'
go
restore database TestDev with recovery
go