#!/usr/bin/env bash

set -e

if [ "$#" -lt 1 ]; then
  echo "Usage: ${0} <hostname> <port> <servername>"
  exit 1
fi

target="${1}:${2}"

# All versions currenlty support by openssl.
TLS_VERSIONS=(ssl3 tls1 tls1_1 tls1_2 tls1_3)

echo "# tls versions"
for tls_version in "${TLS_VERSIONS[@]}"; do
  if echo Q | openssl s_client -connect "${target}" -servername "${3}" "-${tls_version}" &> /dev/null; then
    echo "${tls_version}"
  fi
done

# We are not interested in ciphers for older versions of TLS, this script does not have to be
# feature complete.

echo "# tls1_2 ciphers"
openssl ciphers -stdname | grep -F "TLSv1.2" | awk '{ print $3 }' | while read -r cipher; do
  if echo Q | openssl s_client -connect "${target}" -servername "${3}" -cipher "${cipher}" -tls1_2 &> /dev/null; then
    echo "${cipher}"
  fi
done

echo "# tls1_3 ciphersuites "
openssl ciphers -stdname | grep -F "TLSv1.3" | awk '{ print $3 }' | while read -r ciphersuite; do
  if echo Q | openssl s_client -connect "${target}" -servername "${3}" -ciphersuites "${ciphersuite}" -tls1_3 &> /dev/null; then
    echo "${ciphersuite}"
  fi
done
