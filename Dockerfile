# Stage 1: Build the React app
FROM node:14.17.0-alpine as build

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json to the container
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install --silent

# Copy the entire project directory to the container
COPY . .

# Build the React app
RUN npm run build

# Stage 2: Serve the React app with NGINX
FROM nginx:1.21.3-alpine

# Copy the built React app from the build stage to NGINX's public directory
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80 to the outside world
EXPOSE 80

# Start NGINX server when the container launches
CMD ["nginx", "-g", "daemon off;"]
