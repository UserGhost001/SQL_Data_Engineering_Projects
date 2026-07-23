-- Final Example: Conditional Calculations
-- Compute a standardized_salary using yearly salary and adjusted hourly salary (e.g. 2080 hours / year)
-- Categorize salaries into tiers of:
    -- < 75K 'Low'
    -- 75K - 150K 'Medium'
    -- >= 150K 'High'

SELECT
    job_title_short,
    CASE
        WHEN salary_year_avg IS NULL AND salary_hour_avg IS NOT NULL THEN salary_hour_avg * 2080
        ELSE salary_year_avg
    END AS standardized_salary,
    CASE
        WHEN standardized_salary < 75_000 THEN 'Low'
        WHEN standardized_salary < 150_000 THEN 'Medium'
        ELSE 'High'
    END AS categorized_salaries
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL
LIMIT 10;
     