WITH sum as (
  SELECT
    loads.id,
    loads.start_date AS startdate,
    loads.start_location AS location,
    sum(packages.weight) AS total_weight
  FROM loads
  INNER JOIN packages ON loads.id = packages.load_id
  GROUP BY location, loads.id, startdate
)

SELECT id, startdate, location, total_weight
	FROM sum
	WHERE total_weight < 10000;
