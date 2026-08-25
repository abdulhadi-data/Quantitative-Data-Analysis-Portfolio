-- Quantitative Data Analysis Portfolio
-- SQL queries reproduced from the database exercises shown in the portfolio report.

-- Task 4: Sort SOIL_ID records where ph_val > 5, ordered by ph_val
SELECT soil_id, soil_type, ph_val, sur_id, assessed
FROM SOIL_ID
WHERE ph_val > 5
ORDER BY ph_val;


-- Task 5: Show soil_id, ph_val and assessed for N.Brown,
-- ordered by assessment date in descending order
SELECT s.soil_id, s.ph_val, s.assessed
FROM SOIL_ID AS s
JOIN SURVEYOR AS v
    ON s.sur_id = v.sur_id
WHERE v.surveyor = 'N.Brown'
ORDER BY s.assessed DESC;


-- Task 6: List soil_name and ph_val for series = 3,
-- ordered alphabetically by soil_name
SELECT t.soil_name, s.ph_val
FROM SOIL_ID AS s
JOIN SOIL_TYPE AS t
    ON s.soil_type = t.soil_type
WHERE t.series = 3
ORDER BY t.soil_name ASC;
