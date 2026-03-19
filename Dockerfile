FROM node:25-alpine

ARG CLAUDE_CODE_VERSION=2.1.78

RUN npm install -g @anthropic-ai/claude-code@${CLAUDE_CODE_VERSION} && \
    npm cache clean --force

RUN mkdir /claude
ENV CLAUDE_CONFIG_DIR=/claude
ENV TERM=screen-256color

WORKDIR /workspace

ENTRYPOINT ["claude"]
