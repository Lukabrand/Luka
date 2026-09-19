FROM node:22-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ffmpeg \
        ca-certificates \
        curl && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

ENV NODE_ENV=production

COPY package*.json ./

RUN rm -rf node_modules package-lock.json && \
    npm install --omit=dev --legacy-peer-deps --no-audit --no-fund --no-package-lock && \
    npm rebuild sharp --platform=linux --arch=x64 --libc=glibc && \
    npm cache clean --force

COPY . .

EXPOSE 5000

CMD ["npm", "start"]
