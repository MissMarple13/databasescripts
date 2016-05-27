set nocount on

IF OBJECT_ID('tempdb..#Results') IS NOT NULL
    DROP TABLE #Results
  
USE FusionFlights  
  
CREATE TABLE #Results (id int identity(1,1), TblName varchar(50),Tbldbo Varchar (50),Tbldata Varchar (50));

INSERT INTO #Results (TblName)
select TABLE_NAME as TableName
from INFORMATION_SCHEMA.TABLES
where TABLE_TYPE = 'BASE TABLE'
and TABLE_SCHEMA = 'data'
and TABLE_NAME <> 'sysdiagrams'
ORDER BY TABLE_NAME


declare @tablename varchar(50),
        @rownbr int,
        @maxnbr int,
        @sql nvarchar(max),
        @sql2 nvarchar(max),
        @TblCnt int,
		@ColName varchar(50)            
     

Set @rownbr = 0

while @rownbr  <= 3

begin

    select @tablename = TblName from #Results where id = @rownbr

/** Declare Table (Position) & Column Name and Insert correct values in temp table ***/ 

    
SET IDENTITY_INSERT #Results ON
select *
from INFORMATION_SCHEMA.COLUMNS
where DATA_TYPE = 'varbinary'
AND TABLE_NAME <> 'sysdiagrams'

set @ColName= 'UserName' 
set @tablename  = 'Position'

/*** execute dynamic procedure to get the column name of the current view and original view & compare them ***/
  
   set @sql = ' 
select tablename = ''' + @tablename + ''', a.' + @ColName + ' from Data.' + @tablename + ' a
join [Org_FusionFlights].dbo.' + @tablename + ' b
     on a.UserID = b.UserID
     and a.' + @ColName + ' <> b.' + @ColName 
 execute (@sql)
 print @sql
              
   set @rownbr = @rownbr + 1
   
   /** Declare Table (MessageHistory) & Column Name and Insert correct values in temp table ***/ 

    
SET IDENTITY_INSERT #Results ON
select *
from INFORMATION_SCHEMA.COLUMNS
where DATA_TYPE = 'varbinary'
AND TABLE_NAME <> 'sysdiagrams'

set @ColName= 'UserName' 
set @tablename  = 'MessageHistory'

/*** execute dynamic procedure to get the column name of the current view and original view & compare them ***/
  
   set @sql = ' 
select tablename = ''' + @tablename + ''', a.' + @ColName + ' from Data.' + @tablename + ' a
join [Org_FusionFlights].dbo.' + @tablename + ' b
     on a.UserID = b.UserID
     and a.' + @ColName + ' <> b.' + @ColName 
 execute (@sql)
 print @sql
              
   set @rownbr = @rownbr + 2
   
    /** Declare Table (Notes) & Column Name and Insert correct values in temp table ***/ 

    
SET IDENTITY_INSERT #Results ON
select *
from INFORMATION_SCHEMA.COLUMNS
where DATA_TYPE = 'varbinary'
AND TABLE_NAME <> 'sysdiagrams'

set @ColName= 'SubmittedBy' 
set @tablename  = 'Notes'

/*** execute dynamic procedure to get the column name of the current view and original view & compare them ***/
  
   set @sql = ' 
select tablename = ''' + @tablename + ''', a.' + @ColName + ' from Data.' + @tablename + ' a
join [Org_FusionFlights].dbo.' + @tablename + ' b
     on a.UserID = b.UserID
     and a.' + @ColName + ' <> b.' + @ColName 
 execute (@sql)
 print @sql
              
   set @rownbr = @rownbr + 3  
   
 
   
   End