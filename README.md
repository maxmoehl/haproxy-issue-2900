### Dependencies

* docker with compose
* step-cli (only if you want to re-generate the certs)
* openssl

### Steps to test

1. Generate certs (or use the ones checked in) via `./certs.sh`.
2. Bring up the env via `docker compose up`.
3. Scan for the currently available TLS ciphers, should look like [1].
4. Run `./replace-cert.sh`.
5. Scan again, now [2] should be outputted.


[1]

```
$ ./tls-scan.sh 127.0.0.1 8443 foo.cf.example.com
# tls versions
tls1_2
tls1_3
# tls1_2 ciphers
ECDHE-RSA-AES256-GCM-SHA384
ECDHE-RSA-CHACHA20-POLY1305
ECDHE-RSA-AES128-GCM-SHA256
# tls1_3 ciphersuites
TLS_AES_256_GCM_SHA384
TLS_CHACHA20_POLY1305_SHA256
TLS_AES_128_GCM_SHA256
```

[2]
```
$ ./tls-scan.sh 127.0.0.1 8443 foo.cf.example.com
# tls versions
tls1_2
tls1_3
# tls1_2 ciphers
ECDHE-RSA-AES256-GCM-SHA384
ECDHE-RSA-CHACHA20-POLY1305
ECDHE-RSA-AES128-GCM-SHA256
ECDHE-RSA-AES256-SHA384
ECDHE-RSA-AES128-SHA256
AES256-GCM-SHA384
AES128-GCM-SHA256
AES256-SHA256
AES128-SHA256
# tls1_3 ciphersuites
TLS_AES_256_GCM_SHA384
TLS_CHACHA20_POLY1305_SHA256
TLS_AES_128_GCM_SHA256
```
