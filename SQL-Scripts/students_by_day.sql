with customers_by_day as (
	select
		date_part('isodow', event_date) as day_num,
		to_char(event_date, 'day') as day_name,
		count(distinct customer_id) as unique_customers
	from students_attendance
	group by day_num, day_name
)
	select
		day_name,
		unique_customers,
		round(avg(unique_customers) over()) as avg_unique_customers
	from customers_by_day
	order by day_num