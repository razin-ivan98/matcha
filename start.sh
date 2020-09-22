clear

docker-machine stop
docker-machine rm default

rm -rf ~/goinfre/.docker
rm -rf ~/.docker

mkdir ~/goinfre/.docker
ln -s ~/goinfre/.docker ~/.docker

docker-machine create -d virtualbox default

eval $(docker-machine env)
docker stop matcha_mysql matcha_phpmyadmin
docker rm matcha_mysql matcha_phpmyadmin

docker run --name matcha_mysql -p 3306:3306 -d -v matcha_db:/var/lib/mysql --restart on-failure:5 -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=base mysql:5 --default-authentication-plugin=mysql_native_password
docker run --name matcha_phpmyadmin -d --link matcha_mysql:db -p 8081:80 phpmyadmin/phpmyadmin

docker-machine ls | grep -E "tcp" | awk -F' ' '{print $5}' | awk -Ftcp:// '{print $2}' | awk -F: '{print $1}'
docker ps
echo "mysql:"
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' matcha_mysql