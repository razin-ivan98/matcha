from flask import Flask
from flask_mail import Mail
from flask_uploads import configure_uploads, UploadSet, IMAGES

app = Flask(__name__, static_folder='static/dist')
app.config.from_object('config')

app.config['WTF_CSRF_ENABLED'] = False

mail_settings = {
    "MAIL_SERVER": 'smtp.gmail.com',
    "MAIL_PORT": 465,
    "MAIL_USE_TLS": False,
    "MAIL_USE_SSL": True,
    "MAIL_USERNAME": 'chorange.matcha.manager@gmail.com',
    "MAIL_PASSWORD": '1998VONdarm'
}

app.config.update(mail_settings)
mail = Mail(app)


from app import views