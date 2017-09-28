#!/bin/bash
set -e

INSTALL_FLAG=/var/lib/mayan/settings/local.py
MAYAN_INSTALL_DIR=/usr/local/lib/python2.7/dist-packages/mayan

# Setup defaults
export MAYAN_NGINX_CLIENT_MAX_BODY_SIZE=${MAYAN_NGINX_CLIENT_MAX_BODY_SIZE:-500M}
export MAYAN_NGINX_PROXY_READ_TIMEOUT=${MAYAN_NGINX_PROXY_READ_TIMEOUT:-600s}

render_settings_local() {
    if [ "${MAYAN_SETTINGS_LOCAL_STRING}" ] || [ "${MAYAN_SETTINGS_LOCAL_FILE}" ]; then
        cp $MAYAN_INSTALL_DIR/settings/local.py $MAYAN_INSTALL_DIR/media/settings/local.py

        if [ "${MAYAN_SETTINGS_LOCAL_FILE}" ]; then
            cat "${MAYAN_SETTINGS_LOCAL_FILE}" >> $MAYAN_INSTALL_DIR/media/settings/local.py
        fi

        if [ "${MAYAN_SETTINGS_LOCAL_STRING}" ]; then
            printf "${MAYAN_SETTINGS_LOCAL_STRING}" >> $MAYAN_INSTALL_DIR/media/settings/local.py
        fi
    fi
}

initialize() {
    mayan-edms.py createsettings
    # Copy the generated local.py with the SECRET KEY to the volume
    cp -n $MAYAN_INSTALL_DIR/settings/local.py $MAYAN_INSTALL_DIR/media/settings/local.py
    render_settings_local || true
    chown -R www-data:www-data $MAYAN_INSTALL_DIR
    mayan-edms.py initialsetup
}

upgrade() {
    mayan-edms.py performupgrade
    mayan-edms.py collectstatic --noinput --clear
}

setup_nginx() {
    envsubst < /etc/nginx/sites-available/mayan-edms.template > /etc/nginx/sites-enabled/mayan-edms
}

start() {
    setup_nginx
    rm -rf /var/run/supervisor.sock
    exec /usr/bin/supervisord -nc /etc/supervisor/supervisord.conf
}

apt_installs() {
    if [ "${MAYAN_APT_INSTALLS}" ]; then
        apt-get-install $MAYAN_APT_INSTALLS
    fi
}

pip_installs() {
    if [ "${MAYAN_PIP_INSTALLS}" ]; then
        pip install $MAYAN_PIP_INSTALLS
    fi
}

apt_installs || true
pip_installs || true

if [ "$1" = 'mayan' ]; then
    # Check if this is a new install, otherwise try to upgrade the existing
    # installation on subsequent starts
    if [ ! -f $INSTALL_FLAG ]; then
       initialize
    else
       upgrade
    fi
    start
fi

exec "$@"
