# Use an official Node.js runtime as a parent image
FROM node:14

# Create a user and group to run the app
RUN groupadd -r appgroup && useradd -m -r -g appgroup appuser

# Set the working directory in the container
WORKDIR /app

# Change ownership of the working directory
RUN chown -R appuser:appgroup /app

# Switch to the new user
USER appuser

# Copy package.json and package-lock.json to the working directory
COPY --chown=appuser:appgroup package*.json ./

# Install dependencies
RUN npm install

# List contents of node_modules for debugging
RUN ls -la node_modules

# Copy the rest of the application code to the working directory
COPY --chown=appuser:appgroup . .

# Expose the port on which the app will run
EXPOSE 3000

# Start the app
CMD ["npm", "start"]
