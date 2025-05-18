#!/bin/bash

qemu-system-x86_64 \
  -m 4096 \
  -smp 2 \
  -drive file=ubuntu.img,format=qcow2 \
  -drive file=/seed/seed.img,format=raw \
  -net nic -net user,hostfwd=tcp::2222-:22 \
  -nographic
