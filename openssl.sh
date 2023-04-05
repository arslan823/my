#!/bin/bash

echo "Testing OpenSSL AES128-GCM..."
openssl speed -elapsed -evp aes-128-gcm > /tmp/aes128-gcm.out

echo "Testing OpenSSL ChaCha20-Poly1305..."
openssl speed -elapsed -evp chacha20-poly1305 > /tmp/chacha20-poly1305.out

echo "Results:"
echo "OpenSSL AES128-GCM: $(cat /tmp/aes128-gcm.out | grep aes-128-gcm | awk '{print $5/1000/1000*8}' | cut -c1-5) Mbps"
echo "OpenSSL ChaCha20-Poly1305: $(cat /tmp/chacha20-poly1305.out | grep chacha20-poly1305 | awk '{print $5/1000/1000*8}' | cut -c1-5) Mbps"

rm /tmp/aes128-gcm.out /tmp/chacha20-poly1305.out
