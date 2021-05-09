FROM chamnapchhorn/rails_base:2.7.3-alpine3.13-prod

# Unset some ENVs for dev
ENV BUNDLE_WITHOUT='' \
    BUNDLE_DEPLOYMENT='' \
    BUNDLE_CLEAN=''

# Installs latest stable Chromium package.
# https://daniel-starling.com/blog/2018/03/10/capybara-in-alpine-linux/
# https://github.com/Zenika/alpine-chrome
# https://www.dennismclaughlin.tech/build-docker-image-ruby-watir-webdriver-shopify-and-chrome/
RUN apk update && apk upgrade \
    && apk add --no-cache \
    chromium-chromedriver \
    chromium \
    harfbuzz \
    nss \
    freetype \
    ttf-freefont \
    wait4ports \
    xorg-server \
    dbus \
    mesa-dri-swrast

# Clean up leftovers to help keep the final image small.
RUN rm -rf /var/lib/apt/lists/* \
    /var/cache/apk/* \
    /usr/share/man \
    /tmp/*

# Set the environment variables for the Chromium browser.
ENV CHROME_BIN=/usr/bin/chromium-browser \
    CHROME_PATH=/usr/lib/chromium/
