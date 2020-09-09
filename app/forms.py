from flask_wtf import FlaskForm
from flask_wtf.file import FileField, FileAllowed, FileRequired
from wtforms import StringField, PasswordField, SubmitField, SelectField, FloatField
from wtforms.validators import DataRequired, Length
from flask_uploads import UploadSet, IMAGES

class SignInForm(FlaskForm):
    login = StringField('login', [DataRequired(), Length(max=64)])
    password = PasswordField('password', [DataRequired()])

class SignUpForm(FlaskForm):
    login = StringField('login', [DataRequired(), Length(max=64)])
    password = PasswordField('password', [DataRequired()])
    confirm_password = PasswordField('confirm_password', [DataRequired()])

class NewMessageForm(FlaskForm):
    friend = StringField('friend', [DataRequired(), Length(max=64)])
    curr_message = StringField('curr_message', [DataRequired()])
    
class InputDataForm(FlaskForm):
    firstname = StringField('firstname', [DataRequired(), Length(max=64)])
    lastname = StringField('lastname', [DataRequired(), Length(max=64)])
    email = StringField('email', [DataRequired(), Length(max=64)])
    gender = SelectField('gender', choices=[
        ('Male', 'Male'),
        ('Female', 'Female'),
        ('Transexual', 'Transexual'),
        ('Teapot', 'Teapot')
    ])
    orientation = SelectField('orientation', choices=[
        ('Natural', 'Natural'),
        ('Bisexual', 'Bisexual'),
        ('Gomosexual', 'Gomosexual'),
        ('Pidor', 'Pidor')
    ])

images = UploadSet('images', IMAGES)

class UploadForm(FlaskForm):
    file = FileField('image', validators=[
        FileRequired(),
        FileAllowed(images, 'Images only!')
    ])

class SetGeoForm(FlaskForm):
    latitude = FloatField()
    longitude = FloatField()

class ChangePassForm(FlaskForm):
    oldPass = PasswordField('password', [DataRequired()])
    newPass = PasswordField('password', [DataRequired()])
    repeatPass = PasswordField('password', [DataRequired()])

class PasswordRecoveryForm(FlaskForm):
    id = StringField('id', [DataRequired(), Length(max=64)])
    oldPass = PasswordField('password', [DataRequired()])
    newPass = PasswordField('password', [DataRequired()])
    repeatPass = PasswordField('password', [DataRequired()])