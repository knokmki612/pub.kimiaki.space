FROM superseriousbusiness/gotosocial:0.19.1
COPY ./gts.yaml /gotosocial/config.yaml
COPY ./entrypoint.sh /gotosocial/entrypoint.sh
ENTRYPOINT ["/gotosocial/entrypoint.sh"]
CMD ["server", "start"]
