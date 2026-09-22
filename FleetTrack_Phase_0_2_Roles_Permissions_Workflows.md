### Stack technique retenue

| PartieTechnologie |                            |
| ----------------- | -------------------------- |
| Backend           | **Spring Boot / Java**     |
| Frontend          | **Angular**                |
| IDE Backend       | **IntelliJ IDEA**          |
| IDE Frontend      | **VS Code**                |
| Base de données   | **PostgreSQL**             |
| Environnement DB  | **Docker**                 |
| Versionnement     | **Git + GitHub**           |
| Architecture      | **REST API + Angular SPA** |

Pour la **Phase 0.2**, on ne code encore rien. On va définir précisément **qui peut faire quoi**, puis les workflows métier. C'est cette étape qui va déterminer ensuite nos entités, endpoints, permissions et écrans.

# Phase 0.2 — Rôles, permissions et workflows

## 1. Les rôles du système

Je propose **5 rôles** pour la première version.

```
```

```
ADMIN
CHEF_PARC
RESPONSABLE_VEHICULE
VERIFICATEUR
CONSULTATION
```

### Vue générale

| FonctionnalitéADMINCHEF PARCRESPONSABLEVÉRIFICATEURCONSULTATION |         |             |         |          |         |
| --------------------------------------------------------------- | ------- | ----------- | ------- | -------- | ------- |
| Dashboard                                                       | ✅       | ✅           | Limité  | ✅        | ✅       |
| Véhicules                                                       | CRUD    | CRUD        | Lecture | Lecture  | Lecture |
| Responsables                                                    | CRUD    | Gestion     | Lecture | Lecture  | Lecture |
| Dépenses                                                        | CRUD    | Créer/Gérer | Lecture | Vérifier | Lecture |
| Justificatifs                                                   | Lecture | Lecture     | Ajouter | Vérifier | Lecture |
| Vignettes                                                       | CRUD    | Gérer       | Lecture | Vérifier | Lecture |
| Validation                                                      | ❌\*     | ❌           | ❌       | ✅        | ❌       |
| Rapports                                                        | ✅       | ✅           | Limité  | ✅        | Lecture |
| Audit                                                           | ✅       | Lecture     | ❌       | Lecture  | ❌       |
| Utilisateurs                                                    | CRUD    | ❌           | ❌       | ❌        | ❌       |
| Paramètres                                                      | CRUD    | ❌           | ❌       | ❌        | ❌       |

`*` Pour garder une séparation des responsabilités, l'ADMIN ne devrait pas valider les dépenses dans le workflow métier normal.

---

# 2. Pourquoi séparer les rôles ?

Prenons ton exemple :

```
```

```
Chef de parc
      ↓
crée une dépense de 500 DH
      ↓
Responsable véhicule
      ↓
fournit le justificatif
      ↓
Vérificateur
      ↓
contrôle
      ↓
VALIDATION
```

Le même utilisateur ne devrait pas pouvoir :

```
```

```
Créer 500 DH
       ↓
Modifier à 700 DH
       ↓
Ajouter lui-même un justificatif
       ↓
Valider lui-même
```

La séparation des responsabilités est donc une partie importante de la traçabilité.

---

# 3. Rôle ADMIN

L'ADMIN est responsable de l'administration technique/fonctionnelle de l'application.

### Gestion utilisateurs

Il peut :

-  créer un utilisateur ; 
-  désactiver un utilisateur ; 
-  modifier son rôle ; 
-  réinitialiser certains paramètres du compte ; 
-  consulter les utilisateurs. 

Exemple :

```
```

```
Admin
 ↓
Créer utilisateur
 ↓
Nom : Ahmed
Username : ahmed
Role : RESPONSABLE_VEHICULE
 ↓
Affecter véhicule
```

### Gestion des rôles

L'ADMIN peut gérer les permissions générales du système.

Mais je te conseille de **ne pas permettre à un administrateur de créer des permissions arbitraires dans le MVP**.

On définit les rôles dans le code/configuration.

---

# 4. Rôle CHEF_PARC

C'est le rôle métier central pour la gestion du parc.

Il peut gérer :

### Véhicules

```
```

```
Créer
Modifier
Consulter
Affecter responsable
Consulter historique
```

### Dépenses

Il peut :

```
```

```
Créer dépense
Modifier une dépense encore modifiable
Consulter dépense
Ajouter certaines informations
Consulter justificatif
```

Mais :

> Il ne peut pas valider définitivement sa propre dépense.

---

# 5. Rôle RESPONSABLE_VEHICULE

Ce rôle représente la personne responsable d'un véhicule.

Il ne doit pas avoir accès à toutes les données du parc.

Par exemple :

```
```

```
Responsable A
       ↓
Véhicule J0244703
```

Il voit principalement :

```
```

```
Mes véhicules
Mes opérations
Mes justificatifs
Mes demandes de justification
```

### Il peut

-  consulter son véhicule ; 
-  consulter les dépenses qui lui sont affectées ; 
-  déposer un justificatif ; 
-  ajouter une observation ; 
-  répondre à une demande de correction ; 
-  consulter le statut. 

### Il ne peut pas

-  modifier le montant original d'une dépense ; 
-  supprimer une dépense ; 
-  valider une dépense ; 
-  modifier les dépenses d'un autre véhicule. 

---

# 6. Rôle VÉRIFICATEUR

C'est lui qui effectue le contrôle.

Il peut :

-  consulter les dépenses à vérifier ; 
-  consulter les justificatifs ; 
-  comparer les montants ; 
-  vérifier les informations ; 
-  demander une correction ; 
-  rejeter ; 
-  valider ; 
-  ajouter une observation. 

Exemple :

```
```

```
Dépense
500 DH

Justificatif
450 DH

Écart
50 DH
```

Le vérificateur peut faire :

```
```

```
→ Demander une explication
```

ou :

```
```

```
→ Valider
```

ou :

```
```

```
→ Rejeter
```

---

# 7. Rôle CONSULTATION

Ce rôle est volontairement limité.

Il peut consulter :

-  dashboard ; 
-  véhicules ; 
-  dépenses ; 
-  statistiques ; 
-  rapports. 

Mais :

```
```

```
Créer       ❌
Modifier    ❌
Supprimer   ❌
Valider     ❌
Justifier   ❌
```

Ce rôle pourrait être utile pour une personne qui doit seulement consulter les données.

---

# 8. Matrice détaillée des permissions

Maintenant on peut définir les permissions métier.

## Véhicules

| PermissionAdminChef parcResponsableVérificateurConsultation |   |   |        |   |   |
| ----------------------------------------------------------- | - | - | ------ | - | - |
| Voir véhicule                                               | ✅ | ✅ | ✅\*    | ✅ | ✅ |
| Créer                                                       | ✅ | ✅ | ❌      | ❌ | ❌ |
| Modifier                                                    | ✅ | ✅ | ❌      | ❌ | ❌ |
| Supprimer                                                   | ✅ | ❌ | ❌      | ❌ | ❌ |
| Affecter responsable                                        | ✅ | ✅ | ❌      | ❌ | ❌ |
| Historique                                                  | ✅ | ✅ | Limité | ✅ | ✅ |

`*` uniquement le véhicule qui lui est affecté.

---

# 9. Dépenses

| ActionAdminChef parcResponsableVérificateurConsultation |   |                |              |   |   |
| ------------------------------------------------------- | - | -------------- | ------------ | - | - |
| Voir                                                    | ✅ | ✅              | Ses dépenses | ✅ | ✅ |
| Créer                                                   | ❌ | ✅              | ❌            | ❌ | ❌ |
| Modifier                                                | ❌ | ✅\*            | ❌            | ❌ | ❌ |
| Supprimer                                               | ❌ | ❌              | ❌            | ❌ | ❌ |
| Ajouter justificatif                                    | ❌ | éventuellement | ✅            | ❌ | ❌ |
| Vérifier                                                | ❌ | ❌              | ❌            | ✅ | ❌ |
| Valider                                                 | ❌ | ❌              | ❌            | ✅ | ❌ |
| Rejeter                                                 | ❌ | ❌              | ❌            | ✅ | ❌ |

`*` seulement avant le passage en vérification.

---

# 10. Justificatifs

| ActionChef parcResponsableVérificateur |           |                    |   |
| -------------------------------------- | --------- | ------------------ | - |
| Consulter                              | ✅         | Ses documents      | ✅ |
| Ajouter                                | Optionnel | ✅                  | ❌ |
| Remplacer                              | ❌         | Avant vérification | ❌ |
| Supprimer                              | ❌         | Avant soumission   | ❌ |
| Vérifier                               | ❌         | ❌                  | ✅ |

---

# 11. Vignettes carburant

Pour les vignettes, je propose :

| ActionAdminChef parcResponsableVérificateur |   |           |               |   |
| ------------------------------------------- | - | --------- | ------------- | - |
| Créer                                       | ✅ | ✅         | ❌             | ❌ |
| Affecter véhicule                           | ✅ | ✅         | ❌             | ❌ |
| Consulter                                   | ✅ | ✅         | Ses vignettes | ✅ |
| Enregistrer utilisation                     | ❌ | ✅         | ✅             | ❌ |
| Ajouter justificatif                        | ❌ | Optionnel | ✅             | ❌ |
| Vérifier                                    | ❌ | ❌         | ❌             | ✅ |
| Valider                                     | ❌ | ❌         | ❌             | ✅ |

---

# 12. Le workflow principal

C'est maintenant la partie la plus importante.

## Workflow d'une dépense

```
```

```
                    ┌──────────────┐
                    │ Chef de parc │
                    └──────┬───────┘
                           │
                           ▼
                  Création dépense
                           │
                           ▼
                EN_ATTENTE_JUSTIFICATION
                           │
                           ▼
                Responsable véhicule
                           │
                    Ajoute justificatif
                           │
                           ▼
                      JUSTIFIÉE
                           │
                           ▼
                    Vérificateur
                           │
              ┌────────────┼─────────────┐
              │            │             │
              ▼            ▼             ▼
           VALIDÉE      REJETÉE    CORRECTION_DEMANDÉE
                                          │
                                          ▼
                                  Responsable corrige
                                          │
                                          ▼
                                     Vérification
```

---

# 13. Workflow détaillé

## Étape 1 — Création

Le chef de parc saisit :

```
```

```
Véhicule
Type de dépense
Date
Montant
Description
Kilométrage
```

Exemple :

```
```

```
Véhicule : J0244703
Type : CARBURANT
Montant : 500 DH
Date : 22/09/2026
Kilométrage : 120 500 km
```

Statut :

```
```

```
EN_ATTENTE_JUSTIFICATION
```

---

# 14. Étape 2 — Justification

Le responsable reçoit une demande.

Il ajoute :

```
```

```
Reçu
Facture
Photo
Observation
Montant réellement payé
```

Exemple :

```
```

```
Montant déclaré : 500 DH
Montant justificatif : 450 DH
```

Le système calcule :

```
```

```
Écart = 500 - 450
      = 50 DH
```

Statut :

```
```

```
JUSTIFIÉE
```

---

# 15. Étape 3 — Vérification

Le vérificateur ouvre la dépense.

Il voit quelque chose comme :

```
```

```
────────────────────────────────
DÉPENSE #152

Véhicule             J0244703
Type                 Carburant
Montant déclaré      500 DH
Montant justifié     450 DH
Écart                 50 DH

Justificatif
[ Reçu.pdf ]

Kilométrage
120 500 km
────────────────────────────────
```

Il peut :

### A — Valider

```
```

```
VALIDÉE
```

### B — Rejeter

```
```

```
REJETÉE
```

avec une raison obligatoire.

### C — Demander correction

```
```

```
CORRECTION_DEMANDÉE
```

avec commentaire.

---

# 16. Workflow d'une vignette carburant

Ici je te conseille un workflow légèrement différent.

```
```

```
Création vignette
       ↓
Affectation véhicule
       ↓
Utilisation
       ↓
Justification
       ↓
Calcul écart
       ↓
Vérification
       ↓
Validation
```

Exemple :

```
```

```
Vignette #V001

Valeur : 500 DH
Véhicule : J0244703

        ↓

Utilisation : 500 DH

        ↓

Justificatifs :

Reçu 1 : 200 DH
Reçu 2 : 250 DH

        ↓

Total justifié : 450 DH

        ↓

Écart : 50 DH

        ↓

À vérifier
```

---

# 17. Workflow maintenance

Pour une réparation :

```
```

```
Besoin d'intervention
        ↓
Création opération
        ↓
Devis
        ↓
Validation / autorisation
        ↓
Intervention
        ↓
Facture
        ↓
Justification
        ↓
Vérification
        ↓
Validation
```

Cela devient très intéressant pour les dépenses de réparation.

Par exemple :

```
```

```
Devis : 2 500 DH
Facture : 2 400 DH
```

Le système conserve les deux documents.

---

# 18. Workflow suppression

Je te recommande une règle importante :

### Ne pas supprimer physiquement une dépense validée.

Par exemple, quelqu'un ne doit pas pouvoir faire :

```
```

```
DELETE dépense #152
```

et faire disparaître l'historique.

À la place :

```
```

```
ACTIVE
   ↓
ANNULÉE
```

et l'audit conserve :

```
```

```
Qui
Quand
Pourquoi
Quelle dépense
```

C'est beaucoup plus adapté à ton objectif de traçabilité.

---

# 19. Workflow des modifications

Même principe.

Une dépense :

```
```

```
EN_ATTENTE_JUSTIFICATION
```

peut être modifiée.

Mais une dépense :

```
```

```
VALIDÉE
```

ne devrait plus être modifiable normalement.

Si une correction exceptionnelle est nécessaire :

```
```

```
VALIDÉE
   ↓
DEMANDE DE MODIFICATION
   ↓
Autorisation
   ↓
Modification
   ↓
Nouvelle trace d'audit
```

---

# 20. États globaux

On peut donc définir les principaux statuts :

```
```

```
DRAFT
EN_ATTENTE_JUSTIFICATION
JUSTIFIÉE
EN_VÉRIFICATION
CORRECTION_DEMANDÉE
VALIDÉE
REJETÉE
ANNULÉE
```

Et pour les vignettes :

```
```

```
CRÉÉE
AFFECTÉE
EN_UTILISATION
PARTIELLEMENT_JUSTIFIÉE
JUSTIFIÉE
EN_VÉRIFICATION
VALIDÉE
ÉCART_À_VÉRIFIER
CLÔTURÉE
```

---

# 21. Ce que cela implique pour Spring Boot

Cette Phase 0.2 nous donne déjà une première idée de notre backend.

On aura probablement des domaines comme :

```
```

```
user
vehicle
assignment
expense
fuel-voucher
justification
maintenance
audit
notification
report
```

Et côté Spring Boot :

```
```

```
Controller
    ↓
Service
    ↓
Repository
    ↓
PostgreSQL
```

Par exemple :

```
```

```
ExpenseController
       ↓
ExpenseService
       ↓
ExpenseRepository
       ↓
PostgreSQL
```

---

# 22. Sécurité Spring Boot

Pour l'authentification/autorisation, le projet pourra utiliser :

```
```

```
Spring Boot
    +
Spring Security
    +
JWT
    +
Role-Based Access Control
```

Par exemple :

```
```

```
ROLE_ADMIN
ROLE_CHEF_PARC
ROLE_RESPONSABLE
ROLE_VERIFICATEUR
ROLE_CONSULTATION
```

Angular sera ensuite responsable de l'interface et pourra masquer certaines fonctionnalités selon les permissions, **mais la vraie sécurité doit être appliquée côté Spring Boot**.

---

# 23. PostgreSQL + Docker

Pour le développement local :

```
```

```
Angular
   │
   │ HTTP/REST
   ▼
Spring Boot
   │
   │ JDBC/JPA
   ▼
PostgreSQL
   │
   └── Docker
```

Donc ton environnement sera :

```
```

```
Windows
│
├── IntelliJ IDEA
│    └── Spring Boot
│
├── VS Code
│    └── Angular
│
├── Docker
│    └── PostgreSQL
│
└── Git
     └── GitHub
```

---

# 24. Notre règle métier centrale

Je pense qu'il faut formaliser **une règle fondamentale** pour tout le projet :

> **Toute dépense doit être traçable de sa création jusqu'à sa validation finale.**

Donc :

```
```

```
Véhicule
   ↓
Dépense
   ↓
Montant
   ↓
Responsable
   ↓
Justificatif
   ↓
Vérification
   ↓
Validation
   ↓
Audit
```

Et aucune étape importante ne doit pouvoir être effacée de l'historique.