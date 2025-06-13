FROM golang:1.21-alpine AS builder
WORKDIR /app
COPY main.go .
RUN go build -o word-emitter main.go

FROM alpine
WORKDIR /app
COPY --from=builder /app/word-emitter .
CMD ["./word-emitter"]
