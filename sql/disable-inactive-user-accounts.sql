-- =======================================================================
-- Sccript to disable user accounts which have been inactive for more than
-- XXX days.
--
-- =======================================================================

BEGIN;

\! printf "Total number of users\t\n";
select count(*) from user_account;

\! printf "Total number of users with status 'active'\t\n";
select count(*) from  user_account where (status_id = 1);

\! printf "Disabling accounts which have not logged in longer than 365 days ago:\t\n";

SELECT ua.user_name FROM  user_account ua 
	WHERE (status_id = 1) AND ((CURRENT_TIMESTAMP - ua.date_lastvisit) > interval '365 days');

UPDATE user_account SET (status_id, enabled, date_updated) = (5, false, CURRENT_DATE)
	WHERE (status_id = 1) AND ((CURRENT_TIMESTAMP - date_lastvisit) > interval '365 days');

ROLLBACK;
--COMMIT;
