FROM quay.io/minio/minio
ENV MINIO_ROOT_USER=rasadmin
ENV MINIO_ROOT_PASSWORD=rasositaliano
COPY public-bucket-policy.json /etc/minio/public-bucket-policy.json
COPY config-user-permission-prod.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/config-user-permission-prod.sh
VOLUME app/data
VOLUME /var/log
EXPOSE 9000 9001
ENTRYPOINT ["/usr/local/bin/config-user-permission-prod.sh"]

