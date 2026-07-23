-- Array Intro
SELECT ['python', 'sql', 'r'] AS skills_array;

WITH skills AS (
    SELECT 'python' AS skill
    UNION ALL
    SELECT 'sql'
    UNION ALL
    SELECT 'r'
), skills_array AS ( 
    SELECT ARRAY_AGG(skill ORDER BY skill) AS skills
    FROM skills
) 
SELECT
    skills[1]
FROM skills_array;

-- STRUCT

SELECT { skill: 'python', type: 'programming'} AS skill_struct;

WITH skill_struct AS(
    SELECT
        STRUCT_PACK(
            skill := 'python',
            type := 'programming'
    ) AS s
)
SELECT
    s.skill,
    s.type
FROM skill_struct;


WITH skill_table AS(
    SELECT 'python' AS skills, 'programming' AS types
    UNION ALL
    SELECT 'sql', 'query_language'
    UNION ALL
    SELECT 'r', 'programming'
)
SELECT
    STRUCT_PACK(
        skill := skills,
        type := types
    )
FROM
    skill_table;



-- Array of Structs
SELECT [
    { skill: 'python', type: 'programming'},
    {skill: 'sql', type: 'query_language'}
];


WITH skill_table AS(
    SELECT 'python' AS skills, 'programming' AS types
    UNION ALL
    SELECT 'sql', 'query_language'
    UNION ALL
    SELECT 'r', 'programming'
)
SELECT
    ARRAY_AGG(
        STRUCT_PACK(
            skill := skills,
            type := types
        )
    )
FROM
    skill_table;


--JSON
WITH raw_json AS (
    SELECT
        '[
            {"skill":"python", "type":"programming"},
            {"skill":"sql", "type":"query_language"},
            {"skill":"r", "type":"programming"}
        ]'::JSON AS skills_json
)
SELECT
    ARRAY_AGG(
        STRUCT_PACK(
            skill := json_extract_string(e.value, '$.skill'),
            type := json_extract_string(e.value, '$.type')
        )
        ORDER BY json_extract_string(e.value, '$.skill')
    ) AS skills
FROM
    raw_json, json_each(skills_json) AS e;