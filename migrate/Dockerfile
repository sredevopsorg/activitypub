FROM debian:bookworm-slim as builder

# Set the ARCH variable by executing a command on the host.
RUN --mount=type=bind,source=/etc/os-release,target=/etc/os-release,readonly \
    ARCH=$(dpkg --print-architecture) && \
    curl -L https://github.com/golang-migrate/migrate/releases/download/v4.17.1/migrate.linux-$ARCH.tar.gz | tar xvz && \
    mv migrate /usr/bin/

# Final stage
FROM debian:bookworm-slim

COPY --from=builder /usr/bin/migrate /usr/bin/migrate

COPY bin /usr/local/bin
COPY ./migrations /migrations

ENV MYSQL_DB=""

CMD ["up"]
