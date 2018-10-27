WITH RECURSIVE creators(creator_id, creator_firstname, creator_surname, driver) AS (
  SELECT
    cr.id,
    cr.firstname,
    cr.surname,
    (
      select id
      from users drs
      where jobs.load_id = loads.id and loads.user_id =  drs.id
    ) as driver_id
  FROM users cr
  INNER JOIN jobs ON cr.id = jobs.user_id
  INNER JOIN loads on jobs.load_id = loads.id
  UNION
  SELECT
    creators.creator_id,
    creators.creator_firstname,
    creators.creator_surname,
    (
      select id
      from users drs
      where jobs.load_id = loads.id and loads.user_id = drs.id
    ) as driver_id
  FROM creators
  INNER JOIN jobs ON creators.creator_id = jobs.user_id
  INNER JOIN loads on jobs.load_id = loads.id
)
SELECT
  creators.creator_firstname || ' ' || creators.creator_surname as creator,
  drivers.firstname || ' ' || drivers.surname as driver
FROM creators
INNER JOIN users drivers ON creators.driver = drivers.id;
