FROM alpine:3.21.3

WORKDIR /app

COPY --from=builder /app/config_saver .

RUN addgroup appgroup && \
    adduser -S -D -H -G appgroup appuser

RUN chown -R appuser:appgroup /app
USER appuser

CMD ["./config_saver"]