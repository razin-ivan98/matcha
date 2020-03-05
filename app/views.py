from flask import make_response, flash, redirect, session, request, send_from_directory
from app import app

from app.filtres import Filtres

from app.forms import SignInForm
from app.forms import SignUpForm
from app.forms import InputDataForm
from app.forms import UploadForm
from app.forms import NewMessageForm

from app.models.posts import Posts
from app.models.sign_in import SignIn
from app.models.sign_up import SignUp
from app.models.user import User
from app.models.input_data import InputData
from app.models.chat import Chat

from werkzeug.datastructures import MultiDict

from werkzeug.utils import secure_filename

import datetime

import json

from PIL import Image

import os


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
            User().set_online(session['signed_user'])
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
        print('govono')
        User().set_online(session['signed_user'])
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

@app.route('/api/get_username', methods=['GET'])#optimize
def get_username():
    if 'signed_user' in session:
        confirmed = User().is_confirmed(session['signed_user'])
        user_info = User().get_user_info(session['signed_user'])
        User().set_online(session['signed_user'])
        return json.dumps({
                'answer': True,
                'username': session['signed_user'],
                'confirmed': confirmed,
                'user_info': user_info
            })
    else:
        return json.dumps({
                'answer': False,
                'username': '',
                'confirmed': 0,
                'user_info': False
            })

@app.route('/api/input_data', methods=['POST'])
def input_data_post():
    form = InputDataForm()#validate

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
    User().set_online(session['signed_user'])
    return json.dumps({ 'answer': True })



@app.route('/api/get_recomended_users', methods=['GET'])
def get_recomended_users():
    filtres = json.loads(request.args.get('filtres'))
    res = User().get_all_users(session['signed_user'])

    if filtres['show'] == 'likers':
        res = list(filter(Filtres().likers_filter, res))
    elif filtres['show'] == 'liked':
        res = list(filter(Filtres().liked_filter, res))
    elif filtres['show'] == 'friends':
        res = list(filter(Filtres().friends_filter, res))
    elif filtres['show'] == 'custom':
        res = Filtres().orientation_filter(res, filtres['orientation'])
        res = Filtres().gender_filter(res, filtres['gender'])
    User().set_online(session['signed_user'])
    return json.dumps({ 'answer': True , 'users': res})



@app.route('/api/upload_image', methods=['POST'])
def upload_image():
    # form = UploadForm()#validate
    # file = form.file.data
    file = request.files['file']
    coordinates = json.loads(request.form.get('coordinates'))   
    
    filename = secure_filename( str(datetime.datetime.now()) + file.filename)
    filepath = os.path.join(os.path.abspath('images'), filename)

    file.save(filepath)
    img = Image.open(filepath)
    coordinates_to_crop = (coordinates['left'],
                            coordinates['top'],
                            coordinates['left'] + coordinates['width'],
                            coordinates['top'] + coordinates['height'])
    cropped = img.crop( coordinates_to_crop )
    cropped.save(filepath)
    User().upload_image(filename, session['signed_user'])
    User().set_online(session['signed_user'])
    return json.dumps({ 'answer': True })
    
@app.route('/api/download_image', methods=['GET'])
def download_image():
    avatar = request.args.get('avatar')
    if avatar == False:
        return False
    file = send_from_directory(os.path.abspath('images'), avatar)
    response = make_response(file, 200)
    response.headers.set('Content-type', 'image')
    User().set_online(session['signed_user'])
    return response

@app.route('/api/get_avatar', methods=['GET'])
def get_avatar():
    username = request.args.get('username')
    avatar = User().get_avatar(username)
    file = send_from_directory(os.path.abspath('images'), avatar)  
    response = make_response(file, 200)
    response.headers.set('Content-type', 'image')
    User().set_online(session['signed_user'])
    return response

@app.route('/api/get_user_info', methods=['GET'])
def get_user_info():
    username = request.args.get('username')
    user_info = User().get_user_info(username)
    User().set_online(session['signed_user'])
    if (user_info == False):
        return json.dumps({ 'answer': False })
    return json.dumps({ 'answer': True,
                        'user_info': user_info})

@app.route('/api/like', methods=['GET'])
def like():
    username = request.args.get('username')
    User().set_online(session['signed_user'])
    if not (User().is_liked(session['signed_user'], username)):
        User().like(session['signed_user'], username)
        Chat().create_dialog(session['signed_user'], username)
        Chat().new_message(session['signed_user'], username, "Привет, теперь мы друзья!")
    return json.dumps({ 'answer': True})

@app.route('/api/unlike', methods=['GET'])
def unlike():
    username = request.args.get('username')
    User().set_online(session['signed_user'])
    if (User().is_liked(session['signed_user'], username)):
        User().unlike(session['signed_user'], username)
        Chat().delete_dialog(session['signed_user'], username)
    return json.dumps({ 'answer': True})

@app.route('/api/get_likes', methods=['GET'])
def get_likes():
    User().set_online(session['signed_user'])
    res = User().get_likes(session['signed_user'])
    return json.dumps({ 'answer': True,
                        'likes': res })

@app.route('/api/like_read', methods=['GET'])
def like_read():
    User().set_online(session['signed_user'])
    like_id = request.args.get('like_id')
    User().like_read(like_id)
    return json.dumps({ 'answer': True })

@app.route('/api/get_unread_likes_count', methods=['GET'])
def get_unread_likes_count():
    User().set_online(session['signed_user'])
    res = User().get_unread_likes_count(session['signed_user'])
    return json.dumps({ 'answer': True , 'likes_count': res})

@app.route('/api/get_my_chats', methods=['GET'])
def get_my_chats():
    User().set_online(session['signed_user'])
    res = Chat().get_my_chats(session['signed_user'])
    return json.dumps({ 'answer': True , 'chats': res})

@app.route('/api/get_unread_dialogs_count', methods=['GET'])
def get_unread_dialogs_count():
    User().set_online(session['signed_user'])
    res = Chat().get_unread_chats(session['signed_user'])
    return json.dumps({ 'answer': True , 'dialogs_count': res})


@app.route('/api/new_message', methods=['POST'])
def new_message():
    # message = json.loads(request.form.get('currMessage'))
    form = NewMessageForm()
    Chat().new_message(session['signed_user'], form.friend.data, form.curr_message.data)

    User().set_online(session['signed_user'])
    return json.dumps({ 'answer': True })

@app.route('/api/get_messages', methods=['GET'])
def get_messages():
    username = request.args.get('username')
    last = request.args.get('last')
    if (last == -1):
        messages = Chat().get_messages(session['signed_user'], username)
    else:
        messages = Chat().get_new_messages(session['signed_user'], username, last)

    unread = Chat().get_unread_by_friend(session['signed_user'], username)
    

    User().set_online(session['signed_user'])
    return json.dumps({ 'answer': True,
                        'messages': messages,
                        'unread': unread})