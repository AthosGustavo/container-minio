FROM quay.io/minio/minio
COPY public-bucket-policy.json /etc/minio/public-bucket-policy.json
VOLUME /data
VOLUME /var/log/minio
EXPOSE 9000 9001
ENTRYPOINT ["minio","server", "/data", "--console-address", ":9001"]

