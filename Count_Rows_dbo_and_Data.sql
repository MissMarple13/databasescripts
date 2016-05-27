set nocount on

IF OBJECT_ID('tempdb..#Results') IS NOT NULL
    DROP TABLE #Results
  
CREATE TABLE #Results (id int identity(1,1), TblName varchar(50),Tbldbo Int,Tbldata int);

INSERT INTO #Results (TblName)
select TABLE_NAME as TableName
from INFORMATION_SCHEMA.TABLES
where TABLE_TYPE = 'BASE TABLE'
and TABLE_SCHEMA = 'Data'
ORDER BY TABLE_NAME


declare @tablename varchar(50),
        @rownbr int,
        @maxnbr int,
        @sql nvarchar(max),
        @sql2 nvarchar(max),
        @TblCnt int,
        @Cnt int,
        @Parm nvarchar(20)

set @rownbr = 1
select @maxnbr = count(*) from #Results

while (@rownbr <= @maxnbr)
begin
    select @tablename = TblName from #Results where id = @rownbr
  
    select @sql = 'select @Cnt=count(*) from dbo.' + @tablename
    SET @Parm = '@Cnt int output'
    EXEC sp_executesql @sql , @Parm ,@Cnt OUT
   
   
    update #Results
    set Tbldbo = @Cnt
    where TblName = @tablename


    /** Now we need data from the org database **/
    
    select @sql2 = 'select @Cnt=count from Data.' + @tablename
    SET @Parm = '@Cnt int output'
    EXEC sp_executesql @sql , @Parm ,@Cnt OUT
  
   
   
    update #Results
    set Tbldata = @Cnt
    where TblName = @tablename
  
  
    select @rownbr = @rownbr + 1  
        
end

if exists (select * from #Results where Tbldbo <> Tbldata)
   RAISERROR ('QA Test Failed', -- Message text.
           16, -- Severity,
           0, -- State,
           N''''); -- First argument supplies the string.
