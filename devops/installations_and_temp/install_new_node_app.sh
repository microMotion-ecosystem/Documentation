cd /var/www/node_apps/ || exit

sudo mkdir api-auth-service2
sudo chown -R ubuntu:www-data api-auth-service2
git clone https://github.com/yu2ahel/api-auth-service2.git


git clone git@github.com:yu2ahel/api-auth-service2.git
# shellcheck disable=SC2164
cd api-auth-service2

npm install
npm run build

cd dist
pm2 start main.js --name api-auth-service2

# restart the service
pm2 restart api-auth-service2



cd /etc/apache2/sites-available
sudo nano node-apps.conf


sudo nano /etc/apache2/sites-available/rabbitmq-proxy.conf
