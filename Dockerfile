# FROM openfaas/classic-watchdog:0.13.4 as watchdog

FROM node:8.16-alpine

# RUN mkdir -p /home/app
COPY dist/ssr /home/app
COPY start.sh /home/app/start.sh
RUN yarn install

# COPY --from=watchdog /fwatchdog /usr/bin/fwatchdog
# RUN chmod +x /usr/bin/fwatchdog

# Add non root user
RUN addgroup -S app && adduser app -S -G app
RUN chown app /home/app

WORKDIR /home/app

USER app

# Populate example here - i.e. "cat", "sha512sum" or "node index.js"
# ENV fprocess="node index.js"
# Set to true to see request in function logs
# ENV write_debug="false"
ENV PORT="8080"

EXPOSE 8080

HEALTHCHECK --interval=5s CMD [ -e /tmp/.lock ] || exit 1

ENTRYPOINT [ "./start.sh"]
