vdrProxy
========

A small flask app to proxy requests between Plex Media Server and the VDR together with the
restfulapi and the streamdev-server plugin.

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

#### upstart configuration
An upstart script for older Ubuntu installations can be found in vdrproxy.upstart (change paths to your setup), install with:

    ```
    $ sudo cp vdrproxy.upstart /etc/init/vdrproxy.conf
    $ sudo start vdrproxy
    ```

#### Plex configuration
Enter the virtual host name as the DVR device address (port not required): ```vdrproxy```

#### VDR configuration
For the configuration of the VDR, the restful and the streamdev-server plugin use the
vdr-wiki, or ask in the vdr-portal. The streamdev-server requires the provided externremux.sh
script. Change the streamdev-server configuration so that is used.
