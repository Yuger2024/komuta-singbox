FROM golang:1.25-bookworm AS builder
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*
WORKDIR /src
RUN git clone --depth 1 --branch v1.14.4 https://github.com/SagerNet/sing-box.git .
RUN go mod edit -require=google.golang.org/grpc@v1.79.3 && go mod tidy
RUN CGO_ENABLED=0 go build -trimpath -ldflags "-s -w" -o /sing-box ./cmd/sing-box

FROM alpine:latest
RUN apk add --no-cache ca-certificates
COPY --from=builder /sing-box /usr/local/bin/sing-box
COPY config.json /etc/sing-box/config.json
EXPOSE 8080
ENTRYPOINT ["sing-box", "run", "-c", "/etc/sing-box/config.json"]
