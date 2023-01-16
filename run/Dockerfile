FROM litestream/litestream:latest as litestream
FROM superseriousbusiness/gotosocial:latest
COPY --from=litestream /usr/local/bin/litestream /gotosocial/litestream
COPY ./gts.yaml /gotosocial/config.yaml
COPY ./entrypoint.sh /gotosocial/entrypoint.sh
ENV GTS_DB_ADDRESS=/gotosocial/sqlite.db
ENTRYPOINT ["/gotosocial/entrypoint.sh"]
