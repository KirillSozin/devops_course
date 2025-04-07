FROM golang:alpine AS builder

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN go build -o config_saver -trimpath ./cmd/app/main.go

FROM alpine

WORKDIR /app

COPY --from=builder /app/config_saver .

RUN addgroup appgroup && \
    adduser -S -D -H -G appgroup appuser

RUN chown -R appuser:appgroup /app
USER appuser

CMD ["./config_saver"]