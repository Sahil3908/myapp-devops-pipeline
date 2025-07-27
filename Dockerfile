# Use official Node.js image
FROM node:18

# Create app directory
WORKDIR /app

# Copy dependencies and install
COPY src/package*.json ./
RUN npm install

# Copy the rest of the app
COPY src/ .

# Expose port 3000
EXPOSE 3000

# Start the app
CMD ["npm", "start"]
