# sample-fluentd-log-transport

## td-agentのインストール
```
sh /var/scripts/initial/td-agent.sh
```

td-agentインストール後、実行ユーザー/グループをrootに変更
```
vi /lib/systemd/system/td-agent.service

systemctl daemon-reload
systemctl restart td-agent
```

## sender
```
<source>
  @type tail
  format none
  path /var/log/nginx/access.log
  pos_file /var/log/td-agent/pos/nginx/access.log.pos
  tag forward.access.log
</source>
<match forward.**>
  @type forward
  send_timeout 10s
  flush_interval 0.1s
  <server>
    host fluentd
    port 24224
  </server>
</match>
```

## receiver
```
<source>
  @type forward
  port 24224
  bind 0.0.0.0
  tag forward.access.log
</source>
<match forward.**>
  @type file
  format single_value
  append true
  symlink_path /var/log/td-agent-forward/nginx/access.log
  path /var/log/td-agent-forward/nginx/access.log
</match>
```
