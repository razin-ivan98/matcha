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
        for user in res:
            del user['password']
            user['liked'] = self.is_liked(login, user['name'])
            user['liked_me'] = self.is_liked(user['name'], login)
        return (res)

    def upload_image(self, filename, login):
        cursor = self.db.cursor()
        params = (filename, login,)
        cursor.execute("UPDATE users SET avatar=%s WHERE name=%s", params)

    def get_avatar(self, login):
        cursor = self.db.cursor()
        params = (login,)
        cursor.execute("SELECT avatar FROM users WHERE name=%s", params)
        res = cursor.fetchall()
        return (res[0][0])

    def get_user_info(self, login):
        cursor = self.db.cursor(dictionary=True)
        params = (login,)
        cursor.execute("SELECT * FROM users WHERE name=%s", params)
        res = cursor.fetchall()[0]
        del res['password']
        return res
        
    def is_liked(self, liker, liked):
        cursor = self.db.cursor()
        params = (liker, liked,)
        cursor.execute("SELECT * FROM likes WHERE liker=%s AND liked=%s", params)
        res = cursor.fetchall()
        if len(res) > 0:
            return True
        return False
    
    def like(self, liker, liked):
        cursor = self.db.cursor()#проверка, есть ли такой юзер
        params = (liker, liked,)
        cursor.execute("INSERT INTO likes (liker, liked, date) VALUES (%s, %s, NOW())", params)

    def unlike(self, liker, liked):
        cursor = self.db.cursor()#проверка, есть ли такой юзер
        params = (liker, liked,)
        cursor.execute("DELETE FROM likes WHERE liker=%s AND liked=%s", params)