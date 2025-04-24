with pre_dau as (
	select
		event_date,
		count(distinct customer_id) as cnt_customers
	from students_attendance
	where is_attend = 1
	group by event_date
),
dau_info as (
	select
		round(avg(cnt_customers)) as dau
	from pre_dau
),
pre_mau as (
	select
		to_char(event_date, 'yyyy-mm') as ym,
		count(distinct customer_id) as cnt_customers
	from students_attendance
	where is_attend = 1
	group by ym
)
	select
		round(min(dau) * 100.0 / round(avg(cnt_customers)), 2) as sf
	from dau_info, pre_mau
