# 🚀 Guide de Déploiement Dify avec Coolify

## 📋 Prérequis

- Coolify v4.0.0+ installé et configuré
- Domaine configuré (recommandé avec SSL)
- Accès au dépôt Git
- Minimum 4GB RAM et 2 CPU cores

## 🔧 Configuration dans Coolify

### Étape 1 : Créer une Nouvelle Application

1. Connectez-vous à votre interface Coolify
2. Cliquez sur **"New Resource"** → **"Application"**
3. Sélectionnez **"Git Repository"**
4. Choisissez votre fournisseur Git (GitHub, GitLab, etc.)

### Étape 2 : Configuration du Dépôt

1. **Repository URL** : `https://github.com/votre-username/dify-coolify`
2. **Branch** : `main` (ou votre branche principale)
3. **Build Pack** : Sélectionnez **"Docker Compose"**
4. **Docker Compose File** : `docker-compose.yaml`

### Étape 3 : Variables d'Environnement

#### Variables Obligatoires
```bash
RESEND_API_KEY=your-resend-api-key-here
MAIL_DEFAULT_SEND_FROM=your-email@yourdomain.com
SMTP_USERNAME=resend
SMTP_SERVER=smtp.resend.com
SMTP_PORT=465
```

#### Variables Optionnelles
```bash
LOG_LEVEL=INFO
VECTOR_STORE=qdrant
ETL_TYPE=dify
MIGRATION_ENABLED=true
```

### Étape 4 : Configuration du Domaine

1. Dans la section **"Domains"**
2. Ajoutez votre domaine (ex: `dify.votre-domaine.com`)
3. Activez **SSL** (recommandé)
4. Coolify générera automatiquement les certificats

### Étape 5 : Déploiement

1. Cliquez sur **"Deploy"**
2. Attendez la construction et le déploiement
3. Vérifiez les logs en cas d'erreur

## 🔍 Vérification du Déploiement

### Services à Vérifier
- ✅ **API** : `https://votre-domaine/api/health`
- ✅ **Web** : `https://votre-domaine`
- ✅ **Database** : Vérifiez les logs PostgreSQL
- ✅ **Redis** : Vérifiez les logs Redis
- ✅ **Qdrant** : Vérifiez les logs Qdrant

### Logs Importants
```bash
# Logs API
docker logs dify-api-1

# Logs Web
docker logs dify-web-1

# Logs Database
docker logs dify-db-1
```

## 🛠️ Dépannage

### Problèmes Courants

#### 1. Erreur de Connexion à la Base de Données
```bash
# Vérifiez que PostgreSQL est démarré
docker ps | grep postgres

# Vérifiez les logs
docker logs dify-db-1
```

#### 2. Erreur de Variables d'Environnement
```bash
# Vérifiez que toutes les variables sont définies
# Dans Coolify : Application → Environment Variables
```

#### 3. Problème de Stockage
```bash
# Vérifiez les permissions du répertoire
ls -la /data/dify/storage/

# Vérifiez les volumes Docker
docker volume ls
```

#### 4. Problème de Resend Email
```bash
# Vérifiez votre clé API Resend
# Testez avec curl :
curl -X POST https://api.resend.com/emails \
  -H "Authorization: Bearer YOUR_RESEND_API_KEY"
```

### Commandes Utiles

```bash
# Redémarrer un service
docker-compose restart api

# Voir les logs en temps réel
docker-compose logs -f api

# Accéder au conteneur
docker exec -it dify-api-1 bash

# Vérifier l'état des services
docker-compose ps
```

## 📊 Monitoring

### Métriques à Surveiller
- **CPU Usage** : < 80%
- **Memory Usage** : < 85%
- **Disk Usage** : < 90%
- **Response Time** : < 2s

### Alertes Recommandées
- Service down
- High CPU/Memory usage
- Database connection errors
- Email sending failures

## 🔄 Mise à Jour

### Processus de Mise à Jour
1. **Sauvegarde** de la base de données
2. **Pull** de la nouvelle version
3. **Redéploiement** via Coolify
4. **Vérification** des services

### Sauvegarde
```bash
# Sauvegarde PostgreSQL
docker exec dify-db-1 pg_dump -U postgres dify > backup.sql

# Sauvegarde des fichiers
tar -czf dify-files-backup.tar.gz /data/dify/storage/
```

## 🆘 Support

### Ressources
- [Documentation Dify](https://docs.dify.ai/)
- [Documentation Coolify](https://coolify.io/docs)
- [Forum Dify](https://github.com/langgenius/dify/discussions)

### Logs de Débogage
```bash
# Collecter tous les logs
docker-compose logs > dify-logs.txt

# Logs spécifiques
docker-compose logs api > api-logs.txt
docker-compose logs web > web-logs.txt
```

---

**Dernière mise à jour** : $(date)  
**Version Dify** : 1.9.1  
**Version Coolify** : v4.0.0+
