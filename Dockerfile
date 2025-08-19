# -------- Base Stage --------
FROM node:18-alpine AS base
WORKDIR /usr/src/app
COPY package*.json ./

# -------- Build Stage --------
FROM base AS build
# Install all dependencies (including dev)
RUN npm ci
COPY . .
# If you have a build step (e.g., Next.js, TypeScript, etc.), add it here
# RUN npm run build

# -------- Production Stage --------
FROM node:18-alpine AS production
WORKDIR /usr/src/app

# Copy only package files first (for caching layers)
COPY package*.json ./
# Install only production dependencies
RUN npm ci --only=production

# Copy built code and other necessary files from build stage
COPY --from=build /usr/src/app . 

EXPOSE 3000
CMD ["npm", "start"]
