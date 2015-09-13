FROM ubuntu:14.04
MAINTAINER lrivallain (https://github.com/lrivallain) - based on Arcus ("http://arcus.io") work
RUN apt-get update -qq && RUNLEVEL=1 DEBIAN_FRONTEND=noninteractive \
    apt-get install -y -qq cron munin munin-node nginx apache2 wget
RUN (cp /etc/munin/apache.conf /etc/apache2/sites-enabled/default)
RUN (sed -i 's/^Alias.*/Alias \/ \/var\/cache\/munin\/www\//g' /etc/apache2/sites-enabled/default)
RUN (sed -i 's/Allow from localhost.*/Allow from all/g' /etc/apache2/sites-enabled/default)
RUN (mkdir -p /var/run/munin && chown -R munin:munin /var/run/munin)
ADD run.sh /usr/local/bin/run
VOLUME /var/lib/munin
VOLUME /var/log/munin
EXPOSE 80
CMD ["/usr/local/bin/run"]
