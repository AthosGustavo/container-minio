FROM quay.io/minio/minio
ENV MINIO_ROOT_USER=ras
ENV MINIO_ROOT_PASSWORD=ositalianoras
COPY public-bucket-policy.json /etc/minio/public-bucket-policy.json
COPY start-minio-dev.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/start-minio-dev.sh
VOLUME app/data
VOLUME /var/log
EXPOSE 9000 9001
ENTRYPOINT ["sh", "-c", "minio server /data --console-address :9001 >> /var/log/minio/minio.log 2>&1"]


