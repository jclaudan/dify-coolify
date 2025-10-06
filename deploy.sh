#!/bin/bash

# Script de déploiement Dify avec Coolify
# Usage: ./deploy.sh

set -e

echo "🚀 Déploiement Dify avec Coolify"
echo "================================"

# Couleurs pour les messages
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Fonction pour afficher les messages
log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Vérification des prérequis
check_prerequisites() {
    log_info "Vérification des prérequis..."
    
    # Vérifier Docker
    if ! command -v docker &> /dev/null; then
        log_error "Docker n'est pas installé"
        exit 1
    fi
    
    # Vérifier Docker Compose
    if ! command -v docker-compose &> /dev/null; then
        log_error "Docker Compose n'est pas installé"
        exit 1
    fi
    
    log_info "✅ Prérequis vérifiés"
}

# Création des répertoires nécessaires
create_directories() {
    log_info "Création des répertoires..."
    
    mkdir -p volumes/{data,postgres,redis,qdrant,sandbox,plugin_daemon}
    mkdir -p nginx/ssl
    
    # Définir les permissions
    chmod -R 755 volumes/
    chmod -R 755 nginx/ssl/
    
    log_info "✅ Répertoires créés"
}

# Vérification des variables d'environnement
check_env_vars() {
    log_info "Vérification des variables d'environnement..."
    
    if [ -z "$RESEND_API_KEY" ]; then
        log_warn "RESEND_API_KEY n'est pas défini"
    fi
    
    if [ -z "$MAIL_DEFAULT_SEND_FROM" ]; then
        log_warn "MAIL_DEFAULT_SEND_FROM n'est pas défini"
    fi
    
    log_info "✅ Variables d'environnement vérifiées"
}

# Déploiement avec Docker Compose
deploy() {
    log_info "Déploiement en cours..."
    
    # Arrêter les services existants
    log_info "Arrêt des services existants..."
    docker-compose down --remove-orphans
    
    # Construire et démarrer les services
    log_info "Construction et démarrage des services..."
    docker-compose up -d --build
    
    log_info "✅ Déploiement terminé"
}

# Vérification de la santé des services
health_check() {
    log_info "Vérification de la santé des services..."
    
    # Attendre que les services démarrent
    sleep 30
    
    # Vérifier PostgreSQL
    if docker-compose exec -T db pg_isready -U postgres > /dev/null 2>&1; then
        log_info "✅ PostgreSQL est opérationnel"
    else
        log_error "❌ PostgreSQL n'est pas accessible"
    fi
    
    # Vérifier Redis
    if docker-compose exec -T redis redis-cli ping > /dev/null 2>&1; then
        log_info "✅ Redis est opérationnel"
    else
        log_error "❌ Redis n'est pas accessible"
    fi
    
    # Vérifier l'API
    if curl -f http://localhost:5001/health > /dev/null 2>&1; then
        log_info "✅ API Dify est opérationnelle"
    else
        log_warn "⚠️  API Dify n'est pas encore accessible (peut prendre quelques minutes)"
    fi
}

# Affichage des informations de connexion
show_connection_info() {
    log_info "Informations de connexion:"
    echo "🌐 Interface Web: http://localhost"
    echo "🔧 API: http://localhost:5001"
    echo "📊 Health Check: http://localhost:5001/health"
    echo ""
    echo "📋 Pour accéder aux logs:"
    echo "   docker-compose logs -f"
    echo ""
    echo "🛠️  Pour arrêter les services:"
    echo "   docker-compose down"
}

# Fonction principale
main() {
    check_prerequisites
    create_directories
    check_env_vars
    deploy
    health_check
    show_connection_info
    
    log_info "🎉 Déploiement Dify terminé avec succès!"
}

# Exécution du script
main "$@"
