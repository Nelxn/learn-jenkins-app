# Use the official Node.js 18 slim image as the base image
FROM node:18-slim

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install only production dependencies
RUN npm ci --only=production

# Copy the rest of the application code to the working directory
COPY . .

# Expose the port your application runs on (if applicable)
EXPOSE 3000

# Define the command to run your application
CMD ["npm", "start"]