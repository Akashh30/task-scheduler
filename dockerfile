# FROM node:21-alpine

# WORKDIR /usr/src/app

# COPY package*.json ./

# RUN npm install

# COPY . . 

# EXPOSE 3000

# CMD ["npm", "start"]

# Stage 1: Build the application
FROM node:21-alpine AS build
WORKDIR /usr/src/app

# Install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the application code
COPY . .

# If there's a build step, uncomment the following line
# RUN npm run build

# Stage 2: Create the production image
FROM node:21-alpine
WORKDIR /usr/src/app

# Copy only the necessary files from the build stage
COPY --from=build /usr/src/app /usr/src/app

# Expose the port the app runs on
EXPOSE 3000

# Define the command to run the application
CMD ["npm", "start"]
