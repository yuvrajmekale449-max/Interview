# Use Ubuntu as the base OS
FROM ubuntu:24.04

# Install Node.js, nginx, and required tools
RUN apt-get update \
    && apt-get install -y curl ca-certificates nginx \
    && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory inside the container
WORKDIR /app

# Copy package metadata separately for better layer caching
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application source code
COPY . ./

# Expose the application port
EXPOSE 3000

# Launch the app
CMD ["node", "server.js"]
