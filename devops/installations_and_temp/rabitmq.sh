sudo nano rabbitmq-proxy.conf
<VirtualHost *:80>
    ServerName devo.pink-team.com

    ProxyPreserveHost On
    ProxyRequests Off
    ProxyPass /rabbitmq http://localhost:15672/
    ProxyPassReverse /rabbitmq http://localhost:15672/

    <Proxy *>
        Order deny,allow
        Allow from all
    </Proxy>

    ErrorLog ${APACHE_LOG_DIR}/rabbitmq-proxy-error.log
    CustomLog ${APACHE_LOG_DIR}/rabbitmq-proxy-access.log combined
</VirtualHost>
# Enable necessary Apache modules
sudo a2enmod proxy
sudo a2enmod proxy_http
sudo a2enmod headers
sudo a2enmod rewrite

<VirtualHost *:80>
    ServerName devo.pink-team.com
    Redirect / https://devo.pink-team.com/
</VirtualHost>

<VirtualHost *:443>
    ServerName devo.pink-team.com

    SSLEngine on
    SSLCertificateFile /etc/letsencrypt/live/devo.pink-team.com/fullchain.pem
    SSLCertificateKeyFile /etc/letsencrypt/live/devo.pink-team.com/privkey.pem

    ProxyPreserveHost On
    ProxyRequests Off
    ProxyPass /rabbitmq http://localhost:15672/
    ProxyPassReverse /rabbitmq http://localhost:15672/

    <Proxy *>
        Order deny,allow
        Allow from all
    </Proxy>

    ErrorLog ${APACHE_LOG_DIR}/rabbitmq-proxy-error.log
    CustomLog ${APACHE_LOG_DIR}/rabbitmq-proxy-access.log combined
</VirtualHost>
