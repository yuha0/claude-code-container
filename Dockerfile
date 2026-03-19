FROM node:25-alpine

ARG CLAUDE_CODE_VERSION=2.1.79

RUN apk add --no-cache git su-exec bash && \
    npm install -g @anthropic-ai/claude-code@${CLAUDE_CODE_VERSION} && \
    npm cache clean --force

RUN mkdir /claude
ENV CLAUDE_CONFIG_DIR=/claude
ENV TERM=screen-256color

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR /workspace

ENTRYPOINT ["/entrypoint.sh"]
CMD ["claude"]
