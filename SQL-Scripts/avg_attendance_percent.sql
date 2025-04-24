select
		round(sum(attends) * 100.0 / sum(customers), 2) avg_attendance
	from (
		select
			event_id,
			count(distinct customer_id) as customers,
			sum(is_attend) as attends
		from students_attendance
		group by event_id
	) t1