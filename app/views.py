from flask import render_template, flash, redirect, session
from app import app
from app.forms import SignInForm
from app.forms import SignUpForm

from app.models.posts import Posts
from app.models.sign_in import SignIn
from app.models.sign_up import SignUp


@app.route('/')

@app.route('/index')
def index():
    posts = Posts().get_posts()
    return render_template("index.html",
        user = 'Ivan',
        posts = posts)


@app.route('/sign_in', methods= ['GET'])
def sign_in_get():
    form = SignInForm()
    return render_template('sign_in.html',
        title = 'Sign In',
        form = form)


@app.route('/sign_in', methods=['POST'])
def sign_in_post():
    form = SignInForm()
    if form.validate():
        res = SignIn().sign_in(form.name.data, form.password.data)
        if res == True:
            return redirect('/index')
        else:
            return redirect('sign_in')

@app.route('/sign_up', methods=['GET'])
def sign_up_get():
    form = SignUpForm()
    return render_template('sign_up.html',
        title = 'Sign Up',
        form = form)

@app.route('/sign_up', methods=['POST'])
def sign_up_post():
    form = SignUpForm()
    if form.validate() and\
            form.password.data == form.confirm_password.data:
        res = SignUp().sign_up(form.name.data, form.password.data)
       
        if res == True:
            return redirect('/index')
        else:
            return redirect('/sign_in')
    else:
        return redirect('/sign_in')
