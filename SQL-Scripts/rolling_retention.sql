with cohort_info as (
	select
		to_char(min(event_date) over(partition by customer_id), 'yyyy-mm') as ym_cohort,
		event_date - min(event_date) over(partition by customer_id) as diff,
		customer_id
	from students_attendance
	where is_attend = 1
)
	select
		ym_cohort,
		round(count(distinct case when diff >= 0 then customer_id end) * 100.0 / count(distinct case when diff >= 0 then customer_id end), 2) as "0 day",
		round(count(distinct case when diff >= 1 then customer_id end) * 100.0 / count(distinct case when diff >= 0 then customer_id end), 2) as "1 day",
		round(count(distinct case when diff >= 3 then customer_id end) * 100.0 / count(distinct case when diff >= 0 then customer_id end), 2) as "3 day",
		round(count(distinct case when diff >= 7 then customer_id end) * 100.0 / count(distinct case when diff >= 0 then customer_id end), 2) as "7 day",
		round(count(distinct case when diff >= 14 then customer_id end) * 100.0 / count(distinct case when diff >= 0 then customer_id end), 2) as "14 day",
		round(count(distinct case when diff >= 30 then customer_id end) * 100.0 / count(distinct case when diff >= 0 then customer_id end), 2) as "30 day"
	from cohort_info
	group by ym_cohort
	order by ym_cohort