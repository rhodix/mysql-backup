# mysql backup image
FROM alpine:3.9
MAINTAINER Avi Deitcher <https://github.com/deitch>

# install the necessary client
RUN apk add --update mysql-client mariadb-connector-c bash python3 samba-client shadow && \
    rm -rf /var/cache/apk/* && \
    touch /etc/samba/smb.conf && \
    pip3 install awscli

# set us up to run as non-root user
RUN groupadd -g 1005 appuser && \
    useradd -r -u 1005 -g appuser appuser
# ensure smb stuff works correctly
RUN mkdir -p /var/cache/samba && chmod 0755 /var/cache/samba && chown appuser /var/cache/samba
USER appuser

# install the entrypoint
COPY functions.sh /
COPY scripts.d/post-restore/* /scripts.d/post-restore/
COPY scripts.d/post-backup/* /scripts.d/post-backup/
RUN chmod -R ug+x /scripts.d
COPY entrypoint /entrypoint

# start
ENTRYPOINT ["/entrypoint"]
