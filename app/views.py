from flask import render_template, flash, redirect
from app import app
from app.forms import LoginForm

from app.models.posts import Posts

@app.route('/')

@app.route('/index')
def index():
    user = { 'nickname': 'Miguel' } # выдуманный пользователь
    # posts = [
    #     {
    #         'author': {'nickname': 'Josef'},
    #         'body': 'Прекрасный день для этой дыры'
    #     },
    #     {
    #         'author': {'nickname': 'Иван'},
    #         'body': 'Идите фсе в жопу'
    #     },
    #     {
    #         'author': {'nickname': 'Benedict'},
    #         'body': 'The Avengers movie was so cool!!'
    #     }
    # ]

    posts = Posts().get_posts()
    print(posts)
    return render_template("index.html",
        user = user,
        posts = posts)


@app.route('/login', methods= ['GET', 'POST'])
def login():
    form = LoginForm()
    if form.validate_on_submit():
        flash('Login requested for OpenID="'+form.openid.data+
            '", remember_me='+str(form.remember_me.data))
        return redirect('/index')
    return render_template('login.html',
        title = 'Sign In',
        form = form)