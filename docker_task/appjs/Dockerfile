FROM node:18

WORKDIR /app
COPY ./simple-reactjs-app-master/package.json ./simple-reactjs-app-master/package-lock.json ./
RUN npm install
COPY ./simple-reactjs-app-master/ .

ENTRYPOINT [ "npm", "start"  ]
