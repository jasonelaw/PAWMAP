EXECUTE sp_addrolemember @rolename = N'db_ddladmin', @membername = N'ROSE\jlaw';


GO
EXECUTE sp_addrolemember @rolename = N'db_datareader', @membername = N'ROSE\jlaw';


GO
EXECUTE sp_addrolemember @rolename = N'db_datawriter', @membername = N'ROSE\jlaw';

