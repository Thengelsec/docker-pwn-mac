FROM --platform=linux/amd64 ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    sudo gdb gcc python3 python3-pip vim git \
    libc6-dev libseccomp-dev netcat \
    && pip3 install pwntools

RUN useradd -m -s /bin/bash user && \
    echo "user:0000" | chpasswd && \
    usermod -aG sudo user
# can change username
USER user
WORKDIR /home/user

CMD ["/bin/bash"]