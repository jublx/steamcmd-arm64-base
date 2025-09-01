FROM redhat/ubi9 AS builder

RUN dnf update -y \
    && curl -sSL -o /tmp/epel-release.rpm 'https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm' \
    && dnf install -y /tmp/epel-release.rpm \
    && dnf install -y \
    git \
    cmake \
    ninja-build \
    pkg-config \
    ccache \
    clang \
    lld \
    llvm \
    llvm-devel \
    openssl-devel \
    python3-clang \
    && dnf clean all

WORKDIR /tmp

RUN git clone --recurse-submodules --depth 1 --branch "FEX-2508.1" https://github.com/FEX-Emu/FEX.git \
    && cd FEX \
    && mkdir Build \
    && cd Build \
    && CC=clang CXX=clang++ cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release -DUSE_LINKER=lld -DBUILD_FEXCONFIG=False -DENABLE_LTO=True -DBUILD_TESTS=False -DENABLE_ASSERTIONS=False -DUSE_LEGACY_BINFMTMISC=True -G Ninja .. \
    && ninja

WORKDIR /tmp/FEX/Build

RUN ninja install -j4

WORKDIR /tmp/steam

RUN curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf -

FROM redhat/ubi9-minimal

RUN useradd -m -s /bin/bash steam

COPY --from=builder /usr/bin/FEX* /usr/bin
COPY --from=builder /tmp/epel-release.rpm /tmp
COPY --from=builder --chown=steam /tmp/steam /home/steam

RUN microdnf update -y \
    && rpm -ivh /tmp/epel-release.rpm \
    && microdnf install -y fuse squashfuse glibc-langpack-en \
    && microdnf clean all \
    && rm -f /tmp/epel-release.rpm

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

USER steam

WORKDIR /home/steam

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["bash"]
