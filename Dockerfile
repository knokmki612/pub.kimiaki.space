FROM curlimages/curl:8.3.0 as cert
ARG DB_TLS_CA_CERT_URL
RUN test -n $DB_TLS_CA_CERT_URL && curl -o root.crt $DB_TLS_CA_CERT_URL

FROM superseriousbusiness/gotosocial:0.11.1
ENV GTS_DB_TLS_CA_CERT=/gotosocial/root.crt
COPY --from=cert /home/curl_user/root.crt /gotosocial/root.crt
COPY ./gts.yaml /gotosocial/config.yaml
COPY ./entrypoint.sh /gotosocial/entrypoint.sh
ENTRYPOINT ["/gotosocial/entrypoint.sh"]
CMD ["server", "start"]
