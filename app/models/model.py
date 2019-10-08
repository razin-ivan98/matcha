import mysql.connector
from flask import Flask


class Model:
    def __init__(self):
        self.db = mysql.connector.connect(
            host='localhost',
            user='root',
            passwd='',
            database='matcha_db',
            charset='utf8mb4',
            collation='utf8mb4_unicode_ci',
            autocommit=True
        )