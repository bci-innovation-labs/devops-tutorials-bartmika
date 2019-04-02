# Setup Virtual Hosts
The following instructions where modified from [How To Set Up Nginx Server Blocks on CentOS 7](https://www.digitalocean.com/community/tutorials/how-to-set-up-nginx-server-blocks-on-centos-7). Before proceeding, please make sure you completed the [previous instructions](/1-DigitalOcean-Droplet.md) before proceeding.

## Instructions
1. Open up our ``Nginx`` configuration file:

    ```
    vi /etc/nginx/nginx.conf
    ```

2. Append to the end of the ``http {}`` code block:

    ```
    include /etc/nginx/sites-enabled/*.conf;
    server_names_hash_bucket_size 64;
    ```

3. Create the directory structure.

    ```
    sudo mkdir -p /var/www/leiwei.co/html
    sudo mkdir -p /var/www/hardy.games/html
    sudo mkdir -p /var/www/mikezhouxun.com/html
    sudo mkdir -p /var/www/roberthao.com/html
    ```

3. Grand permission to the regular users.

    ```
    sudo chown -R $USER:$USER /var/www/leiwei.co/html
    sudo chown -R $USER:$USER /var/www/hardy.games/html
    sudo chown -R $USER:$USER /var/www/mikezhouxun.com/html
    sudo chown -R $USER:$USER /var/www/roberthao.com/html
    ```

4. Read access is permitted to generally all users.

    ```
    sudo chmod -R 755 /var/www
    ```

5. Open sample file.

    ```
    vi /var/www/leiwei.co/html/index.html
    ```

6. Append file:

    ```
    <html>
      <head>
        <title>Welcome to leiwei.co!</title>
      </head>
      <body>
        <h1>Success! The leiwei.co server block is working!</h1>
      </body>
    </html>
    ```

7. Open sample file.

    ```
    vi /var/www/hardy.games/html/index.html
    ```

8. Append the file:

    ```
    <html>
      <head>
        <title>Welcome to hardy.games/html!</title>
      </head>
      <body>
        <h1>Success! The hardy.games server block is working!</h1>
      </body>
    </html>
    ```

9. Open sample file.

    ```
    vi /var/www/mikezhouxun.com/html/index.html
    ```

10. Append the file:

    ```
    <html>
      <head>
        <title>Welcome to mikezhouxun.com!</title>
      </head>
      <body>
        <h1>Success! The mikezhouxun.com server block is working!</h1>
      </body>
    </html>
    ```

11. Open sample file.

    ```
    vi /var/www/roberthao.com/html/index.html
    ```

12. Append the file:

    ```
    <html>
     <head>
       <title>Welcome to roberthao.com!</title>
     </head>
     <body>
       <h1>Success! The roberthao.com server block is working!</h1>
     </body>
    </html>
    ```

13. Create new server blocks.

    ```
    sudo mkdir /etc/nginx/sites-available
    sudo mkdir /etc/nginx/sites-enabled
    ```

14. Create the first server block file.

    ```
    vi /etc/nginx/sites-available/leiwei.co.conf
    ```

15. Append file:

    ```
    server {
        listen  80;

        server_name leiwei.co www.leiwei.co;

        location / {
            root  /var/www/leiwei.co/html;
            index  index.html index.htm;
            try_files $uri $uri/ =404;
        }

        error_page  500 502 503 504  /50x.html;
        location = /50x.html {
            root  /usr/share/nginx/html;
        }
    }
    ```

16. Create the second server block file.

    ```
    vi /etc/nginx/sites-available/hardy.games.conf
    ```

17. Append file:

    ```
    server {
        listen  80;

        server_name hardy.games www.hardy.games;

        location / {
            root  /var/www/hardy.games/html;
            index  index.html index.htm;
            try_files $uri $uri/ =404;
        }

        error_page  500 502 503 504  /50x.html;
        location = /50x.html {
            root  /usr/share/nginx/html;
        }
    }
    ```

18. Create the third server block file.

    ```
    vi /etc/nginx/sites-available/mikezhouxun.com.conf
    ```

19. Append file:

    ```
    server {
        listen  80;

        server_name mikezhouxun.com www.mikezhouxun.com;

        location / {
            root  /var/www/mikezhouxun.com/html;
            index  index.html index.htm;
            try_files $uri $uri/ =404;
        }

        error_page  500 502 503 504  /50x.html;
        location = /50x.html {
            root  /usr/share/nginx/html;
        }
    }
    ```

20. Create the third server block file.

    ```
    vi /etc/nginx/sites-available/roberthao.com.conf
    ```

21. Append file:

    ```
    server {
        listen  80;

        server_name roberthao.com www.roberthao.com;

        location / {
            root  /var/www/roberthao.com/html;
            index  index.html index.htm;
            try_files $uri $uri/ =404;
        }

        error_page  500 502 503 504  /50x.html;
        location = /50x.html {
            root  /usr/share/nginx/html;
        }
    }
    ```

18. Enable the new server block files.

    ```
    sudo ln -s /etc/nginx/sites-available/leiwei.co.conf /etc/nginx/sites-enabled/leiwei.co.conf;
    sudo ln -s /etc/nginx/sites-available/hardy.games.conf /etc/nginx/sites-enabled/hardy.games.conf;
    sudo ln -s /etc/nginx/sites-available/mikezhouxun.com.conf /etc/nginx/sites-enabled/mikezhouxun.com.conf;
    sudo ln -s /etc/nginx/sites-available/roberthao.com.conf /etc/nginx/sites-enabled/roberthao.com.conf;
    ```

19. Confirm our server can restart.

    ```
    sudo nginx -t;
    ```

20. Restart the server.

    ```
    sudo systemctl restart nginx
    ```

21. Finally in your browser, check to see that the links work.

    ```
    http://mikaponics.com
    http://hardy.games
    http://mikezhouxun.com
    http://roberthao.com
    ```

### Addendum
1. Update your nginx config

    ```
    $ sudo vi /etc/nginx/nginx.conf
    ```

2. The following can be deleted.

    ```
    server {
            listen       80 default_server;
            listen       [::]:80 default_server;
            server_name  _;
            root         /usr/share/nginx/html;

            # Load configuration files for the default server block.
            include /etc/nginx/default.d/*.conf;

            location / {
            }

            error_page 404 /404.html;
                location = /40x.html {
            }

            error_page 500 502 503 504 /50x.html;
                location = /50x.html {
            }
            ## enable php support ##
            location ~ \.php$ {
            root /usr/share/nginx/html;
            fastcgi_pass   127.0.0.1:9000;
            fastcgi_index  index.php;
            include        fastcgi_params;
            fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
            }

    }
    ```
