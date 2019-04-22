# HOWTO: Setup Lets Encrypt
## Description
This article assumes you've completed the previous articles. These instructions were modified from [DigitalOcean](https://www.digitalocean.com/community/tutorials/how-to-secure-nginx-with-let-s-encrypt-on-centos-7).

## Instruction
The following instructions are used to manually setup `letsencrypt` and automatically integrate with `nginx`.

1. Install our **Lets Encrypt** client.

  ```
  $ sudo yum install -y certbot-nginx
  ```


6. Generate our certificate.

  ```
  $ sudo certbot --nginx -d leiwei.co -d www.leiwei.co
  $ sudo certbot --nginx -d hardy.games -d hardy.games
  $ sudo certbot --nginx -d mikezhouxun.com -d mikezhouxun.com
  $ sudo certbot --nginx -d roberthao.com -d roberthao.com
  $ sudo certbot --nginx -d cookingpot.app -d cookingpot.app
  ```


7. Follow the instructions and choose the most appropriate options.


8. **(Optional)** Please make a copy of the ``/etc/letsencrypt`` file.


9. Restart ``nginx``.

  ```
  $ sudo systemctl restart nginx
  ```


10. Upgrade the security by following the instructions - https://www.digitalocean.com/community/tutorials/how-to-secure-nginx-with-let-s-encrypt-on-centos-7. Please see the **Step 5 — Updating Diffie-Hellman Parameters** section.


11. Restart the server.

    ```
    $ sudo systemctl restart nginx
    ```


12. Would you like to know more?


### HOW DO WE AUTO RENEW?
https://certbot.eff.org/lets-encrypt/centosrhel7-nginx.html

sudo crontab -e

# Add this to the crontab and save it:
0 0,12 * * * python -c 'import random; import time; time.sleep(random.random() * 3600)' && /usr/bin/certbot renew && systemctl restart nginx


### Nginx + SSL
If your SSL is not being populated at your address then follow these.


### Is it secure?

Enter the following URL to your browser.

   ```
   https://www.ssllabs.com/ssltest/analyze.html?d=leiwei.co
   https://www.ssllabs.com/ssltest/analyze.html?d=hardy.games
   https://www.ssllabs.com/ssltest/analyze.html?d=mikezhouxun.com
   https://www.ssllabs.com/ssltest/analyze.html?d=roberthao.com
   https://www.ssllabs.com/ssltest/analyze.html?d=cookingpot.app
   ```
