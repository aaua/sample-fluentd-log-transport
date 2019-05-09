#!/usr/bin/env sh

echo "*** install ***"
echo "  td-agent"
echo "***************"

curl -L https://toolbelt.treasuredata.com/sh/install-amazon2-td-agent3.sh | sh

systemctl enable td-agent.service
systemctl start td-agent.service
