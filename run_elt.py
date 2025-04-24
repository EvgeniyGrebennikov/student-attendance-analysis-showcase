import pandas as pd
import os
import configparser
from dataset_transformation import get_dataframe
from pg_db_connection import DataBase

pd.set_option('display.max_columns', 15)

dirname = os.path.dirname(__file__)

config = configparser.ConfigParser()
config.read(os.path.join(dirname, 'config.ini'))


file = os.path.join(dirname,config['Filepath']['file_name'])

# Считываем файл с данными по студентам и возвращаем в виде датафрейма
attendance_df = get_dataframe(file)

# Сортируем данные по дате посещения
attendance_df.sort_values('event_date', inplace=True)

# Считываем данные для подключения к БД (файл конфиг)
HOST = config['Database']['HOST']
PORT = config['Database']['PORT']
USER = config['Database']['USER']
DATABASE = config['Database']['DATABASE']
PASSWORD = config['Database']['PASSWORD']

# Создаем объект для подключения к БД (класса DataBase)
db = DataBase(host=HOST, port=PORT, user=USER, database=DATABASE, password=PASSWORD)

for i, row in attendance_df.iterrows():
    event_id = row['event_id']
    event_date = row['event_date']
    customer_id = row['customer_id']
    is_attend = row['is_attend']
    group_ids = row['group_ids']
    teacher_ids = row['teacher_ids']
    attendance_id = row['attendance_id']

    query = f"""
                insert into students_attendance(event_id, event_date, customer_id, is_attend, group_ids, teacher_ids, attendance_id)
                values({event_id}, '{event_date}', {customer_id}, {is_attend}, {group_ids}, {teacher_ids}, {attendance_id})
            """

    db.insert_data(query)




