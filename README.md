# Supported tags and respective `Dockerfile` links

- `2.6.6-alpine3.11-dev` [(Dockerfile)](https://github.com/chamnap/docker_rails_base/blob/master/2.6.6-alpine3.11-dev.Dockerfile)
- `2.6.6-alpine3.11-prod` [(Dockerfile)](https://github.com/chamnap/docker_rails_base/blob/master/2.6.6-alpine3.11-prod.Dockerfile)
- `2.7.3-alpine3.13-dev` [(Dockerfile)](https://github.com/chamnap/docker_rails_base/blob/master/2.7.3-alpine3.13-dev.Dockerfile)
- `2.7.3-alpine3.13-prod` [(Dockerfile)](https://github.com/chamnap/docker_rails_base/blob/master/2.7.3-alpine3.13-prod.Dockerfile)

# Build

    $ docker build -t rails_base -f 2.7.3-alpine3.13-dev.Dockerfile --no-cache .
    $ docker tag rails_base chamnapchhorn/rails_base:2.7.3-alpine3.13-dev
    $ docker push chamnapchhorn/rails_base:2.7.3-alpine3.13-dev

# Usage

    FROM chamnapchhorn/rails_base:2.7.3-alpine3.13-dev

    WORKDIR $APP_PATH

    ADD --chown=deployer:deployer . $APP_PATH

    USER deployer:deployer
