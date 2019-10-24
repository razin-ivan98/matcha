from app.models.model import Model
import hashlib

class SignIn(Model):
    def sign_in(self, login, password):
        cursor = self.db.cursor()
        params = (
            login,
            hashlib.sha3_512(password.encode('utf-8')).hexdigest()
        )
        cursor.execute("SELECT name FROM users WHERE name = %s AND password = %s", params)
        username = cursor.fetchall()[0][0]
        if cursor.rowcount > 0:
            return ({'answer': True, 'username': username})
        else:
            return {'answer': False}
