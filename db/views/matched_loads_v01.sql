SELECT DISTINCT
  l.id AS id,
  sum(p.weight) AS total_weight
FROM loads l, vehicles v, packages p
WHERE l.id = p.load_id
GROUP BY l.id, v.capacity
HAVING v.capacity > sum(p.weight)
