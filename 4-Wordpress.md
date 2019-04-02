# Setup WordPress in our VirtualHosts on CentOS 7 in DigitalOcean

Special thanks to the following:

* https://www.digitalocean.com/community/tutorials/how-to-install-wordpress-on-centos-7

## Instructions
### Database setup

1. Log in as the admin.

    ```
    mysql -u root -p
    ```

2. Create our databases.

    ```
    CREATE DATABASE wordpress;
    CREATE DATABASE leiwei_wp;
    CREATE DATABASE hardy_wp;
    CREATE DATABASE mikezhouxun_wp;
    CREATE DATABASE roberthao_wp;
    ```

3. Create our users. **Please use different passwords!**

    ```
    CREATE USER wordpressuser@localhost IDENTIFIED BY 'password';
    ```

4. Attach the users to the databases. **Please use different passwords!**

    ```
    GRANT ALL PRIVILEGES ON wordpress.* TO wordpressuser@localhost IDENTIFIED BY 'password';
    GRANT ALL PRIVILEGES ON leiwei_wp.* TO wordpressuser@localhost IDENTIFIED BY 'password';
    GRANT ALL PRIVILEGES ON hardy_wp.* TO wordpressuser@localhost IDENTIFIED BY 'password';
    GRANT ALL PRIVILEGES ON mikezhouxun_wp.* TO wordpressuser@localhost IDENTIFIED BY 'password';
    GRANT ALL PRIVILEGES ON roberthao_wp.* TO wordpressuser@localhost IDENTIFIED BY 'password';
    ```

5. Finally update.

    ```
    FLUSH PRIVILEGES;
    ```

6. Exit the ``MariaDB`` console.

    ```
    exit
    ```

### WordPress

1. Download the latest ``WordPress`` codebase.

    ```
    cd ~
    wget http://wordpress.org/latest.tar.gz
    ```

2. Unzip.

    ```
    tar xzvf latest.tar.gz
    ```

3. Confirm that there is data there.

    ```
    ls
    ```

4. Please look in the ``5-websites`` folder and setup our sites accordingly.

### Special thanks

* https://linuxize.com/post/how-to-install-wordpress-with-nginx-on-centos-7/

* https://codex.wordpress.org/Nginx

* https://www.nginx.com/resources/wiki/start/topics/recipes/wordpress/
