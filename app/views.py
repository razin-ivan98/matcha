from flask import render_template, flash, redirect, session, request
from app import app
from app.forms import SignInForm
from app.forms import SignUpForm
from app.forms import InputDataForm

from app.models.posts import Posts
from app.models.sign_in import SignIn
from app.models.sign_up import SignUp
from app.models.input_data import InputData

from werkzeug.datastructures import MultiDict

import json


# @app.route('/')
# @app.route('/index', methods=['GET'])
# def index():
#     if 'signed_user' in session:
#         return json.dumps({
#             'answer': True,
#             'username': session['signed_user']
#         })
#     else:
#         return json.dumps({
#             'answer': False
#         })


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
        print (res)
        if res['answer'] == True:
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

@app.route('/api/is_signed', methods=['GET'])
def is_signed():
    if 'signed_user' in session:
        return json.dumps({
            'answer': True,
            'username': session['signed_user']
        })
    else:
        return json.dumps({
            'answer': False
        })

@app.route('/api/sign_out', methods=['GET'])
def sign_out():
    session.clear()
    return json.dumps({ 'answer': True })

@app.route('/api/get_username', methods=['GET'])
def get_username():
    if 'signed_user' in session:
        return json.dumps({
                'answer': True,
                'username': session['signed_user']
            })
    else:
        return json.dumps({
                'answer': False,
                'username': ''
            })

@app.route('/api/input_data', methods=['POST'])
def input_data_post():
    form = InputDataForm()

    # print(form.password.data)
    # print(form.confirm_password.data)
    # print(form.validate())
    # if form.password.data == form.confirm_password.data:#validate
    res = InputData().input_data(session['signed_user'],
                                form.firstname.data, 
                                form.lastname.data,
                                form.email.data,
                                form.gender.data,
                                form.orientation.data)
    # else:
    #     res = False
    return json.dumps({ 'answer': True })