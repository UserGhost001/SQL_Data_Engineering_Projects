-- PARTITION BY - Find hourly salary
SELECT
    job_id,
    job_title_short,
    salary_hour_avg,
    AVG(salary_hour_avg) OVER(
        PARTITION BY job_title_short
    )
FROM
    job_postings_fact
ORDER BY RANDOM()
LIMIT 10;


-- ORDER BY - Ranking hourly salary
SELECT
    job_id,
    job_title_short,
    salary_hour_avg,
    RANK() OVER(
        ORDER BY salary_hour_avg DESC
    ) AS rank_hourly_salary
FROM
    job_postings_fact
WHERE
    salary_hour_avg IS NOT NULL
ORDER BY
    salary_hour_avg DESC
LIMIT 10;

-- PARTION BY & ORDER BY - Running Average Hourly Salary

SELECT
    job_posted_date,
    job_title_short,
    salary_hour_avg,
    AVG(salary_hour_avg) OVER(
        PARTITION BY job_title_short
        ORDER BY job_posted_date
    ) AS Running_avg_hourly_by_title
FROM
    job_postings_fact
WHERE
    salary_hour_avg IS NOT NULL
ORDER BY 
    job_title_short,
    job_posted_date
LIMIT 10;

-- LAG()

SELECT
    job_title_short,
    salary_year_avg,
    LAG(salary_year_avg) OVER(
        ORDER BY job_title_short
    ) AS previous
FROM
    job_postings_fact
WHERE
    salary_year_avg IS NOT NULL
LIMIT 10;

-- LAST_VALUE
SELECT
    job_title_short,
    salary_year_avg,
    LAST_VALUE(salary_year_avg) OVER(
        ORDER BY salary_year_avg
        ROWS BETWEEN UNBOUNDED PRECEDING
            AND UNBOUNDED FOLLOWING
    )
FROM
    job_postings_fact
WHERE
    salary_year_avg IS NOT NULL
LIMIT 10;


