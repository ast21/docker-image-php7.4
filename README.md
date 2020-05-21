### Using Watchtower

for automatic pulling updates from server every 5 min

```bash
docker run -d \
    --name watchtower \
    -v /var/run/docker.sock:/var/run/docker.sock \
    containrrr/watchtower breakhack/php7.4
```
