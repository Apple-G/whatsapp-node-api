FROM node:12.22.0-buster

RUN apt-get update && \
  apt-get install -y \
  chromium \
  libatk-bridge2.0-0 \
  libxkbcommon0 \
  libwayland-client0 \
  libgtk-3-0 && \
  rm -rf /var/lib/apt/lists/*

COPY package.json .

RUN ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts

RUN npm install

COPY . .

EXPOSE 5000

CMD ["npm", "start"]
