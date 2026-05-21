-- ==============================================================================
-- Query: Find the most senior employee based on job title
-- Description: This query retrieves the employee with the highest 'levels' value
--              from the employee table, determining the senior-most employee.
-- ==============================================================================

SELECT *
FROM employee
ORDER BY levels DESC
LIMIT 1;
