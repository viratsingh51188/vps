FROM ubuntu:latest

RUN apt update && \
    apt upgrade -y && \
    apt install -y \
    openssh-server \
    openssh-client \
    openssl \
    curl \
    wget && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/sshd

RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config && \
    echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config

RUN cat > /start.sh << 'EOF'
#!/bin/bash

# Generate random password
PASSWORD=$(openssl rand -base64 12 | tr -d '=+/')

# Set root password
echo "root:$PASSWORD" | chpasswd

echo "Starting SSH Server..."
service ssh start

echo "Starting Pinggy Tunnel..."

# Start Pinggy tunnel
ssh \
  -p 443 \
  -o StrictHostKeyChecking=no \
  -o ServerAliveInterval=30 \
  -o ExitOnForwardFailure=yes \
  -R0:localhost:22 \
  tcp@a.pinggy.io > /tmp/pinggy.log 2>&1 &

# Wait for tunnel URL
for i in {1..30}; do
    TUNNEL=$(grep '^tcp://' /tmp/pinggy.log | tail -1)

    if [ -n "$TUNNEL" ]; then
        break
    fi

    sleep 1
done

HOST=$(echo "$TUNNEL" | sed -E 's#tcp://([^:]+):([0-9]+)#\1#')
PORT=$(echo "$TUNNEL" | sed -E 's#tcp://([^:]+):([0-9]+)#\2#')

clear

echo ""
echo "========================================"
echo "         SSH ACCESS DETAILS"
echo "========================================"
echo ""
echo "Host     : $HOST"
echo "Port     : $PORT"
echo "Username : root"
echo "Password : $PASSWORD"
echo ""
echo "SSH Command:"
echo ""
echo "ssh root@$HOST -p $PORT"
echo ""
echo "========================================"
echo ""

# Keep container alive
tail -f /dev/null
EOF

RUN chmod +x /start.sh

EXPOSE 22

CMD ["/bin/bash", "/start.sh"]
