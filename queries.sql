/*
==================================================
Student Mental Health Analysis

Author: Alvaro Perez

Database: MySQL

Description:
Exploratory SQL analysis of depression,
social connectedness and acculturative stress
among university students in Japan.

==================================================
*/


-- 1. Initial Data Exploration
SELECT *
FROM students
LIMIT 20;
-- number of international and domestic students
SELECT inter_dom, COUNT(*) AS student_count
FROM students 
GROUP BY inter_dom; -- we have 67 domestic students and 201 international students , both are good numbers for start the study 
-- 2. International Students by Length of Stay
SELECT stay, COUNT(*) AS student_count, ROUND(AVG(todep),2) AS average_phq, ROUND(AVG(tosc),2) AS average_scs, ROUND(AVG(toas),2) AS average_as
FROM students
WHERE stay IS NOT NULL AND inter_dom = 'Inter'
GROUP BY stay
ORDER BY stay DESC;
-- 3. Does Age Influence Depression?
SELECT age, ROUND(AVG(todep),2) AS average_depression, COUNT(*) AS student_count
FROM students
WHERE inter_dom = "Inter"
GROUP BY age
HAVING COUNT(*) >= 9
ORDER BY average_depression DESC;  -- No clear pattern is observed between age and average depression scores.
-- 4. International vs Domestic Students
SELECT inter_dom, ROUND(AVG(todep),2) AS average_depression
FROM students
GROUP BY inter_dom; -- Domestic students show an average depression score that is
-- approximately 0.60 points higher than international students.
-- While this difference exists in the dataset, it is relatively small.

-- 5. Japanese Proficiency and Depression
SELECT japanese_cate, inter_dom, ROUND(AVG(todep),2) AS average_depression, COUNT(*) AS student_count 
FROM students
GROUP BY japanese_cate, inter_dom
HAVING COUNT(*) >= 8
ORDER BY average_depression DESC;  -- International students with higher Japanese proficiency
-- show lower average depression scores in this dataset.
-- This suggests a possible association between language proficiency
-- and better cultural adaptation, but it does not prove causation.

-- 6. Academic Level and Depression
SELECT academic, ROUND(AVG(todep),2) AS average_depression, COUNT(*) AS student_count 
FROM students
GROUP BY academic
HAVING COUNT(*) >= 9
ORDER BY average_depression DESC;  -- Undergraduate students show higher average depression
-- scores than graduate students in this dataset.

