from flask import make_response, redirect, session, request, send_from_directory, send_file
from app import app

from app.filtres import Filtres

from app.forms import SignInForm
from app.forms import SignUpForm
from app.forms import InputDataForm
from app.forms import UploadForm
from app.forms import NewMessageForm
from app.forms import SetGeoForm
from app.forms import ChangePassForm
from app.forms import PasswordRecoveryForm
from app.forms import BioForm


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

from math import ceil

import os

@app.route('/')
@app.route('/likes')
@app.route('/index')
def index():
    if 'signed_user' in session and session['registration_ended'] == 0:
        return redirect("/#/input_data", 302)
    return send_file("static/index.html")

@app.route('/api/sign_in', methods=['POST'])
def sign_in_post():
    form = SignInForm()
    details = "OK"
    if form.validate():
        res = SignIn().sign_in(form.login.data, form.password.data)
        answer = res['answer']
        details = res['details']
        if answer == True:
            session['signed_user'] = res['username']
            session['registration_ended'] = res['registration_ended']
            User().set_online(session['signed_user'])
    else:
        answer = False
        details = "Form Error"
    return json.dumps({ "answer" : answer, "details": details })

@app.route('/api/sign_up', methods=['POST'])
def sign_up_post():
    form = SignUpForm()

    if not form.validate():
        return json.dumps({ 'answer': False, 'details': 'Password must contain at least 8 characters; Latin letters and digits are allowed' })

    if not form.password.data == form.confirm_password.data:
        return json.dumps({ 'answer': False, 'details': 'Passwords must match' })

    res = SignUp().sign_up(form.login.data, form.password.data)
    if not res:
        return json.dumps({ 'answer': False, 'details': 'User with this name already exists' })
    User().set_online(form.login.data)

    return json.dumps({ 'answer': True, 'details': 'OK' })

@app.route('/api/is_signed', methods=['GET'])
def is_signed():
    if not 'signed_user' in session:
        return json.dumps({ 'answer': False, 'details': 'You are not signed in' })
    if session['registration_ended'] == 0:
        return json.dumps({ 'answer': False, 'details': 'Your registration is not ended' })

    User().set_online(session['signed_user'])
    return json.dumps({
        'answer': True,
        'username': session['signed_user']
    })

@app.route('/api/sign_out', methods=['GET'])
def sign_out():
    if not 'signed_user' in session:
        return json.dumps({ 'answer': False, 'details': 'You are not signed in' })
    
    session.clear()
    return json.dumps({ 'answer': True })


@app.route('/api/get_username', methods=['GET'])
def get_username():
    if 'signed_user' in session:
        confirmed = User().is_confirmed(session['signed_user'])
        user_info = User().get_user_info(session['signed_user'], session['signed_user'])
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
    if not 'signed_user' in session:
        return json.dumps({ 'answer': False, 'details': 'You are not signed in' })

    form = InputDataForm()

    if not form.validate():
        return json.dumps({ 'answer': False, 'details': 'Data is invalid' })

    res = InputData().input_data(session['signed_user'],
                                form.firstname.data, 
                                form.lastname.data,
                                form.email.data,
                                form.gender.data,
                                form.orientation.data,
                                form.interests.data)
                            
    User().set_online(session['signed_user'])
    return json.dumps({ 'answer': True, 'details': 'OK' })


@app.route('/api/get_recomended_users', methods=['GET'])
def get_recomended_users():
    if not 'signed_user' in session:
        return json.dumps({ 'answer': False, 'details': 'You are not signed in' })
    if session['registration_ended'] == 0:
        return json.dumps({ 'answer': False, 'details': 'Your registration is not ended' })

    filtres = json.loads(request.args.get('filtres'))
    page = json.loads(request.args.get('page'))
    perPage = 6

    res = User().get_all_users(session['signed_user'])

    res = list(filter(Filtres().main_filter, res))
    user = User().get_user_info(session['signed_user'], session['signed_user'])
    if filtres['show'] == 'recommended':
        
        
        orientation = user['orientation']
        gender = user['gender']
        latitude = user['latitude']
        longitude = user['longitude']

        if (orientation == 'Natural'):
            if (gender == 'Male'):
                res = Filtres().female_filter(res)
            else:
                res = Filtres().male_filter(res)
            res = Filtres().natural_and_bi_filter(res)
        elif (orientation == 'Gomosexual'):
            if (gender == 'Male'):
                res = Filtres().male_filter(res)
            else:
                res = Filtres().female_filter(res)
            res = Filtres().gomo_and_bi_filter(res)
        else:
            if (gender == 'Male'):
                res = Filtres().for_bi_male(res)
            else:
                res = Filtres().for_bi_female(res)
    else:
        res = Filtres().orientation_filter(res, filtres['orientation'])
        res = Filtres().gender_filter(res, filtres['gender'])
        res = Filtres().age_filter(res, filtres['age'])
        res = Filtres().rating_filter(res, filtres['rating'])

        res = Filtres().geo_filter(res, filtres['geo'], user)
        res = Filtres().common_tags_filter(res, filtres['common_tags'], user)



    if filtres['filtres'] == 'likers':
        res = list(filter(Filtres().likers_filter, res))
    elif filtres['filtres'] == 'liked':
        res = list(filter(Filtres().liked_filter, res))
    elif filtres['filtres'] == 'friends':
        res = list(filter(Filtres().friends_filter, res))

    if filtres['sort'] == 'age':
        res = sorted(res, key=lambda user: user['age'])
    if filtres['sort'] == 'rating':
        res = sorted(res, key=lambda user: user['rating'], reverse=True)
    if filtres['sort'] == 'geo':
        res = Filtres().geo_sort(res, user)
    if filtres['sort'] == 'common_tags':
        res = Filtres().common_tags_sort(res, user)

    pages = ceil(len(res) / perPage)
    res = res[perPage * (page - 1) : perPage * (page - 1) + perPage]
    User().set_online(session['signed_user'])
    return json.dumps({ 'answer': True , 'users': res, 'pages': pages})



@app.route('/api/upload_image', methods=['POST'])
def upload_image():
    if not 'signed_user' in session:
        return json.dumps({ 'answer': False, 'details': 'You are not signed in' })
    form = UploadForm()

    if not form.validate():
        return json.dumps({ 'answer': False, 'details': 'File is invalid' })

    file = form.file.data

    coordinates = json.loads(request.form.get('coordinates'))   
    
    filename = secure_filename( session['signed_user'] + str(datetime.datetime.now()) + file.filename )
    filepath = os.path.join(os.path.abspath('images'), filename)

    file.save(filepath)
    img = Image.open(filepath)
    coordinates_to_crop = (coordinates['left'],
                            coordinates['top'],
                            coordinates['left'] + coordinates['width'],
                            coordinates['top'] + coordinates['height'])
    cropped = img.crop( coordinates_to_crop )
    cropped.save(filepath)
    res = User().upload_image(filename, session['signed_user'])
    User().set_online(session['signed_user'])
    if not res:
        return json.dumps({ 'answer': False, 'details': "You can upload not more than 5 images" })
    return json.dumps({ 'answer': True })

    
@app.route('/api/download_image', methods=['GET'])
def download_image():
    if not 'signed_user' in session:
        return json.dumps({ 'answer': False, 'details': 'You are not signed in' })

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
    if not 'signed_user' in session:
        return json.dumps({ 'answer': False, 'details': 'You are not signed in'  })

    username = request.args.get('username')
    avatar = User().get_avatar(username)
    file = send_from_directory(os.path.abspath('images'), avatar)  
    response = make_response(file, 200)
    response.headers.set('Content-type', 'image')
    User().set_online(session['signed_user'])
    return response

@app.route('/api/get_user_info', methods=['GET'])
def get_user_info():
    if not 'signed_user' in session:
        return json.dumps({ 'answer': False, 'details': 'You are not signed in' })
    if session['registration_ended'] == 0:
        return json.dumps({ 'answer': False, 'details': 'Your registration is not ended' })

    username = request.args.get('username')
    user_info = User().get_user_info(username, session['signed_user'])
    User().set_online(session['signed_user'])
    if (user_info == False):
        return json.dumps({ 'answer': False, 'details': 'Not user with this name' })
    return json.dumps({ 'answer': True,
                        'user_info': user_info})

@app.route('/api/like', methods=['GET'])
def like():
    if not 'signed_user' in session:
        return json.dumps({ 'answer': False, 'details': 'You are not signed in' })
    if session['registration_ended'] == 0:
        return json.dumps({ 'answer': False, 'details': 'Your registration is not ended' })

    username = request.args.get('username')
    User().set_online(session['signed_user'])
    if not (User().is_liked(session['signed_user'], username)):
        User().like(session['signed_user'], username)
        Chat().create_dialog(session['signed_user'], username)
        Chat().new_message(session['signed_user'], username, "Привет, теперь мы друзья!")
    return json.dumps({ 'answer': True})

@app.route('/api/unlike', methods=['GET'])
def unlike():
    if not 'signed_user' in session:
        return json.dumps({ 'answer': False, 'details': 'You are not signed in' })
    if session['registration_ended'] == 0:
        return json.dumps({ 'answer': False, 'details': 'Your registration is not ended' })

    username = request.args.get('username')
    User().set_online(session['signed_user'])
    if (User().is_liked(session['signed_user'], username)):
        User().unlike(session['signed_user'], username)
        Chat().delete_dialog(session['signed_user'], username)
    return json.dumps({ 'answer': True})

@app.route('/api/get_likes', methods=['GET'])
def get_likes():
    if not 'signed_user' in session:
        return json.dumps({ 'answer': False, 'details': 'You are not signed in' })
    if session['registration_ended'] == 0:
        return json.dumps({ 'answer': False, 'details': 'Your registration is not ended' })

    User().set_online(session['signed_user'])
    res = User().get_likes(session['signed_user'])
    return json.dumps({ 'answer': True,
                        'likes': res })

@app.route('/api/like_read', methods=['GET'])
def like_read():
    if not 'signed_user' in session:
        return json.dumps({ 'answer': False, 'details': 'You are not signed in' })
    if session['registration_ended'] == 0:
        return json.dumps({ 'answer': False, 'details': 'Your registration is not ended' })

    User().set_online(session['signed_user'])
    like_id = request.args.get('like_id')
    User().like_read(like_id)
    return json.dumps({ 'answer': True })

@app.route('/api/get_unread_likes_count', methods=['GET'])
def get_unread_likes_count():
    if not 'signed_user' in session:
        return json.dumps({ 'answer': False, 'details': 'You are not signed in' })
    if session['registration_ended'] == 0:
        return json.dumps({ 'answer': False, 'details': 'Your registration is not ended' })

    User().set_online(session['signed_user'])
    res = User().get_unread_likes_count(session['signed_user'])
    return json.dumps({ 'answer': True , 'likes_count': res})

@app.route('/api/get_my_chats', methods=['GET'])
def get_my_chats():
    if not 'signed_user' in session:
        return json.dumps({ 'answer': False, 'details': 'You are not signed in' })
    if session['registration_ended'] == 0:
        return json.dumps({ 'answer': False, 'details': 'Your registration is not ended' })

    User().set_online(session['signed_user'])
    res = Chat().get_my_chats(session['signed_user'])
    return json.dumps({ 'answer': True , 'chats': res})

@app.route('/api/get_unread_dialogs_count', methods=['GET'])
def get_unread_dialogs_count():
    if not 'signed_user' in session:
        return json.dumps({ 'answer': False, 'details': 'You are not signed in' })

    User().set_online(session['signed_user'])
    res = Chat().get_unread_chats(session['signed_user'])
    return json.dumps({ 'answer': True , 'dialogs_count': res})

@app.route('/api/get_unread_guests_count', methods=['GET'])
def get_unread_guests_count():
    if not 'signed_user' in session:
        return json.dumps({ 'answer': False, 'details': 'You are not signed in' })

    User().set_online(session['signed_user'])
    res = User().get_unread_guests(session['signed_user'])
    return json.dumps({ 'answer': True , 'guests_count': res})


@app.route('/api/new_message', methods=['POST'])
def new_message():
    if not 'signed_user' in session:
        return json.dumps({ 'answer': False, 'details': 'You are not signed in' })
    if session['registration_ended'] == 0:
        return json.dumps({ 'answer': False, 'details': 'Your registration is not ended' })

    form = NewMessageForm()
    Chat().new_message(session['signed_user'], form.friend.data, form.curr_message.data)

    User().set_online(session['signed_user'])
    return json.dumps({ 'answer': True })

@app.route('/api/get_messages', methods=['GET'])
def get_messages():
    if not 'signed_user' in session:
        return json.dumps({ 'answer': False, 'details': 'You are not signed in' })
    if session['registration_ended'] == 0:
        return json.dumps({ 'answer': False, 'details': 'Your registration is not ended' })

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

@app.route('/api/set_geo', methods=['POST'])
def set_geo():
    if not 'signed_user' in session:
        return json.dumps({ 'answer': False, 'details': 'You are not signed in' })

    form = SetGeoForm()
    if request.headers.getlist("X-Forwarded-For"):
        ip = request.headers.getlist("X-Forwarded-For")[0]
    else:
        ip = request.remote_addr
    User().set_geo(session['signed_user'], form.latitude.data, form.longitude.data, ip)
    return json.dumps({ 'answer': True })

@app.route('/api/get_chat_with', methods=['GET'])
def get_chat_with():
    if not 'signed_user' in session:
        return json.dumps({ 'answer': False, 'details': 'You are not signed in' })
    if session['registration_ended'] == 0:
        return json.dumps({ 'answer': False , 'details': 'Your registration is not ended' })
        
    user = request.args.get('username')

    res = Chat().get_chat_with(session['signed_user'], user)
    if res == False:
        return json.dumps({ 'answer': False, 'details': 'No chat with this user' }), 404
    return json.dumps({ 'answer': True,
                        'user_info': res })
                    
@app.route('/api/password_recovery/get', methods=['GET'])
def password_recovery_order():
    if 'signed_user' in session:
        return json.dumps({ 'answer': False, 'details': 'You are signed in' })
    user = request.args.get('username')

    res = User().password_recovery_order(user)
    if res == False:
        return json.dumps({ 'answer': False, 'details': 'No user with this name' })
    return json.dumps({ 'answer': True, })

@app.route('/api/change_pass', methods=['POST'])
def change_pass():
    if not 'signed_user' in session:
        return json.dumps({ 'answer': False, 'details': 'You are not signed in' })

    form = ChangePassForm()

    if not form.validate():
        return json.dumps({ 'answer': False, 'details': 'Password must contain at least 8 characters; Latin letters and digits are allowed' })

    old = form.oldPass.data
    new = form.newPass.data
    repeat = form.repeatPass.data

    if not new == repeat:
        return json.dumps({ 'answer': False, 'details': 'Passwords must match' })
    
    res = User().change_pass(session['signed_user'], old, new)

    if not res:
        return json.dumps({ 'answer': False, 'details': 'Wrong old password' })

    return json.dumps({ 'answer': True })
    
@app.route('/api/password_recovery/change', methods=['POST'])
def password_recovery():
    if 'signed_user' in session:
        return json.dumps({ 'answer': False, 'details': 'You are signed in' })

    form = PasswordRecoveryForm()

    if not form.validate():
        return json.dumps({ 'answer': False, 'details': 'Password must contain at least 8 characters; Latin letters and digits are allowed' })

    id = form.id.data
    old = form.oldPass.data
    new = form.newPass.data
    repeat = form.repeatPass.data

    if not new == repeat:
        return json.dumps({ 'answer': False, 'details': 'Passwords must match' })
    
    username = User().get_user_by_password_id(id)
    if username == False:
        return json.dumps({ 'answer': False, 'details': 'Wrong link' })
    res = User().change_pass(username, old, new)

    if not res:
        return json.dumps({ 'answer': False, 'details': 'Wrong old password' })

    return json.dumps({ 'answer': True })
    
@app.route('/api/delete_image', methods=['GET'])
def delete_image():
    if not 'signed_user' in session:
        return json.dumps({ 'answer': False, 'details': 'You are not signed in' })
    user = session['signed_user']
    id = request.args.get('id')

    res = User().delete_image(user, id)
    if not res:
        return json.dumps({ 'answer': False, 'details': 'Delete Error'})
    return json.dumps({ 'answer': True })

@app.route('/api/set_avatar', methods=['GET'])
def set_avatar():
    if not 'signed_user' in session:
        return json.dumps({ 'answer': False, 'details': 'You are not signed in' })
    user = session['signed_user']
    id = request.args.get('id')

    res = User().set_avatar(user, id)
    if not res:
        return json.dumps({ 'answer': False, 'details': 'Set avatar error'})
    return json.dumps({ 'answer': True })

@app.route('/api/change_bio', methods=['POST'])
def change_bio():
    if not 'signed_user' in session:
        return json.dumps({ 'answer': False, 'details': 'You are not signed in' })

    form = BioForm()

    text = form.text.data
    
    res = User().change_bio(session['signed_user'], text)

    if not res:
        return json.dumps({ 'answer': False, 'details': 'Set bio error'})
    return json.dumps({ 'answer': True })

@app.route('/api/end_registration', methods=['GET'])
def end_registration():
    if not 'signed_user' in session:
        return json.dumps({ 'answer': False, 'details': 'You are not signed in' })
    user = session['signed_user']

    res = User().end_registration(user)
    if (res):
        session['registration_ended'] = True
        return json.dumps({ 'answer': True, })
    return json.dumps({ 'answer': False, 'details': 'You must add infomation about u, your geo and at least one image'})

@app.route('/api/report', methods=['GET'])
def report():
    if not 'signed_user' in session:
        return json.dumps({ 'answer': False, 'details': 'You are not signed in' })
    if session['registration_ended'] == 0:
        return json.dumps({ 'answer': False , 'details': 'Your registration is not ended' })
    user = session['signed_user']
    reported_user = request.args.get('username')
    User().report(user, reported_user)
    return json.dumps({ 'answer': True, })

@app.route('/api/hide', methods=['GET'])
def hide():
    if not 'signed_user' in session:
        return json.dumps({ 'answer': False, 'details': 'You are not signed in' })
    if session['registration_ended'] == 0:
        return json.dumps({ 'answer': False , 'details': 'Your registration is not ended' })
    user = session['signed_user']
    reported_user = request.args.get('username')
    User().block_user(user, reported_user)
    return json.dumps({ 'answer': True, })

@app.route('/api/get_blacklist', methods=['GET'])
def get_blacklist():
    if not 'signed_user' in session:
        return json.dumps({ 'answer': False, 'details': 'You are not signed in' })
    if session['registration_ended'] == 0:
        return json.dumps({ 'answer': False , 'details': 'Your registration is not ended' })
    user = session['signed_user']
    res = User().get_blacklist(user)
    return json.dumps({ 'answer': True, 'blacklist': res })

@app.route('/api/unblock', methods=['GET'])
def unblock():
    if not 'signed_user' in session:
        return json.dumps({ 'answer': False, 'details': 'You are not signed in' })
    if session['registration_ended'] == 0:
        return json.dumps({ 'answer': False , 'details': 'Your registration is not ended' })
    user = session['signed_user']
    unblocked_user = request.args.get('username')

    res = User().unblock(user, unblocked_user)
    return json.dumps({ 'answer': True, })

@app.route('/api/visit', methods=['GET'])
def visit():
    if not 'signed_user' in session:
        return json.dumps({ 'answer': False, 'details': 'You are not signed in' })
    if session['registration_ended'] == 0:
        return json.dumps({ 'answer': False , 'details': 'Your registration is not ended' })
    user = session['signed_user']
    visited_user = request.args.get('username')

    res = User().visit(user, visited_user)
    return json.dumps({ 'answer': True, })

@app.route('/api/get_guests', methods=['GET'])
def get_guests():
    if not 'signed_user' in session:
        return json.dumps({ 'answer': False, 'details': 'You are not signed in' })
    if session['registration_ended'] == 0:
        return json.dumps({ 'answer': False , 'details': 'Your registration is not ended' })
    user = session['signed_user']
    res = User().get_guests(user)
    return json.dumps({ 'answer': True, 'guests': res })

@app.route('/api/guest_read', methods=['GET'])
def guest_read():
    if not 'signed_user' in session:
        return json.dumps({ 'answer': False, 'details': 'You are not signed in' })
    if session['registration_ended'] == 0:
        return json.dumps({ 'answer': False , 'details': 'Your registration is not ended' })

    id = request.args.get('guest_id')
    
    user = session['signed_user']
    User().guest_read(id, session['signed_user'])
    return json.dumps({ 'answer': True, })
    