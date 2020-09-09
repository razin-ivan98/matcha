from app.models.model import Model
from flask import send_from_directory
import os

import requests
import json
import hashlib

import random

import string

from flask_mail import Message
from app import mail


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
        

    def get_all_users(self, login):
        cursor = self.db.cursor(dictionary=True)
        params = (login,)
        cursor.execute("SELECT * FROM users WHERE (name != %s)", params)
        res = cursor.fetchall()
        for user in res:
            del user['password']
            user['liked'] = self.is_liked(login, user['name'])
            user['liked_me'] = self.is_liked(user['name'], login)
            user['online'] = user['online'].strftime("%d-%m-%Y %H:%M:%S")
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
        res['online'] = res['online'].strftime("%d-%m-%Y %H:%M:%S")
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
        cursor.execute("INSERT INTO likes (liker, liked, date, got) VALUES (%s, %s, NOW(), 0)", params)

    def unlike(self, liker, liked):
        cursor = self.db.cursor()#проверка, есть ли такой юзер
        params = (liker, liked,)
        cursor.execute("DELETE FROM likes WHERE liker=%s AND liked=%s", params)

    def get_likes(self, liked):
        cursor = self.db.cursor(dictionary=True)
        params = (liked,)
        cursor.execute("SELECT l.id, l.liker, l.liked, l.got, DATE_FORMAT(l.date,'%d-%m-%Y') date, u.firstname, u.lastname FROM likes l  INNER JOIN users u ON u.name = l.liker WHERE l.liked=%s", params)
        res = cursor.fetchall()
        return res

    def get_unread_likes_count(self, liked):
        cursor = self.db.cursor()
        params = (liked,)
        cursor.execute("SELECT COUNT(*) FROM likes WHERE liked=%s AND got=0", params)
        res = cursor.fetchall()[0][0]
        return res

    def like_read(self, like_id):
        cursor = self.db.cursor()
        params = (like_id,)
        cursor.execute("UPDATE likes SET got=1 WHERE id=%s", params)
        return True

    def set_online(self, user):
        cursor = self.db.cursor()
        params = (user,)
        cursor.execute("UPDATE users SET online=NOW() WHERE name=%s", params)

    def set_geo(self, user, latitude, longitude, ip):
        cursor = self.db.cursor()
        if (latitude == 9999.0):
            res = requests.get("http://api.ipstack.com/%s?access_key=a22621fd5bacdd1cbeade8f719822457" % (ip,))
            res = json.loads(res.content)
            if ('type' in res and res['type'] == None) or ('success' in res and res['success'] == False):
                latitude = 55.755241
                longitude = 37.617779
            else:
                latitude = res.latitude
                longitude = res.longitude
        res = requests.get("https://geocode-maps.yandex.ru/1.x/?apikey=abd98dea-8721-4425-be8a-398bb9fbab30&format=json&geocode=%f,%f" % (longitude, latitude))
        res = json.loads(res.content)
        if ('error' in res or res["response"]["GeoObjectCollection"]["metaDataProperty"]["GeocoderResponseMetaData"]["found"] == "0"):
            params = (55.755241, 37.617779, "Россия, Москва, Красная площадь, 1", user,)
        else:
            location = (res['response']['GeoObjectCollection']['featureMember'][0]['GeoObject']['metaDataProperty']['GeocoderMetaData']['text'])
            params = (latitude, longitude, location, user,)
        cursor.execute("UPDATE users SET latitude=%s, longitude=%s, location=%s WHERE name=%s", params)

    def password_recovery_order(self, user):
        cursor = self.db.cursor()
        params = (user, )
        cursor.execute("SELECT * FROM users WHERE name=%s", params)
        res = cursor.fetchall()
        if (cursor.rowcount == 0):
            return False
        cursor.execute("SELECT * FROM password_recovery WHERE user=%s", params)
        res = cursor.fetchall()
        if (cursor.rowcount > 0):
            cursor.execute("DELETE FROM password_recovery WHERE user=%s", params)
        flag = True
        while flag:
            id = "".join(random.choice(string.ascii_letters) for i in range(32))
            params = (id, )
            cursor.execute("SELECT * FROM password_recovery WHERE id=%s", params)
            cursor.fetchall()
            if (cursor.rowcount == 0):
                flag = False

        params = (user, id,)
        cursor.execute("INSERT INTO password_recovery (user, id, date) VALUES (%s, %s, NOW())", params)
        msg = Message('Link for password recovery', sender='razin-ivan98@ya.ru', recipients=['razin-ivan98@ya.ru'])
        msg.body = 'Password Recovery'
        msg.html = '<h1>Password recovery</h1><a href="http://localhost:8080/#/password_recovery/%s">Link</a>' % (id,)
        mail.send(msg)
        return True

    def change_pass(self, user, old, new):
        cursor = self.db.cursor()
        params = (user, hashlib.sha3_512(old.encode('utf-8')).hexdigest(),)
        cursor.execute("SELECT name FROM users WHERE name = %s AND password = %s", params)
        res = cursor.fetchall()
        if cursor.rowcount == 0:  
            return False
        params = (hashlib.sha3_512(new.encode('utf-8')).hexdigest(), user)
        cursor.execute("UPDATE users SET password = %s WHERE name = %s", params)
        return True
        
    def get_user_by_password_id(self, id):
        cursor = self.db.cursor()
        params = (id,)
        cursor.execute("SELECT user FROM password_recovery WHERE id = %s", params)
        res = cursor.fetchall()
        if (cursor.rowcount == 0):
            return False
        return res[0][0]
        
            
        
