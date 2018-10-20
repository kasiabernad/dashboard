WITH sum as (
  SELECT
    loads.id AS load,
    loads.start_location AS location,
    sum(packages.weight) AS total_weight
  FROM loads
  INNER JOIN packages ON loads.id = packages.load_id
  GROUP BY location, load
)

SELECT load, location, total_weight
	FROM sum
	WHERE total_weight < 10000;
