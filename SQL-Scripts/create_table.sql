drop table if exists students_attendance;

create table students_attendance (
	id serial primary key not null,
	event_id int,
	event_date date,
	customer_id smallint,
	is_attend smallint,
	group_ids smallint,
	teacher_ids smallint,
	attendance_id smallint
);