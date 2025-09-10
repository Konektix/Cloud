# Cloud

```
./scripts/start.sh
```
optional argument: --env-file

```
./scripts/stop.sh
```

## Keycloak initialization

### Creating clients for services

Get into keycloak_container
```
docker exec -it {container_id} bash 
```

Run initialization script
```
./keycloak-config-init.sh
```