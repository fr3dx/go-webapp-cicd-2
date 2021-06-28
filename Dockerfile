FROM golang:1.12.0-alpine3.9 AS builder

RUN mkdir /app

ADD main.go /app

WORKDIR /app

RUN go build -o main .

FROM alpine

WORKDIR /app

COPY --from=builder /app/main /app/

CMD ["/app/main"]