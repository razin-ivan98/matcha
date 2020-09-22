clear

docker stop matcha_mysql matcha_phpmyadmin
docker rm matcha_mysql matcha_phpmyadmin

docker run --name matcha_mysql -p 3306:3306 -d -v matcha_db:/var/lib/mysql --restart on-failure:5 -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=base mysql:5 --default-authentication-plugin=mysql_native_password
docker run --name matcha_phpmyadmin -d --link matcha_mysql:db -p 8081:80 phpmyadmin/phpmyadmin

docker ps

cd Frontend
npm install
npm audit fix

cd ..
python3 -m venv flask
source flask/bin/activate
pip install -r py-dependencies.txt
deactivate

mysql -h 127.0.0.1 -u root -p < dump.sql

source flask/bin/activate
python3 run.py --host 0.0.0.0