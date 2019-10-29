from app.models.model import Model
from flask import send_from_directory
import os

class User(Model):
    def is_confirmed(self, login):
        cursor = self.db.cursor()
        params = (login,)
        cursor.execute("SELECT confirmed FROM users WHERE name = %s", params)
        res = cursor.fetchall()
        if res[0][0] == 1:
            return  True
        else:
            return  False
        # if cursor.rowcount > 0:  
        #     return ({'answer': True, 'username': res[0][0]})
        # else:
        

    def get_recomended_users(self, login):
        cursor = self.db.cursor(dictionary=True)
        params = (login,)
        cursor.execute("SELECT * FROM users WHERE name != %s", params)
        
        res = cursor.fetchall()
        
        return (res)

    def upload_image(self, filename, login):
        cursor = self.db.cursor()
        params = (filename, login)
        cursor.execute("UPDATE users SET avatar=%s WHERE name=%s", params)