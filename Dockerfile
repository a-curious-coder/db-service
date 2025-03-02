FROM postgres:15-alpine

# Remove docs and cache
RUN rm -rf /usr/share/doc /usr/share/man /var/cache/apk/*
