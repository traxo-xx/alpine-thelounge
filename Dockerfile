# This is a modified Dockerfile which starts with a fresh Alpine image and installs node.js and The Lounge.
# The original can be found at https://github.com/thelounge/lounge/blob/master/Dockerfile

FROM alpine:latest
MAINTAINER Hannes Stöven <hstoeven@mailbox.org>

RUN apk --update --no-progress add nodejs git

# Create a non-root user for lounge to run in.
RUN adduser -S lounge

# Needed for setup of Node.js
ENV HOME /home/lounge

# Customize this to specify where The Lounge puts its data.
# To link a data container, have it expose /home/lounge/data
ENV LOUNGE_HOME /home/lounge/data

# Expose HTTP
EXPOSE 9000

# Make LOUNGE_HOME available as a volume.
VOLUME /home/lounge/data

RUN npm install -g thelounge

# Drop root.
USER lounge

# Don't use an entrypoint here. It makes debugging difficult.
CMD lounge --home $LOUNGE_HOME
