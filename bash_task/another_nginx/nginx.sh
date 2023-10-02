#!/usr/bin/env bash

set -e

install_or_update() {
    if (command -v nginx); then
        nginx -v
        nginx_updating
    else
        nginx_installation
    fi
}

nginx_installation() {
    echo "Nginx are not installed on your computer."
    echo "Do you want to install NGINX? [y/n]"
    read answer
    case $answer in
        "y")
            echo "Installation..."
            apt update -y
            apt install nginx -y
            nginx -v
            ;;
        "n") exit ;;
        *) echo "[ERROR]: Unknown argument."; exit 1 ;;
    esac
}

nginx_updating() {
    echo "Do you want to update current version of NGINX? [y/n]"
    read answer
    case $answer in
        "y")
            echo "Updating..."
            apt update  &>/dev/null
            apt upgrade nginx -y &>/dev/null
            nginx -v
            ;;
        "n") return;;
        *) echo "[ERROR]: Unknown argument." ; exit 1 ;;
    esac
}

check_empty_params() {
    if [[ "${port}" == "-w" ]] || [[ "${work_dir}" == "-p" ]] ; then
        echo "Usage: $0 [-p <PORT_NUMBER>] [-w <WORKDIR>]" 1>&2
        exit 1
    fi
}

get_params() {
    while getopts ":p:w:" arg; do
        case $arg in
            p) port="${OPTARG}";;
            w) work_dir="${OPTARG}";;
            *) echo "Usage: $0 [-p <PORT_NUMBER>] [-w <WORKDIR>]" 1>&2; exit 1 ;;
        esac
    done
        shift $((${OPTIND} - 1))
}

generate_custom_config() {
    echo "
    server {
        listen ${port};
        listen [::]:${port};

        server_name example.ubuntu.com;

        root ${work_dir};
        index index.html;

        location / {
                try_files \$uri \$uri/ =404;
        }
    }" > /etc/nginx/sites-enabled/default
}

update_config() {
    echo "Do you want to update NGINX configuration? [y/n]"
    read answer
    case $answer in
        "y")
            echo "Updating..."
            generate_custom_config
            service nginx restart &>/dev/null
            ;;
        "n") return;;
        *) echo "[ERROR]: Unknown argument."; exit 1 ;;
    esac
}

delete_nginx() {
   echo "Do you want to delete NGINX? [y/n]"
    read answer
    case $answer in
        "y")
            echo "Deleting..."
            apt purge nginx -y &>/dev/null
            apt autoremove -y &>/dev/null
            echo "Delete successfully."
            ;;
        "n") return;;
        *) echo "[ERROR]: Unknown argument."; exit 1;;
    esac
}

get_params "$@"
check_empty_params
install_or_update
update_config
delete_nginx
