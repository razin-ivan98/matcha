from app.models.model import Model
import hashlib

class InputData(Model):
    def input_data(self, username, firstname, lastname, email, gender, orientation, interests):
        cursor = self.db.cursor()

        params = (
            firstname,
            lastname,
            email,
            gender,
            orientation,
            interests,
            username
        )
        cursor.execute("UPDATE users SET register_data=1, firstname=%s, lastname=%s, email=%s, gender=%s, orientation=%s, confirmed=1, interests=%s WHERE name=%s", params)
        # res = cursor.fetchall()
        # if cursor.rowcount > 0:  
        #     return ({'answer': True, 'username': res[0][0]})
        # else:
        #     return {'answer': False}
        return True
