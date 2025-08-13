FROM fedora:42

COPY src /fedora-setup

RUN dnf install -y sudo

RUN useradd -m -s /bin/bash testuser && \
    echo "testuser:1234" | chpasswd && \
    echo "testuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER testuser
WORKDIR /home/testuser

CMD ["/bin/bash"]
