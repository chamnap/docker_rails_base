# Supported tags and respective `Dockerfile` links

- `2.6.6-alpine3.11-dev` [(Dockerfile)](https://github.com/chamnap/docker_rails_base/blob/master/2.6.6-alpine3.11-dev.Dockerfile)
- `2.6.6-alpine3.11-prod` [(Dockerfile)](https://github.com/chamnap/docker_rails_base/blob/master/2.6.6-alpine3.11-prod.Dockerfile)

# Build

    $ docker build -t rails_base -f 2.6.6-alpine3.11-dev.Dockerfile --no-cache .
    $ docker tag rails_base chamnapchhorn/rails_base:2.6.6-alpine3.11-dev
    $ docker push chamnapchhorn/rails_base:2.6.6-alpine3.11-dev
