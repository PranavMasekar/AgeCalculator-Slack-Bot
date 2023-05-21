FROM golang:1.16-alpine As builder

RUN apk add --no-cache git

WORKDIR /app

COPY . .

RUN go mod download

RUN go build -o go-slackbot .

FROM alpine:latest

RUN apk add --no-cache ca-certificates

COPY --from=builder /app/go-slackbot /app/go-slackbot

CMD ["/app/go-slackbot"]