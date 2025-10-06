# 🔒 Guide de Sécurité - Dify Coolify

## ⚠️ Informations Sensibles

**NE JAMAIS** commiter les informations suivantes :

### 🚨 Données Sensibles à Protéger :
- ❌ Clés API (Resend, OpenAI, etc.)
- ❌ Mots de passe
- ❌ Certificats SSL
- ❌ Tokens d'authentification
- ❌ Emails personnels/professionnels
- ❌ URLs de base de données avec credentials

### ✅ Bonnes Pratiques :

#### 1. Variables d'Environnement
```bash
# ❌ MAUVAIS - Ne pas commiter
RESEND_API_KEY=re_HXzacNgU_FHDC9JAiKPoe2cmyRHrjFUha

# ✅ BON - Utiliser des placeholders
RESEND_API_KEY=your-resend-api-key-here
```

#### 2. Fichiers .env
```bash
# Ajouter à .gitignore
.env
.env.local
.env.production
```

#### 3. Documentation
- Utiliser des exemples génériques
- Ne jamais exposer de vraies clés
- Utiliser des placeholders clairs

## 🛡️ Sécurité Coolify

### Variables Magiques Coolify
Coolify génère automatiquement des mots de passe sécurisés :
- `SERVICE_PASSWORD_*` - Mots de passe aléatoires
- `SERVICE_URL_*` - URLs générées automatiquement

### Configuration Recommandée
```yaml
# ✅ Sécurisé - Coolify génère automatiquement
SECRET_KEY: ${SERVICE_PASSWORD_SECRET}
DB_PASSWORD: ${SERVICE_PASSWORD_DB}
REDIS_PASSWORD: ${SERVICE_PASSWORD_REDIS}
```

## 🔍 Vérification Avant Publication

Avant de rendre un dépôt public, vérifiez :

1. **Rechercher des clés API** :
   ```bash
   grep -r "sk-" .
   grep -r "re_" .
   grep -r "pk_" .
   ```

2. **Vérifier les fichiers sensibles** :
   ```bash
   find . -name "*.env*" -o -name "*.key" -o -name "*.pem"
   ```

3. **Contrôler .gitignore** :
   ```bash
   cat .gitignore | grep -E "(env|key|secret|password)"
   ```

## 📋 Checklist de Sécurité

- [ ] Aucune clé API exposée
- [ ] Aucun mot de passe en dur
- [ ] Aucun email personnel exposé
- [ ] Fichiers .env dans .gitignore
- [ ] Certificats SSL exclus
- [ ] Documentation avec exemples génériques
- [ ] Variables d'environnement documentées

## 🆘 En Cas d'Exposition

Si vous avez accidentellement exposé des informations sensibles :

1. **Révoquer immédiatement** les clés exposées
2. **Supprimer** l'historique Git si nécessaire
3. **Régénérer** les clés
4. **Mettre à jour** la documentation

## 📚 Ressources

- [GitHub Security Best Practices](https://docs.github.com/en/code-security)
- [Docker Security](https://docs.docker.com/engine/security/)
- [Coolify Security](https://coolify.io/docs/security)

---

**Rappel** : La sécurité est une responsabilité partagée. Vérifiez toujours avant de publier ! 🔒
