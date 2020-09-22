from flask_wtf import FlaskForm
from flask_wtf.file import FileField, FileAllowed, FileRequired
from wtforms import StringField, PasswordField, SubmitField, SelectField, FloatField
from wtforms.validators import DataRequired, Length, Regexp

class SignInForm(FlaskForm):
    login = StringField('login', [DataRequired(), Length(max=64)])
    password = PasswordField('password', [DataRequired(), Length(max=64)])

class SignUpForm(FlaskForm):
    login = StringField('login', [DataRequired(), Length(max=64)])
    password = PasswordField('password', [DataRequired(), Length(min=8, max=64),
                                            Regexp('\w+'), Regexp('.*\d.*'),
                                            Regexp('.*[a-zA-Z].*')])
    confirm_password = PasswordField('confirm_password', [DataRequired(), Length(max=64)])

class NewMessageForm(FlaskForm):
    friend = StringField('friend', [DataRequired(), Length(max=64)])
    curr_message = StringField('curr_message', [DataRequired(), Length(max=1024)])
    
class InputDataForm(FlaskForm):
    firstname = StringField('firstname', [DataRequired(), Length(max=64)])
    lastname = StringField('lastname', [DataRequired(), Length(max=64)])
    email = StringField('email', [DataRequired(), Length(max=64)])
    gender = SelectField('gender', choices=[
        ('Male', 'Male'),
        ('Female', 'Female'),
    ])
    orientation = SelectField('orientation', choices=[
        ('Natural', 'Natural'),
        ('Bisexual', 'Bisexual'),
        ('Gomosexual', 'Gomosexual'),
    ])
    interests = StringField('interests', [Length(max=1024)])

class UploadForm(FlaskForm):
    file = FileField('image', validators=[
        FileRequired(),
        FileAllowed(['jpg', 'png', 'gif'], 'Images only!')
    ])

class SetGeoForm(FlaskForm):
    latitude = FloatField()
    longitude = FloatField()

class ChangePassForm(FlaskForm):
    oldPass = PasswordField('password', [DataRequired(), Length(max=64)])
    newPass = PasswordField('password', [DataRequired(), Length(min=8, max=64),
                                            Regexp('\w+'), Regexp('.*\d.*'),
                                            Regexp('.*[a-zA-Z].*')])
    repeatPass = PasswordField('password', [DataRequired(), Length(max=64)])

class PasswordRecoveryForm(FlaskForm):
    id = StringField('id', [DataRequired(), Length(max=64)])
    oldPass = PasswordField('password', [DataRequired(), Length(max=64)])
    newPass = PasswordField('password', [DataRequired(), Length(min=8, max=64),
                                            Regexp('\w+'), Regexp('.*\d.*'),
                                            Regexp('.*[a-zA-Z].*')])
    repeatPass = PasswordField('password', [DataRequired(), Length(max=64)])

class BioForm(FlaskForm):
    text = StringField('text', [Length(max=4096)])