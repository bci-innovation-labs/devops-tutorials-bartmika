
#### roberthao.com
##### PHP
1. Update your nginx config

    ```
    $ sudo vi /etc/nginx/sites-available/roberthao.com.conf;
    ```

2. Edit the code to look like this:

    ```
    server {
        listen  80;

        server_name roberthao.com www.roberthao.com;

        root  /var/www/roberthao.com/html;
        index index.php index.html index.htm;

         access_log  /var/log/nginx/wei.log main;
         error_log  /var/log/nginx/wei_error.log;

        location / {
            try_files $uri $uri/ /index.php?$args;
        }

            ## enable php support ##
        location ~ \.php$ {
            try_files $uri =404;
            root /var/www/roberthao.com/html;
            fastcgi_pass   unix:/run/php-fpm/www.sock;
            fastcgi_index  index.php;
            include        fastcgi_params;
            fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
        }
        error_page  500 502 503 504  /50x.html;
        location = /50x.html {
            root  /usr/share/nginx/html;
        }
    }
    ```

3. Confirm this code works.

    ```
    nginx -t
    ```

4. Restart NGINX

    ```
    $ sudo systemctl restart nginx
    ```


##### File Structure
1. Remove our sample folder.

    ```
    $ rm /var/www/roberthao.com/html/index.html
    ```

2. Copy (including keeping the permissions) using ``rsync``.

    ```
    $ sudo rsync -avP ~/wordpress/ /var/www/roberthao.com/html/
    ```

3. Create our uploads folder.

    ```
    $ mkdir /var/www/roberthao.com/html/wp-content/uploads
    ```

4. Grant permission.

    ```
    $ sudo chown -R nginx:nginx /var/www/*
    $ sudo chmod -R 755 /var/www
    $ semanage fcontext -a -t httpd_sys_content_t "/var/www/roberthao.com(/.*)?"
    ```

##### Configuration
1. Run the following.

    ```
    cd /var/www/roberthao.com/html
    ```

2. Copy our sample configuration AND grant permission.

    ```
    cp wp-config-sample.php wp-config.php
    sudo chown -R nginx:nginx /var/www/roberthao.com/html/*
    ```

3. Open the config.

    ```
    vi wp-config.php
    ```

4. Make sure you change the following.

    ```
    // ** MySQL settings - You can get this info from your web host ** //
    /** The name of the database for WordPress */
    define('DB_NAME', 'wordpress');

    /** MySQL database username */
    define('DB_USER', 'wordpressuser');

    /** MySQL database password */
    define('DB_PASSWORD', 'password');
    ```

5. Open up your browser and go to ````

    ```
    http://roberthao.com/index.php
    ```

6. (OPTIONAL) https://serverfault.com/questions/382054/403-forbidden-when-trying-to-access-nginx

7. Proceed to filling it out.
