import mysql.connector
from flask import Flask



class Model():
    def __init__(self):
        self.db = mysql.connector.connect(
           # host='192.168.99.140',
           host='172.17.0.2',
            user='root',
            # passwd='root',
            passwd='my-secret-pw',
            database='matcha_db',
            charset='utf8mb4',
            collation='utf8mb4_unicode_ci',
            autocommit=True
        )