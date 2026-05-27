FROM ubuntu:22.04

RUN apt update && \
    apt install -y curl build-essential nodejs npm

RUN curl --proto '=https' --tlsv1.2 -fsSL https://drop-sh.fullyjustified.net | sh

ENV PATH="/root/.cargo/bin:${PATH}"

WORKDIR /app

COPY package.json .
RUN npm install

COPY . .

EXPOSE 3000

CMD ["npm", "start"]