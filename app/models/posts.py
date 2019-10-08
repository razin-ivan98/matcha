from app.models.model import Model


class Posts(Model):
    def get_posts(self):
        cursor = self.db.cursor()
        cursor.execute('SELECT u.name, p.body FROM posts p INNER JOIN users u ON u.id=p.user_id')
        data = cursor.fetchall()
        return data