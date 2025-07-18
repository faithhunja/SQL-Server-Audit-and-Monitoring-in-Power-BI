/* Select the required columns in the audit logs to ingest into
   Power BI using DirectQuery, filtered by the 3 test users */

SELECT f.database_principal_name [User Account],
  (CASE
    WHEN a.name = 'STATEMENT ROLLBACK' THEN 'ROLLBACK'
    ELSE a.name 
  END) [User Actions], 
  (CASE
    WHEN f.succeeded = 1 THEN 'Success'
    ELSE 'Failed'
  END) [Status],
  f.statement [SQL Statement],
  f.event_time [Date/Time]
FROM sys.fn_get_audit_file 
  ('C:\Audit\DatabaseAudit\Database_Audit_*.sqlaudit', 
   default, default) f
  INNER JOIN (SELECT DISTINCT action_id, name 
  FROM sys.dm_audit_actions) a
    ON f.action_id = a.action_id
WHERE f.database_principal_name IN ('User01', 'User02', 'User03')
