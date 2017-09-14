# docker deployement

## Create docker network :
```
docker network create --subnet=192.168.0.0/24 national7
```

## Build containers
- Core
```
docker build https://github.com/gwendal-orinel-pro/docker.git#master:core -t core
```

- Checker
```
docker build https://github.com/gwendal-orinel-pro/docker.git#master:checker -t checker
```

- Dnspub
```
docker build https://github.com/gwendal-orinel-pro/docker.git#master:dnspub -t dnspub
```

- Supermonkey
```
docker build https://github.com/gwendal-orinel-pro/docker.git#master:supermonkey -t supermonkey
```

## Run containers:
- Core
```
docker run -d --name=core --net=national7 --ip 192.168.0.2 -v /var/docker/core/bind:/etc/bind:z -v /var/docker/core/consul:/consul:z core
```

- Checker
```
docker run -d --name=checker --net=national7 --ip=192.168.0.3 -p 8500:8500 -v /var/docker/checker/consul:/consul:z checker
```

- Dnspub
```
docker run -d --name=dnspub -p 53:53 -p 53:53/udp --net=national7 --ip 192.168.0.4 -v /var/docker/dnspub/bind:/etc/bind:z dnspub
```

- Supermonkey
```
docker run -d --name=supermonkey -h supermonkey --add-host "core:192.168.0.2" --add-host "checker:192.168.0.3" --add-host "dnspub:192.168.0.4" --net=national7 --ip=192.168.0.5 -p 80:80 -p 443:8500 -v /var/docker/supermonkey/consul:/consul:z -v /var/run/docker.sock:/var/run/docker.sock supermonkey
```

