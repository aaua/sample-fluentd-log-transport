#!/usr/bin/env sh
PKG=$( \
    amazon-linux-extras install --list | awk 'match($0, /nginx[0-9]+\.[0-9]+/) {print substr($0, RSTART, RLENGTH)}' \
)
echo "*** install ***"
echo "  ${PKG}"
echo "***************"

amazon-linux-extras install -y ${PKG}
systemctl enable nginx.service
systemctl start nginx.service
