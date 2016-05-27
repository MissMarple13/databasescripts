
/*** Script that compares the Dispatcher names from the original table (Pre-encryption) and the view table
-- (Post-encryption) to ensure that they are exactly the same if they are the ending value of the variable
should be null error tests for this value. Also encryption key is verified

****/


set nocount on

IF OBJECT_ID('tempdb..#Results') IS NOT NULL
    DROP TABLE #Results
    
USE Fusion_AAL  
  
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
     

Set @maxnbr = (select Count(*) Dispatcher from dbo.ACARRequests)

Set @rownbr = 0

while (@rownbr  <= @maxnbr)

begin

    select @tablename = TblName from #Results where id = @rownbr

/** Declare Table (ACARRequests) & Column Name and Insert correct values in temp table ***/ 

    
SET IDENTITY_INSERT #Results ON
select *
from INFORMATION_SCHEMA.COLUMNS
where DATA_TYPE = 'varbinary'
AND TABLE_NAME <> 'sysdiagrams'

set @ColName= 'Dispatcher' 
set @tablename  = 'ACARRequests'

/*** execute dynamic procedure to get the column name of the current view and original view & compare them ***/
  
   set @sql = ' 
select tablename = ''' + @tablename + ''', a.' + @ColName + ' from dbo.' + @tablename + ' a
join [Org_Fusion_AAL].dbo.' + @tablename + ' b
     on a.ID = b.ID
     and a.' + @ColName + ' <> b.' + @ColName 
 execute (@sql)
 print @sql

     
     /** Fail if the result does not math **/
      
   if @sql =  NULL
	RAISERROR ('QA Test Failed', -- Message text.
           16, -- Severity,
           0, -- State,
           N''''); -- First argument supplies the string.
           
    
   set @rownbr = @rownbr + 4
   
   
  /*** Declare Table (ACARs) & Column Name and Insert correct values in temp table ***/ 

    
SET IDENTITY_INSERT #Results ON
select *
from INFORMATION_SCHEMA.COLUMNS
where DATA_TYPE = 'varbinary'
AND TABLE_NAME <> 'sysdiagrams'

set @ColName= 'Dispatcher' 
set @tablename  = 'ACARs'

/*** execute dynamic procedure to get the column name of the current view and original view & compare them ***/
  
   set @sql = ' 
select a.' + @ColName + ' from dbo.' + @tablename + ' a
join [Org_Fusion_AAL].dbo.' + @tablename + ' b
     on a.ID = b.ID
     and a.' + @ColName + ' <> b.' + @ColName 
 execute (@sql)
 print @sql

 
     /** Fail if the result does not math **/
      
   if @sql =  NULL
	RAISERROR ('QA Test Failed', -- Message text.
           16, -- Severity,
           0, -- State,
           N''''); -- First argument supplies the string.
           
    
   set @rownbr = @rownbr + 5
   
     
   End        
           

 /** The following verifies that encryption is in the database if not the script throws an error **/

Declare @mylght varchar(max)

set @mylght = (select name FROM sys.symmetric_keys)

if @mylght = NULL 
	RAISERROR ('No Key Encryption detected', -- Message text.
           16, -- Severity,
           0, -- State,
           N''''); -- First argument supplies the string.
           

 /** Once the test passes the encryption symmetric keys is printed out  **/

SELECT name, key_length, algorithm_desc, create_date, modify_date
FROM sys.symmetric_keys;



