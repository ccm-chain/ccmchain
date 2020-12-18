# Build Gccm in a stock Go builder container
FROM golang:1.15-alpine as builder

RUN apk add --no-cache make gcc musl-dev linux-headers git

ADD . /ccmchain
RUN cd /ccmchain && make gccm

# Pull Gccm into a second stage deploy alpine container
FROM alpine:latest

RUN apk add --no-cache ca-certificates
COPY --from=builder /ccmchain/build/bin/gccm /usr/local/bin/

EXPOSE 8085 8086 10101 10101/udp
ENTRYPOINT ["gccm"]
