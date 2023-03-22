# sonarqube docker-compose
Docker-compose file for sonarqube self managed server 

## Getting started
> Note: if you see max virtual memory areas vm.max_map_count [65530] is too low, increase to at least [262144], you need to increase the max_map_count


`docker-compose up`

if max_map_count is not enought increase it,
by editing `/etc/sysctl.conf` (might need sudo) and add a line `vm.max_map_count=278528` then run `sudo sysctl -p`

- access http://127.0.0.1:2000/
- login admin, admin
- new password

### Create Project

- Create project 'manually', input the fields
- Provide token for analyses, set expiration for the token
- copy the token

#### Scan project code
- pull sonarscanner image from docker
```bash
docker pull sonarsource/sonar-scanner-cli
```
- you can run it with 
```bash
  chmod +x scan.sh
  ./scan.sh <project_location> <project_key> <login_token>
```
- or you can use
```bash
  bash ./scan.sh <project_location> <project_key> <login_token>
```

- or use sonarscanner command directly from docker inside the directory of the source you want to analyse
```bash
 cd projectSourceCode
 docker run \
  --network=host \
  -e SONAR_HOST_URL='http://127.0.0.1:2000' \
  -it --rm \
  -v "$PWD":/usr/src \
  -v "$HOME/.sonar/cache:/root/.sonar/cache" \
  sonarsource/sonar-scanner-cli \
  sonar-scanner \
  -Dsonar.projectKey=${createdProjectKey} \
  -Dsonar.sources=. \
  -Dsonar.login=${token}
```
