from app.models.model import Model
import hashlib

class SignUp(Model):
    def sign_up(self, name, password):
        cursor = self.db.cursor()
        params = (
            name,
            hashlib.sha3_512(password.encode('utf-8')).hexdigest()
        )
        cursor.execute("SELECT id FROM users WHERE name = %s", (name,))
        cursor.fetchall()
        if cursor.rowcount == 0:
            cursor.execute("INSERT INTO users(name, password) VALUES(%s, %s)", params)
            return True
        else:
            return False
