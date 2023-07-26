
## use

### 在go專案目錄使用
```bash
docker run --rm -it --name telepresence_$(basename `pwd`) --privileged -v $(pwd):/go/src/code telepresence:latest bash
```



### telepresence
```bash
telepresence --namespace dev --swap-deployment venus:venus --run bash

telepresence --namespace dev --swap-deployment venus:venus --run-shell

telepresence --namespace dev --swap-deployment snow:snow --run-shell --also-proxy 10.102.1.26 --also-proxy 10.102.1.19 --also-proxy 10.102.1.20

telepresence --namespace dev --new-deployment testserver --run-shell --also-proxy 10.102.1.26 --also-proxy 10.102.1.19 --also-proxy 10.102.1.20
```




