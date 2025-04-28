**Troubleshooting Internal Web Dashboard Connectivity**

---

# 1. Verify DNS Resolution

## Check Current Resolver:
```bash
cat /etc/resolv.conf
```

## Query with Internal DNS:
```bash
dig internal.example.com
```

## Query with Public DNS (8.8.8.8):
```bash
dig @8.8.8.8 internal.example.com
```

Compare results to find DNS issues.

---

# 2. Diagnose Service Reachability

## Ping Domain:
```bash
ping internal.example.com
```

## Test Ports (80/443):
```bash
telnet 142.186.101.96 80
curl http://142.186.101.96
telnet 142.186.101.96 443
curl https://142.186.101.96
```

## Check Service Listening On Server Side:
```bash
netstat -tuln | grep ':80\|:443'
```

---
# 3. Fixes 

## 3.1 Server Side Fixes

## Allow Ports on Firewall
```bash
sudo ufw allow 80,443/tcp
sudo ufw reload
```

## Restart Web Server
```bash
sudo systemctl restart nginx
# or
sudo systemctl restart apache2
```


<br/><br/><br/>

## 3.2 Client Side Fixes

## Fix /etc/resolv.conf
```bash
sudo nano /etc/resolv.conf
# Set correct DNS server:
nameserver 127.0.0.53
```

## Restart Network Services
```bash
sudo systemctl restart systemd-networkd
```

# 3. Possible Causes
- Bad DNS record
- Wrong /etc/resolv.conf settings
- Firewall blocking
- Service only listening on localhost
- Network route issue


---

# 4. Propose & Apply Fixes

| Cause | Confirm | Fix |
|:----|:-----|:----|
| Bad DNS record | dig result wrong IP | Update DNS records|
| /etc/resolv.conf wrong | cat /etc/resolv.conf | Edit resolv.conf, correct DNS IP |
| Firewall block | telnet or nc fails | sudo ufw allow 80,443/tcp |
| Service not listening | `netstat -tuln \| grep ':80\\|:443'` shows no 80/443 | Restart web server |

---

# Bonus

## Bypass DNS with /etc/hosts:
```bash
sudo nano /etc/hosts
# Add line:
142.186.101.96 internal.example.com
```

## Persist DNS Settings (systemd-resolved):
```bash
sudo systemctl enable systemd-resolved
sudo systemctl restart systemd-resolved
```

Edit `/etc/systemd/resolved.conf`:
```bash
[Resolve]
DNS=127.0.0.53
```
Restart service:
```bash
sudo systemctl restart systemd-resolved
```

