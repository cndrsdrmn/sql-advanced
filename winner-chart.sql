/*
Enter your query below.
Please append a semicolon ";" at the end of the query
*/

WITH best_score AS (
  SELECT
    event_id,
    participant_name,
    MAX(score) AS best
  FROM scoretable
  GROUP BY event_id, participant_name
),
ranked AS (
  SELECT
    event_id,
    participant_name,
    best,
    DENSE_RANK() OVER (PARTITION BY event_id ORDER BY best DESC) AS rnk
  FROM best_score
)
SELECT
  event_id,
  GROUP_CONCAT(CASE WHEN rnk = 1 THEN participant_name END ORDER BY participant_name SEPARATOR ',') AS first,
  GROUP_CONCAT(CASE WHEN rnk = 2 THEN participant_name END ORDER BY participant_name SEPARATOR ',') AS second,
  GROUP_CONCAT(CASE WHEN rnk = 3 THEN participant_name END ORDER BY participant_name SEPARATOR ',') AS third
FROM ranked
GROUP BY event_id
ORDER BY event_id;