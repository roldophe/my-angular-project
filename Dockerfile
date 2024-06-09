# Use the official Node.js image to build the application
FROM node:lts as build-stage

# Create and set the working directory
WORKDIR /app

# Copy the package.json and package-lock.json files
COPY package*.json ./

# Install dependencies with --force flag to mitigate potential issues
RUN npm install --force

# Copy the rest of the application code
COPY . .

# Build the AngularJS application
RUN npm run build

# Use the official Nginx image to serve the application
FROM nginx:alpine

# Copy the built application from the build stage
COPY --from=build-stage /app/dist/my-angular-project /usr/share/nginx/html

# Expose port 80 to the outside world
EXPOSE 80

# Command to run Nginx
CMD ["nginx", "-g", "daemon off;"]
