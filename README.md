### Build

    $ docker build -t rails_base --no-cache .
    $ docker tag rails_base chamnapchhorn/rails_base:2.6.6-alpine3.11-prod
    $ docker push chamnapchhorn/rails_base:2.6.6-alpine3.11-prod
