FROM node:12.22.0-buster

RUN apt-get update && \
  apt-get install -y \
  chromium \
  chromium-browser \
  chromium-codecs-ffmpeg \
  libatk-bridge2.0-0 \
  libxkbcommon0 \
  libwayland-client0 \
  libgtk-3-0 && \
  rm -rf /var/lib/apt/lists/*

COPY package.json .

RUN mkdir /root/.ssh && chmod 0700 /root/.ssh \
    && ssh-keyscan -t rsa github.com >> /root/.ssh/known_hosts

RUN npm config set puppeteer_skip_chromium_download true -g \
    && npm install

COPY . .

EXPOSE 5000

CMD ["npm", "start"]
