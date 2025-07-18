-- SQL Server audit implementation

-- Use the master database to create the server audit

USE master;
GO

-- Create a server audit and give a target location to save the logs

CREATE SERVER AUDIT SQL_Server_Audit
TO FILE (FILEPATH = 'C:\Audit\SQLServerAudit\');

-- Create a server audit specification for the server audit above 

CREATE SERVER AUDIT SPECIFICATION SQL_Server_Audit_Specification  
FOR SERVER AUDIT SQL_Server_Audit
GO  

-- Enable the server audit and server audit specification

ALTER SERVER AUDIT SQL_Server_Audit WITH (STATE = ON);
GO

ALTER SERVER AUDIT SPECIFICATION SQL_Server_Audit_Specification WITH (STATE = ON);
GO

-- To turn off server audit and server audit specification before making changes

ALTER SERVER AUDIT SQL_Server_Audit WITH (STATE = OFF);
GO

ALTER SERVER AUDIT SPECIFICATION SQL_Server_Audit_Specification WITH (STATE = OFF);
GO

-- To change the target location of the audit logs if required

ALTER SERVER AUDIT SQL_Server_Audit
TO FILE (FILEPATH = 'C:\Audit\SQLServerAudit\'); 