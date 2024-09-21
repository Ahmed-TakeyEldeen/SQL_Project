SELECT job_posted_date
FROM job_postings_fact
LIMIT 10;



SELECT 
    '2024-5-10'::DATE,
    '123'::INT,
    'true'::BOOLEAN,
    '3.14'::REAL;




SELECT 
    job_title_short AS title,
    job_location AS location,
    job_posted_date::DATE AS date
FROM
    job_postings_fact
    LIMIT 100;




SELECT
    job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST',
    EXTRACT(YEAR FROM job_posted_date) AS extracted_year,
    EXTRACT(MONTH FROM job_posted_date) AS extracted_month,
    EXTRACT(DAY FROM job_posted_date) AS extracted_day
FROM job_postings_fact
LIMIT 100;



SELECT 
    EXTRACT(MONTH FROM job_posted_date) AS EXTRACTED
FROM job_postings_fact
LIMIT 100;



SELECT
    COUNT(job_id) AS number_jobs,
    EXTRACT(MONTH FROM job_posted_date) AS extracted_month
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
GROUP BY extracted_month
ORDER BY number_jobs DESC;



CREATE TABLE Jan_jobs AS 
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH from job_posted_date) = 1;


CREATE TABLE Feb_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 2;


CREATE TABLE Mar_jobs AS
    select *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 3;



SELECT *
FROM Jan_jobs;

SELECT *
FROM Feb_jobs;

SELECT *
FROM Mar_jobs;



SELECT 
        COUNT(job_id) AS number_of_jobs,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS descreption
FROM job_postings_fact
WHERE 
    job_title_short = 'Data Analyst'
GROUP BY descreption
LIMIT 100;


SELECT *
FROM (
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) =1
) AS january_jobs;


WITH january_jobs AS(
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT (MONTH FROM job_posted_date) = 3
)

SELECT *
FROM january_jobs;


SELECT 
    company_id,
    name AS company_name
FROM 
    company_dim
WHERE company_id IN (
    SELECT
            company_id
    FROM
            job_postings_fact
    WHERE
            job_no_degree_mention = true
    ORDER BY
            company_id
)




WITH company_job_count AS(
SELECT 
        company_id,
        COUNT (*) AS total_jobs
from 
        job_postings_fact
GROUP BY 
        company_id
)

SELECT 
    company_dim.name AS company_name,
    company_job_count.total_jobs
FROM company_dim
LEFT JOIN company_job_count ON company_job_count.company_id = company_dim.company_id
ORDER BY total_jobs DESC;





SELECT *
from job_postings_fact
WHERE job_location = 'Anywhere';

SELECT
    COUNT(skills)
FROM skills_dim
GROUP BY(skill_id)
;

WITH skill_count AS (
SELECT 
    skill_id,
    COUNT(*) AS skill_count
FROM 
    skills_job_dim AS skill_job
INNER JOIN
    job_postings_fact AS job_posting ON
    job_posting.job_id = skill_job.job_id
WHERE 
    job_posting.job_work_from_home = true AND
    job_title_short = 'Data Analyst'
GROUP BY
    skill_id
)

SELECT 
    skills.skill_id,
    skills AS skill_name,
    skill_count
FROM skill_count
INNER JOIN skills_dim AS skills ON
    skill_count.skill_id = skills.skill_id
ORDER BY
    skill_count DESC
    LIMIT 5;


WITH com AS (
SELECT 
    job_title_short,
    company_id,
    job_location,
    salary_year_avg
FROM 
    jan_jobs

UNION ALL


SELECT 
    job_title_short,
    company_id,
    job_location,
    salary_year_avg
FROM feb_jobs

UNION 


SELECT 
    job_title_short,
    company_id,
    job_location,
    salary_year_avg
FROM mar_jobs
)

SELECT *
FROM com
WHERE 
    salary_year_avg >70000
    AND
    job_title_short = 'Data Analyst'
ORDER BY salary_year_avg DESC
    ;