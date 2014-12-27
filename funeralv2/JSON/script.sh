#!/bin/bash 

# change the end point to the 
endpoint=161

wget 'http://appcms-id.appitized-dev.com/api/'$endpoint'/locations' -O location.json

wget 'http://appcms-id.appitized-dev.com/api/'$endpoint'/services' -O services.json

wget 'http://appcms-id.appitized-dev.com/api/'$endpoint'/item-list' -O items.json

wget 'http://appcms-id.appitized-dev.com/api/'$endpoint'/todo' -O todo-list.json

wget 'http://appcms-id.appitized-dev.com/api/'$endpoint'/config' -O config.json

wget 'http://appcms-id.appitized-dev.com/api/'$endpoint'/product' -O products.json

wget 'http://appcms-id.appitized-dev.com/api/'$endpoint'/condolence-messages' -O condolence.json

wget 'http://appcms-id.appitized-dev.com/api/'$endpoint'/funerals' -O funerals.json