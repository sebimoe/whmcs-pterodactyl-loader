FROM sebian/php-fpm-ioncube

RUN apt update && apt install -y unzip && \
    mkdir /whmcs-docker

ADD whmcs-startup-unzip.sh /whmcs-docker/whmcs-startup-unzip.sh

CMD [ "/bin/bash", "/whmcs-docker/whmcs-startup-unzip.sh" ]
