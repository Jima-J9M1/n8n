FROM n8nio/n8n:latest

# Install SQLite3
RUN apk add --no-cache sqlite

# Create n8n directory
RUN mkdir -p /home/node/.n8n

# Set proper permissions
RUN chown -R node:node /home/node/.n8n

# Switch to node user
USER node

# Expose port
EXPOSE 5678

# Start n8n
CMD ["n8n"]
