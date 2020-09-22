from app.models.model import Model
from app.models.user import User

class Chat(Model):
    def get_my_chats(self, username):
        cursor = self.db.cursor(dictionary=True)
        params = (username, username,)
        cursor.execute("SELECT * FROM dialogs WHERE friend_1 = %s OR friend_2 = %s ORDER BY last_activity DESC", params)
        res = cursor.fetchall()
        ret = []
        
        for elem in res:
            ret_elem = {}
            friend_name = elem['friend_2'] if elem['friend_1'] == username else elem['friend_1'] 
            friend = User().get_user_info(friend_name, friend_name)
            ret_elem['friend'] = friend
            ret_elem['unread'] = 0 if elem['last_activist'] == username else elem['unread']
            ret_elem['last_activity'] = elem['last_activity'].strftime("%d-%m-%Y %H:%M:%S")
            ret.append(ret_elem)
        return  ret
    
    def create_dialog(self, username, friend):
        cursor = self.db.cursor()
        params = (username, friend,)
        cursor.execute("SELECT * FROM likes WHERE liked=%s AND liker=%s", params)
        is_liked = cursor.fetchall()
        params = (username, friend, username, friend)
        cursor.execute("SELECT * FROM dialogs WHERE (friend_1=%s AND friend_2=%s) OR (friend_2=%s AND friend_1=%s)", params)
        is_dialog = cursor.fetchall()
        params = (username, friend, username,)
        if len(is_liked) > 0 and len(is_dialog) == 0:
            cursor.execute("INSERT INTO dialogs (friend_1, friend_2, last_activity, last_activist, unread) VALUES (%s, %s, NOW(), %s,0)", params)
        params = (username,)
        cursor.execute("UPDATE users SET rating = rating + 10 WHERE name=%s", params)
        params = (friend,)
        cursor.execute("UPDATE users SET rating = rating + 10 WHERE name=%s", params)
        

    def delete_dialog(self, username, unfriended):
        cursor = self.db.cursor()
        params = (username, unfriended, username, unfriended)
        cursor.execute("DELETE FROM dialogs WHERE (friend_1=%s AND friend_2=%s) OR (friend_2=%s AND friend_1=%s)", params)

    def get_unread_chats(self, username):
        cursor = self.db.cursor()
        params = (username, username, username,)
        cursor.execute("SELECT * FROM dialogs WHERE (friend_1=%s OR friend_2=%s) AND NOT last_activist=%s AND NOT unread=0", params)
        ret = cursor.fetchall()
        return len(ret)

    def new_message(self, author, adresant, message):
        cursor = self.db.cursor()
        params = (author, adresant, message,)
        cursor.execute("INSERT INTO messages (author, adresant, date, message) VALUES (%s, %s, NOW(), %s)", params)
        params = (author, author, adresant, adresant, author,)
        cursor.execute("UPDATE dialogs SET unread=unread+1, last_activist=%s, last_activity=NOW() WHERE (friend_1=%s AND friend_2=%s) OR (friend_1=%s AND friend_2=%s)", params)

    def get_messages(self, author, adresant):
        cursor = self.db.cursor(dictionary=True)
        params = (author, adresant, adresant, author,)
        cursor.execute("SELECT * FROM messages WHERE (author=%s AND adresant=%s) OR (author=%s AND adresant=%s) ORDER BY date ASC", params)
        
        res = cursor.fetchall()
        for elem in res:
            tmp = elem['date']
            elem['date'] = tmp.strftime("%d-%m-%Y %H:%M:%S")

        params = (adresant, author, adresant, adresant, author,)
        cursor.execute("UPDATE dialogs SET unread=0 WHERE last_activist=%s AND ((friend_1=%s AND friend_2=%s) OR (friend_1=%s AND friend_2=%s))", params)
        return res

    def get_new_messages(self, author, adresant, last):
        cursor = self.db.cursor(dictionary=True)
        params = (last, author, adresant, adresant, author,)
        cursor.execute("SELECT * FROM messages WHERE id>%s AND ((author=%s AND adresant=%s) OR (author=%s AND adresant=%s)) ORDER BY date ASC", params)
        
        res = cursor.fetchall()
        for elem in res:
            tmp = elem['date']
            elem['date'] = tmp.strftime("%d-%m-%Y %H:%M:%S")

        params = (adresant, author, adresant, adresant, author,)
        cursor.execute("UPDATE dialogs SET unread=0 WHERE last_activist=%s AND ((friend_1=%s AND friend_2=%s) OR (friend_1=%s AND friend_2=%s))", params)
        return res

    def get_unread_by_friend(self, author, adresant):
        cursor = self.db.cursor(dictionary=True)
        params = (author, author, adresant, adresant, author,)
        cursor.execute("SELECT * FROM dialogs WHERE last_activist=%s AND ((friend_1=%s AND friend_2=%s) OR (friend_1=%s AND friend_2=%s))", params)
        res = cursor.fetchall()
        if (len(res) == 0):
            return 0
        else:
            return res[0]['unread']
    
    def get_chat_with(self, signedUser, user):
        cursor = self.db.cursor(dictionary=True)
        params = (signedUser, user, user, signedUser)
        cursor.execute("SELECT * FROM dialogs WHERE ((friend_1=%s AND friend_2=%s) OR (friend_1=%s AND friend_2=%s))", params)
        res = cursor.fetchall()
        if (len(res) == 0):
            return False
        return User().get_user_info(user, signedUser)


