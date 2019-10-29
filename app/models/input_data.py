from app.models.model import Model
import hashlib

class InputData(Model):
    def input_data(self, username, firstname, lastname, email, gender, orientation):
        cursor = self.db.cursor()
        params = (
            firstname,
            lastname,
            email,
            gender,
            orientation,
            username
        )
        cursor.execute("UPDATE users SET firstname=%s, lastname=%s, email=%s, gender=%s, orientation=%s, confirmed=1 WHERE name=%s", params)
        # res = cursor.fetchall()
        # if cursor.rowcount > 0:  
        #     return ({'answer': True, 'username': res[0][0]})
        # else:
        #     return {'answer': False}
        return True
