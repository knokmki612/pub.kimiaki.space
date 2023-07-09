FROM litestream/litestream:0.3.9 as litestream
FROM debian:bookworm-slim

WORKDIR /workdir

VOLUME ["/workdir/output"]

RUN apt-get update \
 && apt-get install -y sqlite3 ca-certificates \
 && rm -rf /var/lib/apt/lists/*

COPY --from=litestream /usr/local/bin/litestream ./litestream
COPY entrypoint.sh ./entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
