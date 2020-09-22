from app.models.model import Model
import hashlib

class SignIn(Model):
    def sign_in(self, login, password):
        cursor = self.db.cursor(dictionary=True)
        params = (
            login,
            hashlib.sha3_512(password.encode('utf-8')).hexdigest()
        )
        cursor.execute("SELECT * FROM users WHERE name = %s AND password = %s", params)
        res = cursor.fetchall()

        if cursor.rowcount > 0:
            register_ended = (res[0]['register_data'] == 1 and res[0]['register_image'] == 1 and res[0]['register_geo'] == 1)
            return ({'answer': True, 'details': 'OK', 'username': res[0]['name'], 'registration_ended': register_ended})
        else:
            return {'answer': False, 'details': 'Login or password is wrong'}
