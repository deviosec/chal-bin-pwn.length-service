FROM alpine:3.9
RUN \
    apk add --no-cache alpine-sdk && \
    mkdir -p /src
COPY chalsrc /src
WORKDIR /src
RUN gcc length-service.c -o length-service

# actual container
FROM alpine:3.9

LABEL maintainer="eyJhb"
ENV VERSION 1.0
ENV FLAG CTF{SmallServicesShouldNotPrintf}
ENV CHALTITLE Length Service
ENV BINNAME length-service
ENV CHALPORT 777
EXPOSE 80
EXPOSE 777

RUN \
    apk add --no-cache nginx busybox-extras && \
    mkdir -p /run/nginx/ && \
    mkdir -p /var/www/html/ && \
    adduser -h /home/service/ -D serviceuser 

COPY src /
COPY --from=0 /src/${BINNAME} /var/www/html/
COPY --from=0 /src/${BINNAME} /home/service/

ENTRYPOINT ["./init.sh"]
