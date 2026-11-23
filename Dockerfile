FROM ghcr.io/sagernet/sing-box:v1.14.4
COPY config.json /etc/sing-box/config.json
EXPOSE 8080
ENTRYPOINT ["sing-box"]
CMD ["run", "-c", "/etc/sing-box/config.json"]





