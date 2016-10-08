vdrProxy
========

A small flask app to proxy requests between Plex Media Server and Tvheadend.

#### vdrProxy configuration
1. In vdrProxy.py configure options as per your setup.
2. Install dependencies you can use your distibution's packages:
   ```
   sudo apt-get install python-gevent python-flask python-requests
   ```
   or create a virtual environment as described below):

### create a virtual python environment
1. Create a virtual enviroment: ```$ virtualenv venv```
2. Activate the virtual enviroment: ```$ . venv/bin/activate```
3. Install the requirements: ```$ pip install -r requirements.txt```
4. Finally run the app with: ```$ python vdrProxy.py```

#### Virtual host configuration
1. Add an entry in /etc/hosts file (or whatever your OS uses) on the machine running PMS:

    ```
    127.0.0.1	localhost
    127.0.0.1	vdrproxy
    ```

#### Configure web server (virtual host)
2. Configure a web server virtual host to listen for PMS on port 80 and proxy to vdrProxy on port 5004.
    
    Nginx example:

    ```
    server {
        listen       80;
        server_name  vdrproxy;
        location / {
            proxy_pass http://127.0.0.1:5004;
        }
    }
    ```

#### systemd service configuration
A startup script for Ubuntu can be found in vdrProxy.service (change paths to your setup), install with:

    ```
    $ sudo cp vdrProxy.service /etc/systemd/system/vdrProxy.service
    $ sudo systemctl daemon-reload
    $ sudo systemctl enable vdrProxy.service
    $ sudo systemctl start vdrProxy.service
    ```

#### Plex configuration
Enter the virtual host name as the DVR device address (port not required): ```vdrproxy```
