FROM quay.io/minio/minio
ENV MINIO_ROOT_USER=admin
ENV MINIO_ROOT_PASSWORD=admin123
COPY public-bucket-policy.json /etc/minio/public-bucket-policy.json
VOLUME app/data
VOLUME /var/log/minio
EXPOSE 9000 9001
ENTRYPOINT ["minio"]
CMD ["server", "app/data", "--console-address", ":9001"]
