# Docker file to run Hashicorp Vault (vaultproject.io)
FROM alpine
MAINTAINER drunner

# we use non-root user in the container for security.
# dr expects uid 22022 and gid 22022.
   # - debian
   #RUN groupadd -g 22022 drgroup
   #RUN adduser --disabled-password --gecos '' -u 22022 --gid 22022 druser
# - alpine
RUN apk add --update bash && rm -rf /var/cache/apk/*
RUN addgroup -S -g 12345 drgroup
RUN adduser -S -u 12345 -G drgroup -g '' druser

# add in the assets.
ADD ["./drunner","/drunner"]
RUN chmod chmod a-w -R /drunner

# lock in druser.
USER druser

# expose volume
VOLUME /config