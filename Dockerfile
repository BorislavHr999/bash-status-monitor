FROM debian:stable-slim
LABEL maintainer="Borislav Hristov/BorislavHr999"
LABEL description="A simple system monitor script."
RUN apt-get update && apt-get install -y \
    bash \
    curl \
    procps \
    iproute2 \
    net-tools \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /usr/local/bin
COPY status2.sh .
RUN chmod +x status2.sh
CMD ["./status2.sh"]