# Setup React
Special thanks to the following article:

* https://hackernoon.com/start-to-finish-deploying-a-react-app-on-digitalocean-bcfae9e6d01b

## Instructions

1. Delete our previously created sample folder.

    ```
    rm -Rf /var/www/cookingpot.app
    ```

2. Clone the cookingpot site from [github.com](https://github.com/bci-innovation-labs/cookingpot-front). Afterwords rename the file.

    ```
    cd /var/www
    git clone https://github.com/bci-innovation-labs/cookingpot-front.git;
    mv cookingpot-front cookingpot.app
    ```

3. Go into our directory and install the dependencies.

    ```
    cd cookingpot.app;
    sudo npm install;
    ```

4. Create our ``.env.local`` file by copying the ``.env`` file.

    ```
    cp /var/www/cookingpot.app/.env /var/www/cookingpot.app/.env.local
    ```

5. Go inside the ``.env.local`` file and adjust the URL to the location of your API web-service.

    ```
    REACT_APP_API_HOST=https://cookingpot.app
    ```

6. Build our ``react`` app for production.

    ```
    sudo npm run build
    ```

7. Open up front-end ``nginx`` server block file.

    ```
    vi /etc/nginx/sites-available/cookingpot.app.conf
    ```

8. Replace the contents of the file to look as follows:

    ```
    server {
        listen  80;

        server_name cookingpot.app www.cookingpot.app;

        location / {
            root  /var/www/cookingpot.app/build;
            index  index.html index.htm;
            try_files $uri /index.html =404;
        }

        error_page  500 502 503 504  /50x.html;
        location = /50x.html {
            root  /usr/share/nginx/html;
        }
    }
    ```

9. Go ahead and restart ``nginx`` by typing:

    ```
    $ sudo systemctl restart nginx
    ```

10. Finally open up your browser and go to your ``http://cookingpot.app``.
