# Dify Coolify - Plateforme IA avec Coolify

Ce dépôt contient la configuration Docker Compose optimisée pour déployer Dify (plateforme de développement d'applications IA) via Coolify.

## 🚀 Déploiement Rapide

### Prérequis
- Coolify installé et configuré
- Domaine configuré avec SSL (recommandé)

### Configuration dans Coolify

1. **Ajouter une nouvelle application**
2. **Sélectionner "Docker Compose"**
3. **Coller l'URL de ce dépôt Git**
4. **Configurer les variables d'environnement** (voir section Variables)

## ⚙️ Variables d'Environnement

### Variables Obligatoires
```bash
# Configuration Resend (Email)
RESEND_API_KEY=your-resend-api-key-here
MAIL_DEFAULT_SEND_FROM=your-email@yourdomain.com
SMTP_USERNAME=resend
SMTP_SERVER=smtp.resend.com
SMTP_PORT=465

# Variables système
LOG_LEVEL=INFO
VECTOR_STORE=qdrant
ETL_TYPE=dify
```

### Variables Générées Automatiquement par Coolify
- `SERVICE_URL_API` - URL de l'API
- `SERVICE_URL_WEB` - URL du frontend
- `SERVICE_PASSWORD_SECRET` - Clé secrète
- `SERVICE_PASSWORD_DB` - Mot de passe PostgreSQL
- `SERVICE_PASSWORD_REDIS` - Mot de passe Redis
- `SERVICE_PASSWORD_QDRANT` - Clé API Qdrant
- `SERVICE_PASSWORD_SANDBOX` - Clé Sandbox
- `SERVICE_PASSWORD_PLUGIN` - Clé Plugin Daemon
- `SERVICE_PASSWORD_SMTP` - Mot de passe SMTP

## 🏗️ Architecture

- **API** : `langgenius/dify-api:1.9.1`
- **Frontend** : `langgenius/dify-web:1.9.1`
- **Base de données** : PostgreSQL 15
- **Cache** : Redis 6
- **Vector Store** : Qdrant
- **Proxy** : Nginx
- **Sandbox** : Dify Sandbox
- **Plugin Daemon** : Dify Plugin Daemon

## 📊 Services Inclus

- ✅ API Backend (Dify API)
- ✅ Frontend Web (Dify Web)
- ✅ Worker (Celery)
- ✅ Worker Beat (Scheduler)
- ✅ PostgreSQL Database
- ✅ Redis Cache
- ✅ Qdrant Vector Store
- ✅ Nginx Reverse Proxy
- ✅ Sandbox (Code Execution)
- ✅ Plugin Daemon
- ✅ SSRF Proxy

## 🔧 Configuration Avancée

### Stockage
- **Type** : OpenDAL avec File System local
- **Emplacement** : `/data/dify/storage/`

### Sécurité
- Mots de passe générés automatiquement par Coolify
- SSRF Protection activée
- Network isolation pour le sandbox

### Performance
- Connection pooling PostgreSQL
- Redis pour la cache et les queues
- Nginx pour le load balancing

## 🆘 Support

Pour toute question ou problème :
1. Vérifiez les logs dans Coolify
2. Consultez la documentation Dify officielle
3. Vérifiez la configuration des variables d'environnement

## 📚 Ressources

- [Documentation Dify](https://docs.dify.ai/)
- [Documentation Coolify](https://coolify.io/docs)
- [Apache OpenDAL](https://opendal.apache.org/)

---

**Version** : Dify 1.9.1  
**Dernière mise à jour** : $(date)  
**Compatible avec** : Coolify v4.0.0+