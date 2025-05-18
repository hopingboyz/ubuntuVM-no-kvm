FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive


RUN apt-get update && apt-get install -y \
    qemu-kvm qemu-utils cloud-image-utils wget curl net-tools openssh-server sudo \
    && apt-get clean


RUN mkdir /var/run/sshd && \
    echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config && \
    echo 'root:root' | chpasswd


WORKDIR /root
RUN wget https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img -O ubuntu.img


RUN mkdir -p /seed
COPY user-data /seed/user-data
COPY meta-data /seed/meta-data
RUN cloud-localds /seed/seed.img /seed/user-data /seed/meta-data


COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 2222
CMD ["/start.sh"]
