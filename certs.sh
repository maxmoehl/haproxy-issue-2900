#!/bin/sh -e

step certificate create \
  --insecure --no-password \
  --profile root-ca \
  --kty RSA \
  "HAProxy CA" ca.crt.pem ca.key.pem

step certificate create \
  --insecure --no-password --force \
  --profile leaf \
  --kty RSA \
  --ca ca.crt.pem \
  --ca-key ca.key.pem \
  --san '*.example.com' \
  --san '*.one.example.com' \
  --san '*.two.example.com' \
  "HAProxy Server Cert" crt.pem key.pem

cat crt.pem key.pem > tls.pem
