from flask import render_template, flash, redirect, session, request
from app import app
from app.forms import SignInForm
from app.forms import SignUpForm

from app.models.posts import Posts
from app.models.sign_in import SignIn
from app.models.sign_up import SignUp

from werkzeug.datastructures import MultiDict

import json


@app.route('/')
@app.route('/index', methods=['GET'])
def index():
    if 'signed_user' in session:
        return json.dumps({
            'answer': True,
            'username': session['signed_user']
        })
    else
        return json.dumps({
            'answer': False
        })


# @app.route('/sign_in', methods= ['GET'])
# def sign_in_get():
#     form = SignInForm()
#     return render_template('sign_in.html',
#         title = 'Sign In',
#         form = form)


@app.route('/api/sign_in', methods=['POST'])
def sign_in_post():
    form = SignInForm()
    if True:#validate
        res = SignIn().sign_in(form.login.data, form.password.data)
        session['signed_user'] = res['username']
    else:
        res = {'answer': False}
    return json.dumps(res)

# @app.route('/sign_up', methods=['GET'])
# def sign_up_get():
#     form = SignUpForm()
#     return render_template('sign_up.html',
#         title = 'Sign Up',
#         form = form)

@app.route('/api/sign_up', methods=['POST'])
def sign_up_post():
    form = SignUpForm()
    # print(form.login.data)
    # print(form.password.data)
    # print(form.confirm_password.data)
    # print(form.validate())
    if form.password.data == form.confirm_password.data:#validate
        res = SignUp().sign_up(form.login.data, form.password.data)
    else:
        res = False
    return json.dumps({ 'answer': res })
