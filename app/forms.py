from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, SubmitField, SelectField
from wtforms.validators import DataRequired, Length

class SignInForm(FlaskForm):
    login = StringField('login', [DataRequired(), Length(max=30)])
    password = PasswordField('password', [DataRequired()])

class SignUpForm(FlaskForm):
    login = StringField('login', [DataRequired(), Length(max=30)])
    password = PasswordField('password', [DataRequired()])
    confirm_password = PasswordField('confirm_password', [DataRequired()])
    
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


