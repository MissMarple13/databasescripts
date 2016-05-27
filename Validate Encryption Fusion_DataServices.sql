   
set nocount on

IF OBJECT_ID('tempdb..#Results') IS NOT NULL
    DROP TABLE #Results
    
USE Fusion_DataServices
  
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

while @rownbr  <= 6

begin

    select @tablename = TblName from #Results where id = @rownbr

/** Declare Table (ACARSMessage) & Column Name and Insert correct values in temp table ***/ 

    
SET IDENTITY_INSERT #Results ON
select *
from INFORMATION_SCHEMA.COLUMNS
where DATA_TYPE = 'varbinary'
AND TABLE_NAME <> 'sysdiagrams'

set @ColName= 'DispatcherName' 
set @tablename  = 'ACARSMessage'

/*** execute dynamic procedure to get the column name of the current view and original view & compare them ***/
  
   set @sql = ' 
select tablename = ''' + @tablename + ''', a.' + @ColName + ' from dbo.' + @tablename + ' a
join [Org_Fusion_DataServices].dbo.' + @tablename + ' b
     on a.CustomerID = b.CustomerID
     and a.' + @ColName + ' <> b.' + @ColName 
 execute (@sql)
 print @sql
                
   set @rownbr = @rownbr + 1
   
 
   /** Declare Table (DataServicesSecurity) & Column Name and Insert correct values in temp table ***/ 

    
SET IDENTITY_INSERT #Results ON
select *
from INFORMATION_SCHEMA.COLUMNS
where DATA_TYPE = 'varbinary'
AND TABLE_NAME <> 'sysdiagrams'

set @ColName= 'Username' 
set @tablename  = 'DataServicesSecurity'

/*** execute dynamic procedure to get the column name of the current view and original view & compare them ***/
  
   set @sql = ' 
select tablename = ''' + @tablename + ''', a.' + @ColName + ' from dbo.' + @tablename + ' a
join [Org_Fusion_DataServices].dbo.' + @tablename + ' b
     on a.CustomerID = b.CustomerID
     and a.' + @ColName + ' <> b.' + @ColName 
 execute (@sql)
 print @sql
               
   set @rownbr = @rownbr + 2

    /** Declare Table (DataServicesSecurity) & Column Name and Insert correct values in temp table ***/ 

    
SET IDENTITY_INSERT #Results ON
select *
from INFORMATION_SCHEMA.COLUMNS
where DATA_TYPE = 'varbinary'
AND TABLE_NAME <> 'sysdiagrams'

set @ColName= 'Password' 
set @tablename  = 'DataServicesSecurity'

/*** execute dynamic procedure to get the column name of the current view and original view & compare them ***/
  
   set @sql = ' 
select tablename = ''' + @tablename + ''', a.' + @ColName + ' from dbo.' + @tablename + ' a
join [Org_Fusion_DataServices].dbo.' + @tablename + ' b
     on a.CustomerID = b.CustomerID
     and a.' + @ColName + ' <> b.' + @ColName 
 execute (@sql)
 print @sql
               
   set @rownbr = @rownbr + 3

   
       /** Declare Table (FlightCrew) & Column Name and Insert correct values in temp table ***/ 

    
SET IDENTITY_INSERT #Results ON
select *
from INFORMATION_SCHEMA.COLUMNS
where DATA_TYPE = 'varbinary'
AND TABLE_NAME <> 'sysdiagrams'

set @ColName= 'EmployeeID' 
set @tablename  = 'FlightCrew'

/*** execute dynamic procedure to get the column name of the current view and original view & compare them ***/
  
   set @sql = ' 
select tablename = ''' + @tablename + ''', a.' + @ColName + ' from dbo.' + @tablename + ' a
join [Org_Fusion_DataServices].dbo.' + @tablename + ' b
     on a.CustomerID = b.CustomerID
     and a.' + @ColName + ' <> b.' + @ColName 
 execute (@sql)
 print @sql
               
   set @rownbr = @rownbr + 4
   
   
   
   /** Declare Table (FlightBuffer) & Column Name and Insert correct values in temp table ***/ 

    
SET IDENTITY_INSERT #Results ON
select *
from INFORMATION_SCHEMA.COLUMNS
where DATA_TYPE = 'varbinary'
AND TABLE_NAME <> 'sysdiagrams'

set @ColName= 'UserName' 
set @tablename  = 'FlightBuffer'

/*** execute dynamic procedure to get the column name of the current view and original view & compare them ***/
  
   set @sql = ' 
select tablename = ''' + @tablename + ''', a.' + @ColName + ' from dbo.' + @tablename + ' a
join [Org_Fusion_DataServices].dbo.' + @tablename + ' b
     on a.CustomerID = b.CustomerID
     and a.' + @ColName + ' <> b.' + @ColName 
 execute (@sql)
 print @sql
               
   set @rownbr = @rownbr + 5
   
     
     
   /** Declare Table (PositionBuffer) & Column Name and Insert correct values in temp table ***/ 

    
SET IDENTITY_INSERT #Results ON
select *
from INFORMATION_SCHEMA.COLUMNS
where DATA_TYPE = 'varbinary'
AND TABLE_NAME <> 'sysdiagrams'

set @ColName= 'UserName' 
set @tablename  = 'PositionBuffer'

/*** execute dynamic procedure to get the column name of the current view and original view & compare them ***/
  
   set @sql = ' 
select tablename = ''' + @tablename + ''', a.' + @ColName + ' from dbo.' + @tablename + ' a
join [Org_Fusion_DataServices].dbo.' + @tablename + ' b
     on a.CustomerID = b.CustomerID
     and a.' + @ColName + ' <> b.' + @ColName 
 execute (@sql)
 print @sql
               
   set @rownbr = @rownbr + 6   
     
       
   END
   
