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

from itertools import chain


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
        

    def get_all_users(self, login):
        cursor = self.db.cursor(dictionary=True)
        params = (login,)
        cursor.execute("SELECT * FROM users WHERE (name != %s)", params)
        res = cursor.fetchall()

        cursor = self.db.cursor(dictionary=False)
        params = (login, )
        cursor.execute("SELECT blocked_user FROM blacklist WHERE (user = %s)", params)
        blacklist = list(chain.from_iterable(cursor.fetchall()))

        users = res

        for user in users:
            if user['name'] in blacklist:
                user['name'] = False
            del user['password']
            del user['email']
            user['liked'] = self.is_liked(login, user['name'])
            user['liked_me'] = self.is_liked(user['name'], login)
            
            user['online'] = user['online'].strftime("%d-%m-%Y %H:%M:%S")

            del user['image1']
            del user['image2']
            del user['image3']
            del user['image4']
            del user['image5']
        return (list(filter(lambda x: x['name'] != False , users)))

    def upload_image(self, filename, login):
        cursor = self.db.cursor(dictionary=True)
        params = (login, )
        cursor.execute("SELECT * FROM users WHERE name=%s", params)
        res = cursor.fetchall()
        params = (filename, login,)
        i = 1
        while (i < 6):
            if res[0]['image' + str(i)] == None:
                cursor.execute("UPDATE users SET image%s" % (str(i)) + "=%s WHERE name=%s", params)
                params = (login,)
                cursor.execute("UPDATE users SET rating = rating + 5 WHERE name=%s", params)
                break
            i += 1
            if i == 6:
                return False
        params = (filename, login,)
        cursor.execute("UPDATE users SET register_image=1, avatar=%s WHERE name=%s", params)
        return True


    def get_avatar(self, login):
        cursor = self.db.cursor()
        params = (login,)
        cursor.execute("SELECT avatar FROM users WHERE name=%s", params)
        res = cursor.fetchall()
        return (res[0][0])

    def get_user_info(self, login, signed_user):
        cursor = self.db.cursor(dictionary=True)
        params = (login,)
        cursor.execute("SELECT * FROM users WHERE name=%s", params)
        res = cursor.fetchall()
        if cursor.rowcount == 0:
            return False
        res = res[0]
        del res['password']
        res['online'] = res['online'].strftime("%d-%m-%Y %H:%M:%S")
        res['images'] = [item for item in[
            {'url': res['image1'], 'id': 1},
            {'url': res['image2'], 'id': 2},
            {'url': res['image3'], 'id': 3},
            {'url': res['image4'], 'id': 4},
            {'url': res['image5'], 'id': 5},
        ] if item['url'] ]

        del res['image1']
        del res['image2']
        del res['image3']
        del res['image4']
        del res['image5']

        res['liked'] = self.is_liked(signed_user, login)
        res['liked_me'] = self.is_liked(login, signed_user)

        return res
        
    def is_liked(self, liker, liked):
        cursor = self.db.cursor()
        params = (liker, liked,)
        cursor.execute("SELECT * FROM likes WHERE liker=%s AND liked=%s AND type='like'", params)
        res = cursor.fetchall()
        if len(res) > 0:
            return True
        return False
    
    def like(self, liker, liked):
        cursor = self.db.cursor()
        params = (liker, liked,)
        cursor.execute("DELETE FROM likes WHERE liker=%s AND liked=%s", params)
        params = (liker, liked, "like")
        cursor.execute("INSERT INTO likes (liker, liked, date, got, type) VALUES (%s, %s, NOW(), 0, %s)", params)
        params = (liked,)
        cursor.execute("UPDATE users SET rating = rating + 10 WHERE name=%s", params)


    def unlike(self, liker, liked):
        cursor = self.db.cursor()
        params = (liker, liked)
        cursor.execute("DELETE FROM likes WHERE liker=%s AND liked=%s", params)
        params = (liker, liked, "unlike")
        cursor.execute("INSERT INTO likes (liker, liked, date, got, type) VALUES (%s, %s, NOW(), 0, %s)", params)
        params = (liked,)
        cursor.execute("UPDATE users SET rating = rating - 10 WHERE name=%s", params)

    def get_likes(self, liked):
        cursor = self.db.cursor(dictionary=True)
        params = (liked,)
        cursor.execute("SELECT l.id, l.liker, l.liked, l.got, l.type, DATE_FORMAT(l.date,'%d-%m-%Y') date, u.firstname, u.lastname FROM likes l  INNER JOIN users u ON u.name = l.liker WHERE l.liked=%s", params)
        res = cursor.fetchall()
        return res

    def get_unread_likes_count(self, liked):
        cursor = self.db.cursor()
        params = (liked,)
        cursor.execute("SELECT COUNT(*) FROM likes WHERE liked=%s AND got=0", params)
        res = cursor.fetchall()[0][0]
        return res

    def get_unread_guests(self, user):
        cursor = self.db.cursor()
        params = (user,)
        cursor.execute("SELECT COUNT(*) FROM guests WHERE visited_user=%s AND got=0", params)
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
        cursor.execute("UPDATE users SET register_geo=1, latitude=%s, longitude=%s, location=%s WHERE name=%s", params)

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
        msg.html = '<h1>Password recovery for %s</h1><a href="http://localhost:8080/#/password_recovery/%s">Link</a>' % (user, id,)
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
        
    def delete_image(self, user, id):
        if int(id) < 1 or int(id) > 5:
            return False
        cursor = self.db.cursor()
        params = (user,)
        
        cursor.execute("UPDATE users SET image%s " % (id) + "=Null WHERE name = %s", params)
        cursor.execute("UPDATE users SET rating = rating - 5 WHERE name=%s", params)

        return True
    
    def set_avatar(self, user, id):
        if int(id) < 1 or int(id) > 5:
            return False
        cursor = self.db.cursor()
        params = (user,)
        
        cursor.execute("SELECT image%s from users" % (id) + " WHERE name = %s", params)
        res = cursor.fetchall()
        params = (res[0][0], user,)
        cursor.execute("UPDATE users SET avatar = %s WHERE name = %s", params)

        return True

    def change_bio(self, user, bio):
        cursor = self.db.cursor()
        params = (bio, user)
        
        cursor.execute("UPDATE users SET biography = %s WHERE name = %s", params)

        return True

    def end_registration(self, user):
        cursor = self.db.cursor()
        params = (user,)
        cursor.execute("SELECT * FROM users WHERE register_data=1 AND register_image=1 AND register_geo=1 AND name=%s", params)

        cursor.fetchall()
        if (cursor.rowcount == 0):
            return False
        cursor.execute("UPDATE users SET rating = rating + 20 WHERE name=%s", params)
        return True

    def report(self, user, reported_user):
        msg = Message('REPORT', sender='chorange.matcha.manager@gmail.com', recipients=['chorange.matcha.manager@gmail.com'])
        msg.body = 'REPORT'
        msg.html = '<h1>User %s reported %s</h1>' % (user, reported_user)
        mail.send(msg)

    def block_user(self, user, blocked_user):
        cursor = self.db.cursor()
        params = (user, blocked_user)
        cursor.execute("SELECT * FROM blacklist WHERE user=%s AND blocked_user=%s", params)
        res = cursor.fetchall()
        if cursor.rowcount == 0:
            cursor.execute("INSERT INTO blacklist (user, blocked_user) VALUES (%s, %s)", params)

    def get_blacklist(self, user):
        cursor = self.db.cursor(dictionary=True)
        params = (user,)
        cursor.execute("SELECT blocked_user AS name FROM blacklist WHERE user=%s", params)
        res = cursor.fetchall()
        for user in res:
            name = user['name']
            params = (name,)
            cursor.execute("SELECT * FROM users WHERE name=%s", params)
            data = cursor.fetchall()[0]
            user['firstname'] = data['firstname']
            user['lastname'] = data['lastname']
        return res

    def unblock(self, user, unblocked_user):
        cursor = self.db.cursor()
        params = (user, unblocked_user)
        cursor.execute("DELETE FROM blacklist WHERE user=%s AND blocked_user=%s", params)

    def visit(self, user, visited_user):
        cursor = self.db.cursor()
        params = (user, visited_user)
        cursor.execute("INSERT INTO guests (user, visited_user) VALUES (%s, %s)", params)

    def get_guests(self, user):
        cursor = self.db.cursor(dictionary=True)
        params = (user,)
        cursor.execute("SELECT * FROM guests WHERE visited_user=%s", params)
        res = cursor.fetchall()
        for user in res:
            name = user['user']
            params = (name,)
            del user['user']
            user['name'] = name
            cursor.execute("SELECT * FROM users WHERE name=%s", params)
            data = cursor.fetchall()[0]
            user['firstname'] = data['firstname']
            user['lastname'] = data['lastname']
        return res

    def guest_read(self, id, signed_user):
        cursor = self.db.cursor()
        params = (id, signed_user,)
        cursor.execute("DELETE FROM guests WHERE id=%s AND visited_user=%s", params)


