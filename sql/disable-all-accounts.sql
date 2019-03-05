-- =======================================================================
-- Sccript to disable all user accounts except those with the postfix
-- '_adm'. This postfix denotes technical administration accounts.
--
-- =======================================================================

BEGIN;

\! printf "Total number of users\t\n";
select count(*) from user_account;

\! printf "Total number of users with status 'active'\t\n";
select count(*) from  user_account where (status_id = 1);

\! printf "Disabling accounts all accounts except technical-admins:\t\n";

SELECT ua.user_name FROM  user_account ua 
	WHERE (status_id = 1) AND (STRPOS(UPPER(user_name), '_ADM') = (LENGTH(UPPER(user_name)) - 3));

UPDATE user_account SET (status_id, enabled, date_updated) = (5, false, CURRENT_DATE)
	WHERE (status_id = 1) AND (STRPOS(UPPER(user_name), '_ADM') <> (LENGTH(UPPER(user_name)) - 3));


--ROLLBACK;
COMMIT;
