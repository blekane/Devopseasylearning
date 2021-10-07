
- [HashiCorp Vault - How to install and configure HashiCorp Vault](https://www.youtube.com/watch?v=0dduB_cLp1k)

- [How to create users, policies, secrets on Vault to store server credentials](https://github.com/vipin-k/HashiCorp-Vault)

- [Github steps](https://github.com/vipin-k/HashiCorp-Vault)

### installation-steps
wget https://releases.hashicorp.com/vault/1.0.3/vault_1.0.3_linux_amd64.zip
unzip vault_1.0.3_linux_amd64.zip -d .
sudo cp vault /usr/bin/
vault

sudo mkdir /etc/vault
sudo mkdir /opt/vault-data
sudo mkdir -p /logs/vault/

## add configuration
sudo vi /etc/vault/config.json
```json
{
"listener": [{
"tcp": {
"address" : "0.0.0.0:8200",
"tls_disable" : 1
}
}],
"api_addr": "http://10.0.0.33:8200",
"storage": {
    "file": {
    "path" : "/opt/vault-data"
    }
 },
"max_lease_ttl": "10h",
"default_lease_ttl": "10h",
"ui":true
}
```
### Add vault.service
sudo vi /etc/systemd/system/vault.service
```
[Unit]
Description=vault service
Requires=network-online.target
After=network-online.target
ConditionFileNotEmpty=/etc/vault/config.json

[Service]
EnvironmentFile=-/etc/sysconfig/vault
Environment=GOMAXPROCS=2
Restart=on-failure
ExecStart=/usr/bin/vault server -config=/etc/vault/config.json
StandardOutput=/logs/vault/output.log
StandardError=/logs/vault/error.log
LimitMEMLOCK=infinity
ExecReload=/bin/kill -HUP $MAINPID
KillSignal=SIGTERM

[Install]
WantedBy=multi-user.target
```
### Stat the service and open port 8200
```sh
sudo systemctl start vault.service
sudo systemctl status vault.service

sudo ufw allow 8200/tcp
sudo ufw enable
sudo ufw status
```
 
### Initial configuration
1. put 5 in share
2. put 3 in key threshold
3. initialize and downlod the file

```json
{
  "keys": [
    "d1f9b26387193bfa5fbcf58b7fff798e049013ad0864bee0a128815310bee02135",
    "1e4f244eb3975f4b578daf1325dbaedd6ecbbd5cba6855d874337a2c81ebd9582e",
    "02214e948c49bdd2b50743fa2634227cb0bab613dc7486b9b13909838393f9eca1",
    "f90dfba0aa42375543c5512a73aee8aea5ef4e9ce8685cf44b54692adc0bc8a22f",
    "a8aef3ff160c97a1fba0b6786c5e3bc56c77349dc40fd486dc684f02995786b0aa"
  ],
  "keys_base64": [
    "0fmyY4cZO/pfvPWLf/95jgSQE60IZL7goSiBUxC+4CE1",
    "Hk8kTrOXX0tXja8TJduu3W7LvVy6aFXYdDN6LIHr2Vgu",
    "AiFOlIxJvdK1B0P6JjQifLC6thPcdIa5sTkJg4OT+eyh",
    "+Q37oKpCN1VDxVEqc67orqXvTpzoaFz0S1RpKtwLyKIv",
    "qK7z/xYMl6H7oLZ4bF47xWx3NJ3ED9SG3GhPAplXhrCq"
  ],
  "root_token": "s.sCll9wAoLY1lJt7z9TjMG60Z"
}
```