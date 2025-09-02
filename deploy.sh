#!/bin/bash

echo "🚀 n8n Deployment Script"
echo "========================"

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker is not running. Please start Docker first."
    exit 1
fi

# Check if Docker Compose is available
if ! command -v docker-compose &> /dev/null; then
    echo "❌ Docker Compose is not installed. Please install it first."
    exit 1
fi

echo "✅ Docker and Docker Compose are available"

# Function to start n8n locally
start_local() {
    echo "🔧 Starting n8n locally..."
    docker-compose up -d
    echo "✅ n8n is starting up..."
    echo "🌐 Access n8n at: http://localhost:5679"
    echo "👤 Username: admin"
    echo "🔑 Password: password123"
}

# Function to stop n8n locally
stop_local() {
    echo "🛑 Stopping n8n locally..."
    docker-compose down
    echo "✅ n8n has been stopped"
}

# Function to view logs
view_logs() {
    echo "📋 Viewing n8n logs..."
    docker-compose logs -f n8n
}

# Function to show status
show_status() {
    echo "📊 n8n container status:"
    docker-compose ps
}

# Function to show deployment instructions
show_deploy_instructions() {
    echo ""
    echo "🌍 Render Deployment Instructions:"
    echo "=================================="
    echo "1. Push your code to Git:"
    echo "   git add ."
    echo "   git commit -m 'Initial n8n setup'"
    echo "   git push origin main"
    echo ""
    echo "2. Go to Render Dashboard: https://dashboard.render.com/"
    echo "3. Click 'New +' → 'Web Service'"
    echo "4. Connect your Git repository"
    echo "5. Configure:"
    echo "   - Name: n8n"
    echo "   - Environment: Docker"
    echo "   - Build Command: docker build -t n8n ."
    echo "   - Start Command: docker run -p \$PORT:5678 n8n"
    echo "6. Click 'Create Web Service'"
    echo ""
    echo "📚 See README.md for detailed instructions"
}

# Main menu
case "${1:-}" in
    "start")
        start_local
        ;;
    "stop")
        stop_local
        ;;
    "logs")
        view_logs
        ;;
    "status")
        show_status
        ;;
    "deploy")
        show_deploy_instructions
        ;;
    *)
        echo "Usage: $0 {start|stop|logs|status|deploy}"
        echo ""
        echo "Commands:"
        echo "  start   - Start n8n locally"
        echo "  stop    - Stop n8n locally"
        echo "  logs    - View n8n logs"
        echo "  status  - Show container status"
        echo "  deploy  - Show deployment instructions"
        echo ""
        echo "Example: $0 start"
        ;;
esac
