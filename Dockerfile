FROM curlimages/curl:8.3.0 as cert
ARG DB_TLS_CA_CERT_URL
FROM superseriousbusiness/gotosocial:0.11.1
COPY ./gts.yaml /gotosocial/config.yaml
COPY ./entrypoint.sh /gotosocial/entrypoint.sh
ENTRYPOINT ["/gotosocial/entrypoint.sh"]
CMD ["server", "start"]
