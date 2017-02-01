FROM ubuntu:16.04

#
# Packages and dependencies
#
RUN echo "Installing Packages..." \
    && apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y \
        build-essential \
        default-jre \
        git \
        libfontconfig \
        ruby \
        ruby-dev \
        unzip \
        vim  \
        wget \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean all \
    && echo "DONE"


# Create user to run webserver and shell commands as
# These need to be the same because the web app requires writable access to many
# directories
RUN useradd --create-home --uid 5000 --shell /bin/bash limsuser && \
    usermod --lock limsuser && \
    chown -R limsuser:limsuser ~limsuser/


#
# Sencha CMD 4.x
#
# compass requires: build-essential libfontconfig ruby ruby-dev
#
ARG SenchaVersion=4.0.2.67
RUN echo "Installing Sencha Cmd..." \
    && gem install compass \
    && cd /tmp \
    && wget http://cdn.sencha.com/cmd/${SenchaVersion}/SenchaCmd-${SenchaVersion}-linux-x64.run.zip \
    && unzip SenchaCmd-${SenchaVersion}-linux-x64.run.zip \
    && chmod +x SenchaCmd-${SenchaVersion}-linux-x64.run \
    && ./SenchaCmd-${SenchaVersion}-linux-x64.run --mode unattended --prefix ~limsuser/sencha \
    && chown -R limsuser:limsuser ~limsuser/sencha \
    && echo "export PATH=$PATH:~/sencha/Sencha/Cmd/${SenchaVersion}" >> ~limsuser/.bash_profile \
    && rm \
        SenchaCmd-${SenchaVersion}-linux-x64.run.zip \
        SenchaCmd-${SenchaVersion}-linux-x64.run \
    && echo "DONE"


COPY resources/root/docker-entrypoint.sh /root/
COPY resources/usr/local/bin/dockerlims-shell /usr/local/bin/

WORKDIR /var/www/html/Ext

# NOTE: must use json syntax process is not started in a subshell (and signals are passed correctly)
ENTRYPOINT ["/root/docker-entrypoint.sh"]
