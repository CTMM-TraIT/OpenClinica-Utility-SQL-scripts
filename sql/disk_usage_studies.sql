/******************************************************************************

Script to generate an overview of the disk usage per study and associated 
sites. Works in conjunction with the bash-script 'disk_usages_studies.sh'.

Accepts 2 named commandline parameters:

1) 'directory_name':	the directory name containing the attached files per 
			study or site. This corresponds to the field 'oc_oid' 
			in the Study-table in the OpenClinica DB.
			For example "S_DEFAULTS1".

2) 'disk_usage':	the disk usage for example as determined by the 
			bash command 'du -sb *'

The parameters are passed to this script using the '-v' parameter. For example:

psql -d openclinica -f disk_usage_studies.sql -v directory_name="'S_TESTREST'" -v disk_usage="'asfdadsf'"

*******************************************************************************/

CREATE TEMP TABLE improved_study AS
		SELECT 
			study_id AS study_id,
			name AS study_name,
			oc_oid AS oc_oid,
			parent_study_id AS parent_study_id
                FROM study st;

-- Create a second temporary table to store all the main studies

CREATE TEMP TABLE main_studies_table AS
		SELECT 
			study_id AS study_id,
			name AS study_name,
			oc_oid AS oc_oid
                FROM study st WHERE (parent_study_id ISNULL);

-- SELECT * FROM main_studies_table;

-- Now replace the study_name column in the 'improved_study' with a concatenation of the main study name and the site (study) name.
UPDATE improved_study ims
SET study_name = main_study.study_name || ':' || ims.study_name
FROM main_studies_table main_study
WHERE (parent_study_id NOTNULL) AND (main_study.study_id = parent_study_id);


-- SELECT study_name AS "Study name", :disk_usage AS "disk usage"  FROM improved_study WHERE oc_oid = :directory_name ORDER BY study_name;
SELECT oc_oid, study_name FROM improved_study ORDER BY oc_oid;


/* SELECT st.name, 
	st.parent_study_id, 
	pst.name AS "parent name", 
	CASE WHEN ((st.parent_study_id = NULL)e) THEN st.name 
		WHEN ((st.parent_study_id <> NULL) AND (st.oc_oid = 'S_FIRST_SI')) THEN (SELECT name from study WHERE (pst.study_id = st.parent_study_id))
		ELSE 'Unknown' END AS "Study name"
	 FROM study st, study pst;
*/
