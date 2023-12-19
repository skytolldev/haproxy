FROM docker.io/alpine:latest

# install haproxy and bash packages
RUN apk --no-cache add haproxy bash

# prepare local configuration structure
RUN mkdir              -p /usr/local/etc/haproxy/conf.d
COPY conf/haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg
RUN chown root:        -R /usr/local/etc/haproxy
RUN chmod u=rwX,go=rX  -R /usr/local/etc/haproxy

# prepare data volume
RUN mkdir              -p /srv/data
RUN chown root:        -R /srv/data
RUN chmod u=rwX,go=rX  -R /srv/data

# volumes declarations
VOLUME /usr/local/etc/haproxy/conf.d
VOLUME /srv/data

# prepare entrypoint
COPY entrypoint.bash /usr/local/bin/entrypoint.bash
RUN chmod u=rwx,go=rx /usr/local/bin/entrypoint.bash

# make /var/lib/haproxy/sock writable by haproxy
RUN mkdir               -p /var/lib/haproxy/sock
RUN chown haproxy:      -R /var/lib/haproxy/sock
RUN chmod ug=rwX,o-rwx  -R /var/lib/haproxy/sock

# 'haproxy' user is present after
#  installing 'haproxy' software via apk
USER haproxy
ENTRYPOINT ["/usr/local/bin/entrypoint.bash"]
