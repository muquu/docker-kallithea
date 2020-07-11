#!/bin/bash 
echo "Restart nginx service"
service nginx restart
echo "Starting kallithea"
gearbox serve -c /srv/kallithea/my.ini