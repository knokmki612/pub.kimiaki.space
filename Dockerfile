FROM litestream/litestream:0.3.9 as litestream
FROM superseriousbusiness/gotosocial:0.9.0
COPY --from=litestream /usr/local/bin/litestream /gotosocial/litestream
COPY ./gts.yaml /gotosocial/config.yaml
COPY ./entrypoint.sh /gotosocial/entrypoint.sh
ENV GTS_DB_ADDRESS=/gotosocial/sqlite.db
ENTRYPOINT ["/gotosocial/entrypoint.sh"]
CMD ["server", "start"]
