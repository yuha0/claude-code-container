FROM node:25-alpine

ARG CLAUDE_CODE_VERSION=2.1.108

RUN apk add --no-cache git su-exec bash && \
    npm install -g @anthropic-ai/claude-code@${CLAUDE_CODE_VERSION} && \
    npm cache clean --force

RUN mkdir /claude

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR /host

ENV TERM=screen-256color
ENV CLAUDE_CONFIG_DIR=/claude
ENV CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC=true

ENTRYPOINT ["/entrypoint.sh"]
