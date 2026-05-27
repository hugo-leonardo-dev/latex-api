FROM node:20-bookworm

RUN apt-get update && \
    apt-get install -y \
    wget \
    xz-utils \
    perl \
    fontconfig \
    ca-certificates

RUN wget https://github.com/tectonic-typesetting/tectonic/releases/download/tectonic%400.15.0/tectonic-0.15.0-x86_64-unknown-linux-gnu.tar.gz && \
    tar -xzf tectonic-0.15.0-x86_64-unknown-linux-gnu.tar.gz && \
    mv tectonic /usr/local/bin/tectonic && \
    chmod +x /usr/local/bin/tectonic

WORKDIR /app

COPY package.json .

RUN npm install

COPY . .

EXPOSE 3000

CMD ["npm", "start"]