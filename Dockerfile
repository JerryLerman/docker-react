# The "as" tags this phase. Hence now known as the "builder" phase
# Sole purpose of this phase is to install dependencies and build the application
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# This creates everything in the working directory. Therefore the
# folder we care about is /app/build. So here we are creating the nginx folder
FROM nginx

# Want to copy something from a prior phase so using --from
# Note that anything in the /usr/share/nginx/html folder inside the
# nginx container will automatically be served up
COPY --from=builder /app/build /usr/share/nginx/html