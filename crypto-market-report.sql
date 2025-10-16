/*
Enter your query below.
Please append a semicolon ";" at the end of the query
*/

SELECT
algorithm,
SUM(CASE WHEN QUARTER(dt) = 1 THEN volume ELSE 0 END) AS Q1,
SUM(CASE WHEN QUARTER(dt) = 2 THEN volume ELSE 0 END) AS Q2,
SUM(CASE WHEN QUARTER(dt) = 3 THEN volume ELSE 0 END) AS Q3,
SUM(CASE WHEN QUARTER(dt) = 4 THEN volume ELSE 0 END) AS Q4
FROM coins c
LEFT JOIN transactions t on t.coin_code = c.code
WHERE YEAR(t.dt) = 2020
GROUP BY 1
ORDER BY algorithm