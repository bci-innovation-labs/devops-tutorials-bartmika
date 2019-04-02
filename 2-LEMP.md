# HOWTO: Setup LEMP for DigitalOcean Droplet using CentOS 7
## Description

Special thanks:

* https://www.digitalocean.com/community/tutorials/how-to-install-linux-nginx-mysql-php-lemp-stack-on-centos-7

## Instructions
### MariaDB

1. Install the app.

    ```
    $ sudo yum install -y mariadb-server mariadb
    ```

2. Start the database.

    ```
    $ sudo systemctl start mariadb
    ```

3. Secure our database.

    ```
    $ sudo mysql_secure_installation
    ```

3. Here are the steps to take:

    ```
    Enter current password for root (enter for none):

    <ENTER NONE>

    Set root password? [Y/n]
    <ENTER Y>

    New password:
    <ENTER PASSWORD AND SAVE IT>

    Re-enter new password:
    <ENTER PASSWORD AND SAVE IT>

    Remove anonymous users? [Y/n]:
    <ENTER Y>

    Disallow root login remotely? [Y/n]
    <ENTER Y>

    Remove test database and access to it? [Y/n]
    <ENTER Y>

    Reload privilege tables now? [Y/n]
    <ENTER Y>
    ```

4. Enable the database.

    ```
    $ sudo systemctl enable mariadb
    ```

### PHP

https://www.cyberciti.biz/faq/how-to-install-php-7-2-on-centos-7-rhel-7/

1. Install our latest code.

    ```
    $ sudo yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm
    ```

2. Enable remi repo, run:

    ```
    $ sudo yum-config-manager --enable remi-php72
    ```

3. Refresh repository:

    ```
    $ sudo yum update
    ```

4. Install php version 7.2, run:

    ```
    $ sudo yum install php
    ```

5. You must install “PHP FastCGI Process Manager” called php-fpm along with commonly used modules:

    ```
    $ sudo yum install php-fpm php-gd php-json php-mbstring php-mysqlnd php-xml php-xmlrpc php-opcache
    ```

6. Check PHP version:

    ```
    $ php --version
    ```

7. List installed modules

    ```
    $ php --modules
    ```

8. Turn on PHP fpm for nginx using systemctl command:

    ```
    $ sudo systemctl enable php-fpm.service
    ```

9. Start PHP fpm service

    ```
    $ sudo systemctl start php-fpm.service
    ```

10. Stop PHP fpm service

    ```
    $ sudo systemctl stop php-fpm.service
    ```

11. Restart PHP fpm service

    ```
    $ sudo systemctl restart php-fpm.service
    ```

12. Get status of PHP fpm service

    ```
    $ sudo systemctl status php-fpm.service
    ```

### Configure Nginx for using with PHP 7.2

1. (Optional) Check to see what users permission we have.

    ```
    $ sudo egrep '^(user|group)' /etc/nginx/nginx.conf
    ```

2. Edit ``php-fpm`` configuration.

    ```
    $ sudo vi /etc/php-fpm.d/www.conf
    ```

3. Set user and group to nginx to look like the following.

    ```
    user = nginx
    group = nginx
    ```

4. Save and close the file. Restart php-fpm service:

    ```
    $ sudo systemctl restart php-fpm.service
    ```

5. Update your nginx config

    ```
    $ sudo vi /etc/nginx/nginx.conf
    ```

6. Edit/add as follows in server section:

    ```
    ## enable php support ##
    location ~ \.php$ {
        root /usr/share/nginx/html;
        fastcgi_pass   127.0.0.1:9000;
        fastcgi_index  index.php;
        include        fastcgi_params;
        fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
    }
    ```

7. Confirm this code works.

    ```
    nginx -t
    ```

8. Restart NGINX

    ```
    $ sudo systemctl restart nginx
    ```

9 Create a test script called foo.php at /usr/share/nginx/html/

    ```
    $ sudo vi /usr/share/nginx/html/foo.php
    ```

10. Append the following code:

    ```
    <?php
      // test script for CentOS/RHEL 7+PHP 7.2+Nginx
      phpinfo();
    ?>
    ```

11. Save and close the file. Fire a browser and type url:

    ```
    http://your-domain-name/foo.php
    http://167.99.177.25/foo.php
    ```
