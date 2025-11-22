FROM ubuntu:24.04

WORKDIR /workspace

RUN apt-get update

RUN apt-get install -y \
    bc \
    binutils \
    build-essential \
    bzip2 \
    cpio \
    curl \
    debianutils \
    diffutils \
    file \
    findutils \
    gawk \
    gcc \
    g++ \
    git \
    gzip \
    libncurses-dev \
    make \
    openssh-client \
    patch \
    perl \
    python3 \
    rsync \
    sed \
    tar \
    unzip \
    wget

RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - \
    && apt-get install -y nodejs

RUN rm -rf /var/lib/apt/lists/*

CMD ["/bin/bash"]
