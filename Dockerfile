FROM node:18-alpine AS base
WORKDIR /usr/src/app
COPY package*.json ./

FROM base AS build
RUN npm ci
COPY . .

FROM node:18-alpine AS production
WORKDIR /usr/src/app

COPY package*.json ./
RUN npm ci --only=production

COPY --from=build /usr/src/app . 

EXPOSE 3000
CMD ["npm", "start"]
