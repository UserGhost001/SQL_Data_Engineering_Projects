-- Subquery
SELECT *
FROM (
    SELECT *
    FROM job_postings_fact
    WHERE salary_year_avg IS NOT NULL
        OR salary_hour_avg IS NOT NULL
)
LIMIT 10;

-- 🧩 Scenario 1 - Subquery in `SELECT`
-- Show each job's salary next to the overall market median:
SELECT 
    job_title_short,
    AVG(salary_year_avg) AS average_salary,
    (
        SELECT 
            MEDIAN(salary_year_avg) AS median_salary
        FROM job_postings_fact
    ) AS market_median_salary
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL
GROUP BY job_title_short
LIMIT 10;


-- 🧩 Scenario 2 - Subquery in FROM
-- Stage only jobs that are remote before aggregating: to dermine the remote median salary per job
SELECT
    job_title_short,
    MEDIAN(salary_year_avg) AS median_salary,
        (
            SELECT MEDIAN(salary_year_avg)
            FROM job_postings_fact
            WHERE job_work_from_home = TRUE
        ) AS market_median_salary
    FROM (
        SELECT 
            job_title_short,
            salary_year_avg
        FROM job_postings_fact
        WHERE job_work_from_home = TRUE
    ) AS remote_jobs
GROUP BY job_title_short;

-- 🧩 Scenario 3 - Subquery in `Having`
-- Keep only job titles whose median salary is above the overall median:
SELECT
    job_title_short,
    MEDIAN(salary_year_avg) as median_salary,
    (
        SELECT
            MEDIAN(salary_year_avg)
        FROM job_postings_fact 
    ) AS market_median_salary
FROM job_postings_fact
GROUP BY job_title_short
Having median_salary > (
    SELECT
            MEDIAN(salary_year_avg)
        FROM job_postings_fact
);




-- CTE

WITH valid_salaries AS (
    SELECT *
    FROM job_postings_fact
    WHERE salary_year_avg IS NOT NULL
        OR salary_hour_avg IS NOT NULL
)
SELECT * 
FROM valid_salaries
LIMIT 10;