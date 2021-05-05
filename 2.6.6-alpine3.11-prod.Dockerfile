FROM ruby:2.6.6-alpine3.11

ENV BUILD_PACKAGES="curl-dev ruby-dev build-base bash git less" \
    DEV_PACKAGES="zlib-dev libxml2-dev libxslt-dev pcre-dev libffi-dev tzdata yaml-dev imagemagick" \
    DB_PACKAGES="postgresql-dev postgresql-client" \
    RUBY_PACKAGES="ruby-json yaml nodejs yarn ruby-nokogiri"

# Update and install base packages
RUN apk update && \
    apk upgrade && \
    apk add --update \
    $BUILD_PACKAGES \
    $DEV_PACKAGES \
    $DB_PACKAGES \
    $RUBY_PACKAGES && \
    rm -rf /var/cache/apk/*

# wkhtmltopdf with patched qt
# https://github.com/madnight/docker-alpine-wkhtmltopdf/blob/master/Dockerfile
RUN apk add --update --no-cache \
    libgcc libstdc++ libx11 glib libxrender libxext libintl \
    freetype ttf-dejavu ttf-droid ttf-freefont ttf-liberation ttf-ubuntu-font-family

COPY --from=madnight/alpine-wkhtmltopdf-builder:0.12.5-alpine3.10-729373503 \
    /bin/wkhtmltopdf /usr/bin/wkhtmltopdf

RUN addgroup -S deployer -g 1000 && adduser -S -g '' -u 1000 -G deployer deployer

ENV APP_PATH=/app \
    PUBLIC_PATH=/app/public \
    TEMP_PATH=/app/tmp \
    NODE_MODULES_PATH=/app/node_modules \
    GEM_HOME=/bundle \
    BUNDLE_PATH=/bundle \
    BUNDLE_BIN=/bundle/bin \
    BUNDLE_WITHOUT='development:test:staging' \
    BUNDLE_DEPLOYMENT='true' \
    BUNDLE_CLEAN='true'
ENV PATH $GEM_HOME/bin:$GEM_HOME/gems/bin:$PATH

# Manually create required volumes, https://github.com/docker/compose/issues/3270
RUN mkdir -p $APP_PATH \
  && mkdir -p $BUNDLE_PATH \
  && mkdir -p $TEMP_PATH \
  && mkdir -p $NODE_MODULES_PATH \
  && mkdir -p $PUBLIC_PATH

# Need to make a seperate stage for chown, otherwise it will be skipped
RUN chown -R deployer:deployer $BUNDLE_PATH \
  && chown -R deployer:deployer $TEMP_PATH \
  && chown -R deployer:deployer $NODE_MODULES_PATH \
  && chown -R deployer:deployer $PUBLIC_PATH

RUN gem install bundler --no-document
