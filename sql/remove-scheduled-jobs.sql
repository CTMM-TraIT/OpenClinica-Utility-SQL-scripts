-- ============================================================================
--
-- SQL-script (originally recieved from Gerben-Rienk Visser of Trial Data
-- Solutions on 01-07-2013. This script removes all scheduled jobs present in 
-- an OpenClinica database.
-- The order of the statements is crucial since there are FK-relationships
-- 
-- v 0.01 initial version
-- =========================================================
delete from oc_qrtz_simple_triggers where trigger_group='XsltTriggersExportJobs';
delete from oc_qrtz_triggers where job_group='XsltTriggersExportJobs';
delete from oc_qrtz_job_details where job_group='XsltTriggersExportJobs';
