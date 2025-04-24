with daily_customers as (
	select
		event_date,
		count(distinct customer_id) as dau
	from students_attendance
	where is_attend = 1
	group by event_date
)
	select
		dc1.event_date,
		dc1.dau,
		round(avg(dc1.dau) over(order by dc1.event_date), 2) as moving_avg_dau,
			(select
				percentile_cont(0.5) within group(order by dc2.dau)
			from daily_customers dc2
			where dc2.event_date <= dc1.event_date) as moving_median_dau
	from daily_customers dc1
	order by event_date