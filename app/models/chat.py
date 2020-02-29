from app.models.model import Model

class Chat(Model):
    def get_my_chats(username):
        cursor = self.db.cursor()
        params = (username, username,)
        cursor.execute("SELECT * FROM dialogs WHERE friend_1 = %s OR friend_2 = %s ORDER BY last_activity ASC", params)
        res = cursor.fetchall()
        return  res