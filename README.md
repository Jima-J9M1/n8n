# n8n Docker Setup and Render Deployment

This project sets up n8n (workflow automation tool) using Docker with SQLite database and deploys it to Render.

## Prerequisites

- Docker and Docker Compose installed
- Git repository
- Render account

## Local Development Setup

### Step 1: Clone and Setup
```bash
git clone <your-repo-url>
cd n8n
```

### Step 2: Start n8n Locally
```bash
docker-compose up -d
```

### Step 3: Access n8n
- Open your browser and go to: `http://localhost:5679`
- Login with:
  - Username: `admin`
  - Password: `password123`

### Step 4: Stop Local Instance
```bash
docker-compose down
```

## Render Deployment

### Step 1: Push to Git Repository
```bash
git add .
git commit -m "Initial n8n setup"
git push origin main
```

### Step 2: Connect to Render
1. Go to [Render Dashboard](https://dashboard.render.com/)
2. Click "New +" and select "Web Service"
3. Connect your Git repository
4. Select the repository with n8n

### Step 3: Configure Service
- **Name**: `n8n` (or your preferred name)
- **Environment**: `Docker`
- **Region**: Choose closest to you
- **Branch**: `main`
- **Build Command**: `docker build -t n8n .`
- **Start Command**: `docker run -p $PORT:5678 n8n`

### Step 4: Environment Variables
Render will automatically set these from `render.yaml`:
- `N8N_BASIC_AUTH_ACTIVE`: `true`
- `N8N_BASIC_AUTH_USER`: `admin`
- `N8N_BASIC_AUTH_PASSWORD`: Auto-generated
- `N8N_DATABASE_TYPE`: `sqlite`
- `N8N_DATABASE_SQLITE_DATABASE`: `/home/node/.n8n/database.sqlite`
- `N8N_DATABASE_SQLITE_EXECUTABLE`: `/usr/bin/sqlite3`
- `N8N_HOST`: `0.0.0.0`
- `N8N_PORT`: `5678`
- `N8N_PROTOCOL`: `https`
- `NODE_ENV`: `production`
- `GENERIC_TIMEZONE`: `UTC`

### Step 5: Deploy
1. Click "Create Web Service"
2. Wait for the build to complete
3. Your n8n instance will be available at the provided URL

## Configuration

### Environment Variables
- `N8N_BASIC_AUTH_ACTIVE`: Enable basic authentication
- `N8N_BASIC_AUTH_USER`: Username for authentication
- `N8N_BASIC_AUTH_PASSWORD`: Password for authentication
- `N8N_DATABASE_TYPE`: Database type (sqlite)
- `N8N_DATABASE_SQLITE_DATABASE`: SQLite database file path
- `N8N_HOST`: Host binding
- `N8N_PORT`: Port number
- `N8N_PROTOCOL`: Protocol (http/https)

### Volumes
- `n8n_data`: Persistent Docker volume for n8n data
- `./data`: Local directory mapping for development

## Security Notes

- Change default admin password in production
- Use environment variables for sensitive data
- Consider using HTTPS in production
- Regularly update n8n image

## Troubleshooting

### Common Issues
1. **Port already in use**: Change port in docker-compose.yml
2. **Permission denied**: Check file permissions for data directory
3. **Database errors**: Ensure SQLite is properly installed in container

### Logs
```bash
# View n8n logs
docker-compose logs n8n

# Follow logs in real-time
docker-compose logs -f n8n
```

## Support

- [n8n Documentation](https://docs.n8n.io/)
- [Render Documentation](https://render.com/docs)
- [Docker Documentation](https://docs.docker.com/)
