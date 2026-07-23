
SELECT
    job_posted_date,
    EXTRACT(YEAR FROM job_posted_date) AS job_posted_year
FROM
    job_postings_fact
LIMIT 10;