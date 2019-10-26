FROM node

RUN mkdir /app
WORKDIR /app
COPY docker-resources/package.json /app/package.json
RUN npm install
COPY docker-resources/index.js /app/index.js

ENTRYPOINT [ "node" , "index.js" ]
