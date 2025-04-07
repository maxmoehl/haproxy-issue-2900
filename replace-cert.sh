#!/bin/sh -ex

docker compose exec -u root haproxy bash -c 'apt update && apt install -y socat'

docker compose exec -u root haproxy bash -c 'echo -e "set ssl cert /usr/local/etc/haproxy/tls.pem <<\n$(sed -n "/^$/d;/-BEGIN/,/-END/p" /usr/local/etc/haproxy/tls.pem)\n" | socat /tmp/haproxy.sock -'
docker compose exec -u root haproxy bash -c 'echo "commit ssl cert /usr/local/etc/haproxy/tls.pem" | socat /tmp/haproxy.sock -'
