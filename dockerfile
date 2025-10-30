FROM alpine:3.18
WORKDIR /app
RUN apk add --no-cache bash curl jq
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["bash", "/entrypoint.sh"]
