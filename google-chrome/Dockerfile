# pull base image
FROM jlesage/baseimage-gui:ubuntu-22.04-v4

# install packages
RUN apt update && \
    apt install fonts-noto-cjk fonts-noto-cjk-extra fonts-noto-color-emoji fonts-noto-core vim wget -y

# download Google Chrome -> disable auto update -> install Google Chrome
RUN wget -O app.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    touch /etc/default/google-chrome && \
    apt install ./app.deb -y

# disable maximizing application's window
# https://github.com/jlesage/docker-baseimage-gui#maximizing-only-the-main-window
COPY main-window-selection.xml /etc/openbox/main-window-selection.xml

# copy the start script
COPY startapp.sh /startapp.sh

# set the name of the application
# https://github.com/jlesage/docker-baseimage-gui#internal-environment-variables
RUN set-cont-env APP_NAME "Google Chrome"
