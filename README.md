# Miniapps Template NestJS

## Build images

 pre-requisites:
- Docker
- aws cli
- Login to account aws
  ```bash
    aws configure sso --profile <profile_name>
  ```
- Login Elastic Container Registry (AWS ECR)
    ```bash
    aws ecr get-login-password --region <region> --profile <profile_name> | docker login --username AWS --password-stdin <account_id>.dkr.ecr.<region>.amazonaws.com

    ```
### Build base image
```bash
make build-baseimage
```

### Build image
```bash
make build-image
```

### Build test image
```bash
make build-test-image
```


