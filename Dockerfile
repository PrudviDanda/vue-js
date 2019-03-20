FROM alpine:3.8

# install node.js and npm
RUN apk add --update nodejs nodejs-npm nginx &&\
    rm -rf /var/cache/apk/*

RUN mkdir -p /run/nginx
COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY nginx/default.conf /etc/nginx/conf.d/default.conf

COPY webapp /usr/share/nginx/html


# make the 'app' folder the current working directory
WORKDIR /usr/share/nginx/html/vue-app
# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
#COPY package*.json ./

RUN npm install -g @vue/cli &&\
    vue --version

EXPOSE 80
CMD ["nginx","-g", "daemon off;"]
