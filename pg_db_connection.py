import psycopg2 as pg2

class DataBase:
    __instance = None

    def __new__(cls, *args, **kwargs):
        if cls.__instance is None:
            cls.__instance = super().__new__(cls)
        return cls.__instance

    def __init__(self, host, port, database, user, password):
        self.connection = pg2.connect(
            host=host,
            port=port,
            database=database,
            user=user,
            password=password
        )

    def insert_data(self, query):
        with self.connection.cursor() as cursor:
            try:
                cursor.execute(query)
                self.connection.commit()
            except Exception as err:
                self.connection.rollback()
                print(f"Ошибка при добавлении строки в БД: {repr(err)}")

    def close_connection(self):
        self.connection.close()