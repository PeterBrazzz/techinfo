#!/usr/bin/env bash

#set -ex

# This function will search nginx directory. 
# If nginx is not installed this function will intall and start it. 
# If nginx is installed this function will start it and will show current version of nginx.

search_4_nginx () {
    which nginx
  if [ $? -eq 0 ]; then 
  echo "nginx is already installed"
    nginx -v
  else 
    sudo apt update -y 
    sudo apt-get install nginx -y 
    sudo chmod 777 /etc/nginx/sites-available/default
  fi
}

# This function check options -p and -w.
check_opts () {
while getopts ":p:w:" o; do
  case "${o}" in
   p) port=${OPTARG} 
      ;;
   w) wrkdir=${OPTARG} 
      ;;
   *) echo "No reasonable options found!"
      ;;
  esac
done
}

# If you wrote correct options this function will 
# change port and working dirrectory in /etc/nginx/sites-available/default 
# and this func. will reload nginx

config_changes () {
  sudo echo "
server {
	listen ${port};
	listen [::]:${port};

	server_name _;

	root ${wrkdir};
	index index.html;

	location / {
		try_files \$uri \$uri/ =404;
	}
}" > /etc/nginx/sites-available/default 
  start/reload
}


# This function delete nginx with all config. files
delete_nginx () {
  echo "Do you want to delete nginx? [y/n]"
  read answer
if [[ "$answer" == "y" ]]; then 
  sudo apt-get purge nginx nginx-common nginx-light -y
  sudo apt-get autoremove -y
  echo "nginx was deleted" 
fi
}

# This function check nginx status (running or not)
# If nginx is not running, then function will start it 
# If nginxs is running, then the function will offer to reload it
start/reload () {
  sudo service nginx status | grep "not"
if [ $? -eq 0 ]; then 
  echo "Do you want to start nginx? [y/n]"
   read answer
    if [[ "$answer" == "y" ]]; then 
      sudo service nginx start > /dev/null
      echo "nginx configuration was changed "
      echo "* nginx is running"
    fi
  else 
    echo "Do you want to reload nginx? [y/n]"
    read answer
    if [[ "$answer" == "y" ]]; then 
      sudo nginx -s reload > /dev/null
      echo "nginx configuration was changed "
      echo "* nginx are reloaded"
    fi
  fi
}

search_4_nginx 
echo "Do you want to change nginx configuration? [y/n]"
read answr 
if [[ "$answr" == "y" ]]; 
then 
  check_opts "$@"
  config_changes "$@"
else
  delete_nginx
fi

