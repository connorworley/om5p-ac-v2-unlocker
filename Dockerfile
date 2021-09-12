FROM ubuntu:latest
RUN apt-get update && apt-get install -y atftpd build-essential curl make xz-utils
RUN curl -sSL https://downloads.openwrt.org/releases/19.07.8/targets/ar71xx/generic/openwrt-sdk-19.07.8-ar71xx-generic_gcc-7.5.0_musl.Linux-x86_64.tar.xz \
    | tar -xJf - -C /opt
ADD . /src
WORKDIR /src
RUN make TOOLCHAIN_DIR=/opt/openwrt-sdk-19.07.8-ar71xx-generic_gcc-7.5.0_musl.Linux-x86_64/staging_dir/toolchain-mips_24kc_gcc-7.5.0_musl
RUN chown nobody output/*
CMD atftpd --daemon --no-fork --logfile=/dev/tty --verbose=7 --trace --bind-address 0.0.0.0 /src/output
