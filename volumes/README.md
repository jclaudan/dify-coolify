# 📁 Volumes Docker pour Dify

Ce répertoire contient les volumes Docker pour la persistance des données.

## 📂 Structure des Volumes

```
volumes/
├── data/                    # Données générales
├── postgres/               # Base de données PostgreSQL
├── redis/                  # Cache Redis
├── qdrant/                 # Vector store Qdrant
├── sandbox/                # Sandbox pour l'exécution de code
├── plugin_daemon/          # Plugin daemon storage
└── nginx/                  # Configuration Nginx
```

## 🔧 Configuration

Les volumes sont automatiquement créés par Docker Compose lors du premier démarrage.

### Permissions
Assurez-vous que les permissions sont correctes :
```bash
sudo chown -R 1000:1000 volumes/
sudo chmod -R 755 volumes/
```

### Sauvegarde
```bash
# Sauvegarde complète
tar -czf dify-volumes-backup.tar.gz volumes/

# Sauvegarde spécifique
tar -czf postgres-backup.tar.gz volumes/postgres/
```

## ⚠️ Important

- **Ne jamais** supprimer ces volumes en production
- **Toujours** faire une sauvegarde avant toute modification
- **Vérifier** les permissions après mise à jour
