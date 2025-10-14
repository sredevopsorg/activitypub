FROM node:jod-bookworm@sha256:6fe286835c595e53cdafc4889e9eff903dd3008a3050c1675809148d8e0df805 AS build-env

# RUN apk add python3 g++ make
# RUN apk add --no-cache ca-certificates

RUN apt update && apt install -y python3 g++ make
RUN apt install -y ca-certificates

WORKDIR /opt/activitypub

COPY package.json .
COPY yarn.lock .

RUN yarn && \
    yarn cache clean

COPY tsconfig.json .

COPY src ./src
COPY vitest.config.ts vitest.config.ts

ENV NODE_ENV=production
RUN yarn build

# RUN apk del python3 g++ make

FROM gcr.io/distroless/nodejs22-debian12:latest@sha256:4c6848a24760c190338d20c3fd2e987431f8fe05c4067a114801cb66ca0018a1 AS runtime 

WORKDIR /opt/activitypub

COPY --from=build-env /opt/activitypub .

ENV NODE_ENV=production

EXPOSE 8080

CMD ["dist/app.js"]
