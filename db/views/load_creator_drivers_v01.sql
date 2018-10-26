select creators.firstname || ' ' ||  creators.surname as creator,
	(
    select drivers.firstname || ' ' || drivers.surname as driver
		from users drivers
    where jobs.load_id = loads.id and loads.user_id =  drivers.id
	),
  loads.id as load,
  jobs.id as job
	from
		users creators
  inner join jobs ON creators.id = jobs.user_id
  inner join loads on jobs.load_id = loads.id
