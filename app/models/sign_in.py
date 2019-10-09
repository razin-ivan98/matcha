from app.models.model import Model
import hashlib

class SignIn(Model):
    def sign_in(self, name, password):
        cursor = self.db.cursor()
        params = (
            name,
            hashlib.sha3_512(password.encode('utf-8')).hexdigest()
        )
        cursor.execute("SELECT id FROM users WHERE name = %s AND password = %s", params)
        cursor.fetchone()
        if cursor.rowcount > 0:
            return True
        else:
            return False
