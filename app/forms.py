from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, SubmitField
from wtforms.validators import DataRequired, Length

class SignInForm(FlaskForm):
    login = StringField('login', [DataRequired(), Length(max=30)])
    password = PasswordField('password', [DataRequired()])

class SignUpForm(FlaskForm):
    login = StringField('login', [DataRequired(), Length(max=30)])
    password = PasswordField('password', [DataRequired()])
    confirm_password = PasswordField('confirm_password', [DataRequired()])
    