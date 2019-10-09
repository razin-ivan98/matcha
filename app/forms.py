from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, SubmitField
from wtforms.validators import DataRequired, Length

class SignInForm(FlaskForm):
    name = StringField('Name', [DataRequired(), Length(max=30)])
    password = PasswordField('Password', [DataRequired()])
    submit = SubmitField('Submit', [DataRequired()])

class SignUpForm(FlaskForm):
    name = StringField('Name', [DataRequired(), Length(max=30)])
    password = PasswordField('Password', [DataRequired()])
    confirm_password = PasswordField('ConfirmPassword', [DataRequired()])
    submit = SubmitField('Submit', [DataRequired()])
    