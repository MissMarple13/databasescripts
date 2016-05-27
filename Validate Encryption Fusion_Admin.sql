set nocount on

IF OBJECT_ID('tempdb..#Results') IS NOT NULL
    DROP TABLE #Results
  
USE Fusion_Admin  
  
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
        @sql nvarchar(max),
        @sql2 nvarchar(max),
        @TblCnt int,
		@ColName varchar(50),
		@First varchar(50),
		@Last varchar(50),
		@User varchar(50)            
     
 SET IDENTITY_INSERT #Results ON
select *
from INFORMATION_SCHEMA.COLUMNS
where DATA_TYPE = 'varbinary'
AND TABLE_NAME <> 'sysdiagrams'  


Set @rownbr = 0

while @rownbr  <= 15

Begin

/*** Select Users Table ***/

set @ColName= 'FirstName' 
set @tablename  = 'Users'

/*** execute dynamic procedure to get the column name of the current view and original view & compare them ***/
  
   set @sql = ' 
select tablename = ''' + @tablename + ''', a.' + @ColName + ' from dbo.' + @tablename + ' a
join [Org_Fusion_Admin].dbo.' + @tablename + ' b
     on a.UserID = b.UserID
     and a.' + @ColName + ' <> b.' + @ColName 
 execute (@sql)
 print @sql
 
 
 
 /*** Repeat Procedure for Last Name (Users Table)***/
 
set @ColName= 'LastName' 
set @tablename  = 'Users'

/*** execute dynamic procedure to get the column name of the current view and original view & compare them ***/
  
   set @sql = ' 
select tablename=''' + @tablename + ''', a.' + @ColName + ' from dbo.' + @tablename + ' a
join [Org_Fusion_Admin].dbo.' + @tablename + ' b
     on a.UserID = b.UserID
     and a.' + @ColName + ' <> b.' + @ColName 
 execute (@sql)
 print @sql
 
 /** Fail if the result does not math **/
      
    if (DATALENGTH(@sql) <> NULL)
	RAISERROR ('QA Test Failed', -- Message text.
           16, -- Severity,
           0, -- State,
           N''''); -- First argument supplies the string.
           
  Set @rownbr = @rownbr + 2
 
 
 /*** Repeat Procedure for User Name (Users Table) ***/
 
set @ColName= 'Username' 
set @tablename  = 'Users'

/*** execute dynamic procedure to get the column name of the current view and original view & compare them ***/
  
   set @sql = ' 
select tablename=''' + @tablename + ''', a.' + @ColName + ' from dbo.' + @tablename + ' a
join [Org_Fusion_Admin].dbo.' + @tablename + ' b
     on a.UserID = b.UserID
     and a.' + @ColName + ' <> b.' + @ColName 
 execute (@sql)
 print @sql
 
 /** Fail if the result does not math **/
      
    if (DATALENGTH(@sql) <> NULL)
	RAISERROR ('QA Test Failed', -- Message text.
           16, -- Severity,
           0, -- State,
           N''''); -- First argument supplies the string.
           
 
 Set @rownbr = @rownbr + 3
 
 
 /*** Select UserSentACARMessages Table***/
 
set @ColName= 'DispatcherName' 
set @tablename  = 'UserSentACARMessages'

/*** execute dynamic procedure to get the column name of the current view and original view & compare them ***/
  
   set @sql = ' 
select tablename=''' + @tablename + ''', a.' + @ColName + ' from dbo.' + @tablename + ' a
join [Org_Fusion_Admin].dbo.' + @tablename + ' b
     on a.UserID = b.UserID
     and a.' + @ColName + ' <> b.' + @ColName 
 execute (@sql)
 print @sql
 
 /** Fail if the result does not math **/
      
 if (DATALENGTH(@sql) <> NULL)
	RAISERROR ('QA Test Failed', -- Message text.
           16, -- Severity,
           0, -- State,
           N''''); -- First argument supplies the string.
           
 
 Set @rownbr = @rownbr + 4
 
 
  /*** Select Next Colum for Table UserSentACARMessages***/
 
set @ColName= 'DispatcherInitials' 
set @tablename  = 'UserSentACARMessages'

/*** execute dynamic procedure to get the column name of the current view and original view & compare them ***/
  
   set @sql = ' 
select tablename=''' + @tablename + ''', a.' + @ColName + ' from dbo.' + @tablename + ' a
join [Org_Fusion_Admin].dbo.' + @tablename + ' b
     on a.UserID = b.UserID
     and a.' + @ColName + ' <> b.' + @ColName 
 execute (@sql)
 print @sql
 
 /** Fail if the result does not math **/
      
    if (DATALENGTH(@sql) <> NULL)
	RAISERROR ('QA Test Failed', -- Message text.
           16, -- Severity,
           0, -- State,
           N''''); -- First argument supplies the string.
           
 
 Set @rownbr = @rownbr + 5
 
 
 
 /*** Select Table Customers***/
 
set @ColName= 'MailServerUserID' 
set @tablename  = 'Customers'

/*** execute dynamic procedure to get the column name of the current view and original view & compare them ***/
  
   set @sql = ' 
select tablename=''' + @tablename + ''', a.' + @ColName + ' from dbo.' + @tablename + ' a
join [Org_Fusion_Admin].dbo.' + @tablename + ' b
     on a.CustomerID = b.CustomerID
     and a.' + @ColName + ' <> b.' + @ColName 
 execute (@sql)
 print @sql
 
 /** Fail if the result does not math **/
      
    if (DATALENGTH(@sql) <> NULL)
	RAISERROR ('QA Test Failed', -- Message text.
           16, -- Severity,
           0, -- State,
           N''''); -- First argument supplies the string.
           
 
 Set @rownbr = @rownbr + 6
 
 
 /*** Select Table TrialUsers ***/
 
set @ColName= 'Email' 
set @tablename  = 'TrialUsers'

/*** execute dynamic procedure to get the column name of the current view and original view & compare them ***/
  
   set @sql = ' 
select tablename=''' + @tablename + ''', a.' + @ColName + ' from dbo.' + @tablename + ' a
join [Org_Fusion_Admin].dbo.' + @tablename + ' b
     on a.CustomerID = b.CustomerID
     and a.' + @ColName + ' <> b.' + @ColName 
 execute (@sql)
 print @sql
 
 /** Fail if the result does not math **/
      
    if (DATALENGTH(@sql) <> NULL)
	RAISERROR ('QA Test Failed', -- Message text.
           16, -- Severity,
           0, -- State,
           N''''); -- First argument supplies the string.
           
 
 Set @rownbr = @rownbr + 7
 
 /*** Select FirstName from TrialUsers ***/
 
 
 set @ColName= 'FirstName' 
set @tablename  = 'TrialUsers'

/*** execute dynamic procedure to get the column name of the current view and original view & compare them ***/
  
   set @sql = ' 
select tablename=''' + @tablename + ''', a.' + @ColName + ' from dbo.' + @tablename + ' a
join [Org_Fusion_Admin].dbo.' + @tablename + ' b
     on a.CustomerID = b.CustomerID
     and a.' + @ColName + ' <> b.' + @ColName 
 execute (@sql)
 print @sql
 
 /** Fail if the result does not math **/
      
    if (DATALENGTH(@sql) <> NULL)
	RAISERROR ('QA Test Failed', -- Message text.
           16, -- Severity,
           0, -- State,
           N''''); -- First argument supplies the string.
           
 
 Set @rownbr = @rownbr + 8
 
 /*** Select MiddleInitial from TrialUsers ***/
 
 
 set @ColName= 'MiddleInitial' 
set @tablename  = 'TrialUsers'

/*** execute dynamic procedure to get the column name of the current view and original view & compare them ***/
  
   set @sql = ' 
select tablename=''' + @tablename + ''', a.' + @ColName + ' from dbo.' + @tablename + ' a
join [Org_Fusion_Admin].dbo.' + @tablename + ' b
     on a.CustomerID = b.CustomerID
     and a.' + @ColName + ' <> b.' + @ColName 
 execute (@sql)
 print @sql
 
 /** Fail if the result does not math **/
      
    if (DATALENGTH(@sql) <> NULL)
	RAISERROR ('QA Test Failed', -- Message text.
           16, -- Severity,
           0, -- State,
           N''''); -- First argument supplies the string.
           
 
 Set @rownbr = @rownbr + 9
 
 
  /*** Select LastName from TrialUsers ***/
 
 
 set @ColName= 'LastName' 
set @tablename  = 'TrialUsers'

/*** execute dynamic procedure to get the column name of the current view and original view & compare them ***/
  
   set @sql = ' 
select tablename=''' + @tablename + ''', a.' + @ColName + ' from dbo.' + @tablename + ' a
join [Org_Fusion_Admin].dbo.' + @tablename + ' b
     on a.CustomerID = b.CustomerID
     and a.' + @ColName + ' <> b.' + @ColName 
 execute (@sql)
 print @sql
 
 /** Fail if the result does not math **/
      
    if (DATALENGTH(@sql) <> NULL)
	RAISERROR ('QA Test Failed', -- Message text.
           16, -- Severity,
           0, -- State,
           N''''); -- First argument supplies the string.
           
 
 Set @rownbr = @rownbr + 10
 
 
 /*** Select Country from TrialUsers ***/
 
 
 set @ColName= 'Country' 
set @tablename  = 'TrialUsers'

/*** execute dynamic procedure to get the column name of the current view and original view & compare them ***/
  
   set @sql = ' 
select tablename=''' + @tablename + ''', a.' + @ColName + ' from dbo.' + @tablename + ' a
join [Org_Fusion_Admin].dbo.' + @tablename + ' b
     on a.CustomerID = b.CustomerID
     and a.' + @ColName + ' <> b.' + @ColName 
 execute (@sql)
 print @sql
 
 /** Fail if the result does not math **/
      
    if (DATALENGTH(@sql) <> NULL)
	RAISERROR ('QA Test Failed', -- Message text.
           16, -- Severity,
           0, -- State,
           N''''); -- First argument supplies the string.
           
 
 Set @rownbr = @rownbr + 11
 
 
  /*** Select Street from TrialUsers ***/
 
 
 set @ColName= 'Street' 
set @tablename  = 'TrialUsers'

/*** execute dynamic procedure to get the column name of the current view and original view & compare them ***/
  
   set @sql = ' 
select tablename=''' + @tablename + ''', a.' + @ColName + ' from dbo.' + @tablename + ' a
join [Org_Fusion_Admin].dbo.' + @tablename + ' b
     on a.CustomerID = b.CustomerID
     and a.' + @ColName + ' <> b.' + @ColName 
 execute (@sql)
 print @sql
 
 /** Fail if the result does not math **/
      
    if (DATALENGTH(@sql) <> NULL)
	RAISERROR ('QA Test Failed', -- Message text.
           16, -- Severity,
           0, -- State,
           N''''); -- First argument supplies the string.
           
 
 Set @rownbr = @rownbr + 12
 
 
  /*** Select City from TrialUsers ***/
 
 
 set @ColName= 'City' 
set @tablename  = 'TrialUsers'

/*** execute dynamic procedure to get the column name of the current view and original view & compare them ***/
  
   set @sql = ' 
select tablename=''' + @tablename + ''', a.' + @ColName + ' from dbo.' + @tablename + ' a
join [Org_Fusion_Admin].dbo.' + @tablename + ' b
     on a.CustomerID = b.CustomerID
     and a.' + @ColName + ' <> b.' + @ColName 
 execute (@sql)
 print @sql
 
 /** Fail if the result does not math **/
      
    if (DATALENGTH(@sql) <> NULL)
	RAISERROR ('QA Test Failed', -- Message text.
           16, -- Severity,
           0, -- State,
           N''''); -- First argument supplies the string.
           
 
 Set @rownbr = @rownbr + 13
 
 /*** Select State from TrialUsers ***/
 
 
 set @ColName= 'State' 
set @tablename  = 'TrialUsers'

/*** execute dynamic procedure to get the column name of the current view and original view & compare them ***/
  
   set @sql = ' 
select tablename=''' + @tablename + ''', a.' + @ColName + ' from dbo.' + @tablename + ' a
join [Org_Fusion_Admin].dbo.' + @tablename + ' b
     on a.CustomerID = b.CustomerID
     and a.' + @ColName + ' <> b.' + @ColName 
 execute (@sql)
 print @sql
 
 /** Fail if the result does not math **/
      
    if (DATALENGTH(@sql) <> NULL)
	RAISERROR ('QA Test Failed', -- Message text.
           16, -- Severity,
           0, -- State,
           N''''); -- First argument supplies the string.
           
 
 Set @rownbr = @rownbr + 14
 
 
  /*** Select PostalCode from TrialUsers ***/
 
 
 set @ColName= 'PostalCode' 
set @tablename  = 'TrialUsers'

/*** execute dynamic procedure to get the column name of the current view and original view & compare them ***/
  
   set @sql = ' 
select tablename=''' + @tablename + ''', a.' + @ColName + ' from dbo.' + @tablename + ' a
join [Org_Fusion_Admin].dbo.' + @tablename + ' b
     on a.CustomerID = b.CustomerID
     and a.' + @ColName + ' <> b.' + @ColName 
 execute (@sql)
 print @sql
 
 /** Fail if the result does not math **/
      
    if (DATALENGTH(@sql) <> NULL)
	RAISERROR ('QA Test Failed', -- Message text.
           16, -- Severity,
           0, -- State,
           N''''); -- First argument supplies the string.
           
 
 Set @rownbr = @rownbr + 15
 
 End
 
 