# Phase 0 — Cahier des charges

## 1. Présentation du projet

### 1.1 Nom provisoire

**Système de gestion et de traçabilité des dépenses du parc automobile communal**

Nom court possible pour l'application :

> **FleetTrack Commune**

---

## 2. Contexte

La commune dispose d'un parc de véhicules utilisés pour différentes missions administratives et opérationnelles.

Ces véhicules génèrent plusieurs types de dépenses :

- carburant ;
- vidange ;
- lavage ;
- entretien ;
- réparation ;
- pièces de rechange ;
- pneus ;
- batterie ;
- autres dépenses liées au véhicule.

Actuellement, les informations concernant ces dépenses ne sont pas centralisées dans un système permettant d'obtenir facilement une vision globale et historique de chaque véhicule.

Il est donc difficile de répondre rapidement à des questions comme :

> Combien ce véhicule a-t-il coûté à la commune ce mois-ci ?

> Combien a-t-il consommé en carburant ce trimestre ?

> Combien avons-nous dépensé en entretien cette année ?

> Quel véhicule génère le plus de dépenses ?

> Quelle vignette carburant a été utilisée et quel montant a réellement été consommé ?

> Les dépenses déclarées sont-elles accompagnées de justificatifs ?

Le projet consiste donc à développer une application permettant de **centraliser, suivre, justifier, contrôler et analyser les dépenses liées aux véhicules communaux**.

---

# 3. Problématique

Le système actuel présente principalement les problèmes suivants :

### 3.1 Absence de données centralisées

Les informations concernant les véhicules et leurs dépenses peuvent être dispersées entre :

- documents papier ;
- factures ;
- reçus ;
- fichiers Excel ;
- informations détenues par différents responsables.

Il est donc difficile d'obtenir un historique fiable par véhicule.

### 3.2 Difficulté de suivi des dépenses

Il n'existe pas nécessairement de vue permettant de connaître automatiquement :

- les dépenses mensuelles ;
- les dépenses trimestrielles ;
- les dépenses annuelles ;
- le coût total d'un véhicule ;
- la répartition des dépenses par catégorie.

### 3.3 Traçabilité insuffisante

Pour chaque dépense, il est nécessaire de pouvoir répondre à :

**Qui ?**

→ Qui a créé la dépense ?

**Quand ?**

→ Quand la dépense a-t-elle été enregistrée ?

**Pour quel véhicule ?**

→ Quel véhicule est concerné ?

**Pourquoi ?**

→ Quelle est la raison de la dépense ?

**Combien ?**

→ Quel montant a été déclaré ?

**Quelle preuve ?**

→ Existe-t-il un justificatif ?

**Qui a vérifié ?**

→ Qui a contrôlé la dépense ?

---

# 4. Exemple du problème des vignettes carburant

Un cas important concerne les **vignettes carburant**.

Exemple :

Une vignette d'une valeur de :

> **500 DH**

est attribuée pour le carburant d'un véhicule.

Le système doit permettre de suivre :

```
Vignette
   ↓
500 DH attribués
   ↓
Utilisation
   ↓
Justificatif
   ↓
Montant réellement consommé
   ↓
Vérification
   ↓
Validation / Rejet

```

Par exemple :

```
Montant attribué : 500 DH
Montant justifié : 200 DH
Écart : 300 DH

```

Le système doit **signaler l'écart pour vérification**.

Important : l'application ne doit pas automatiquement considérer cet écart comme une fraude. Elle doit plutôt indiquer :

> **Écart nécessitant une vérification**

afin qu'un responsable puisse examiner les justificatifs et expliquer la différence.

---

# 5. Objectifs du projet

## Objectif principal

Développer une application permettant la **gestion centralisée et la traçabilité des dépenses du parc automobile communal**.

## Objectifs spécifiques

Le système devra permettre de :

1. gérer les véhicules ;
2. gérer les responsables/chauffeurs ;
3. enregistrer les dépenses ;
4. gérer les vignettes carburant ;
5. associer chaque dépense à un véhicule ;
6. associer les justificatifs aux dépenses ;
7. vérifier les dépenses ;
8. suivre les validations et rejets ;
9. conserver l'historique des opérations ;
10. calculer automatiquement les dépenses mensuelles ;
11. calculer les dépenses trimestrielles ;
12. calculer les dépenses annuelles ;
13. produire des statistiques ;
14. générer des rapports ;
15. détecter certains écarts nécessitant une vérification.

---

# 6. Périmètre du système

L'application sera organisée autour de plusieurs modules.

```
                    APPLICATION
                         │
       ┌─────────────────┼─────────────────┐
       │                 │                 │
    Véhicules          Dépenses         Carburant
       │                 │                 │
       │                 │                 │
  Responsables      Justificatifs       Vignettes
       │                 │                 │
       └─────────────────┼─────────────────┘
                         │
                    Vérification
                         │
                    Validation
                         │
                     Dashboard
                         │
                  Rapports / Audit

```

---

# 7. Acteurs du système

## 7.1 Administrateur

Responsable de la configuration générale de l'application.

### Permissions

- gérer les utilisateurs ;
- gérer les rôles ;
- gérer les permissions ;
- gérer les paramètres ;
- consulter les données ;
- consulter les journaux d'activité.

---

## 7.2 Chef de parc

C'est l'acteur principal concernant la gestion du parc.

### Il peut :

- ajouter un véhicule ;
- modifier les informations d'un véhicule ;
- affecter un responsable ;
- enregistrer une dépense ;
- enregistrer une vignette ;
- consulter l'historique ;
- consulter les justificatifs ;
- demander une vérification ;
- consulter les statistiques du parc.

---

## 7.3 Responsable / chauffeur du véhicule

Il est responsable de fournir les informations et justificatifs concernant l'utilisation du véhicule.

### Il peut :

- consulter son véhicule ;
- consulter les opérations qui lui sont affectées ;
- déposer un justificatif ;
- renseigner les informations demandées ;
- ajouter une observation ;
- consulter l'état de validation.

Exemple :

```
Dépense créée
      ↓
Responsable reçoit une notification
      ↓
Il ajoute le reçu
      ↓
Il indique les informations nécessaires
      ↓
Soumission

```

---

## 7.4 Vérificateur / responsable de validation

Ce rôle vérifie les dépenses.

Il peut :

- consulter la dépense ;
- consulter le justificatif ;
- comparer les montants ;
- accepter ;
- rejeter ;
- demander une correction ;
- ajouter une observation.

---

## 7.5 Direction / Comptabilité

La direction ou le service concerné peut disposer d'une vue globale.

Elle peut consulter :

- dépenses totales ;
- dépenses par véhicule ;
- dépenses par catégorie ;
- dépenses mensuelles ;
- dépenses trimestrielles ;
- dépenses annuelles ;
- dépenses en attente ;
- dépenses rejetées ;
- écarts de carburant.

---

# 8. Module Véhicules

Chaque véhicule possède une fiche.

### Informations principales

```
Véhicule
├── Immatriculation
├── Marque
├── Modèle
├── Type
├── Année
├── Date de mise en service
├── Kilométrage actuel
├── État
├── Responsable
└── Informations supplémentaires

```

Exemple :

```
Immatriculation : J0244703
Marque          : Dacia
Modèle          : ...
Type            : Véhicule de service
Kilométrage     : 125 420 km
Responsable     : ...
État            : En service

```

---

# 9. Module Dépenses

Chaque dépense doit être enregistrée dans le système.

### Types de dépenses

```
CARBURANT
VIDANGE
LAVAGE
ENTRETIEN
RÉPARATION
PIÈCES_DE_RECHANGE
PNEUS
BATTERIE
AUTRE

```

Une dépense contient notamment :

```
Dépense
├── ID
├── Véhicule
├── Type
├── Date
├── Montant
├── Description
├── Responsable
├── Justificatif
├── Statut
├── Vérificateur
└── Historique

```

---

# 10. Statut d'une dépense

Je te conseille de ne pas simplement avoir `validé / non validé`.

Utilise un véritable workflow :

```
BROUILLON
    ↓
EN_ATTENTE_JUSTIFICATION
    ↓
JUSTIFIÉE
    ↓
EN_VÉRIFICATION
    ↓
VALIDÉE

```

Et en cas de problème :

```
EN_VÉRIFICATION
       │
       ├──→ REJETÉE
       │
       └──→ CORRECTION_DEMANDÉE
                    ↓
                 JUSTIFIÉE

```

Cela donnera beaucoup plus de traçabilité à ton application.

---

# 11. Module Justificatifs

Chaque dépense peut avoir un ou plusieurs documents.

Exemples :

- reçu ;
- facture ;
- devis ;
- bon de commande ;
- bon de livraison ;
- rapport d'intervention ;
- photo ;
- document PDF.

Le système doit conserver :

```
Justificatif
├── fichier
├── type
├── date d'ajout
├── utilisateur
└── dépense associée

```

---

# 12. Module Vignettes carburant

C'est un module particulièrement important.

Une vignette doit contenir par exemple :

```
Vignette
├── Numéro
├── Véhicule
├── Montant attribué
├── Date d'attribution
├── Période
├── Responsable
├── Montant consommé
├── Montant justifié
├── Écart
└── Statut

```

Le système peut calculer automatiquement :

**Écart**

```
Écart = Montant attribué - Montant justifié

```

Exemple :

```
Attribué       : 500 DH
Justifié       : 450 DH
Écart           : 50 DH

```

Statut :

> À vérifier

---

# 13. Suivi du kilométrage

Je te recommande fortement d'ajouter ce module.

À chaque opération importante, le kilométrage peut être enregistré.

Exemple :

```
01/09
Kilométrage : 120 000 km

10/09
Carburant
Kilométrage : 120 180 km

20/09
Entretien
Kilométrage : 120 450 km

```

Le système construit alors automatiquement l'historique.

Cela permettra ensuite de calculer :

```
Distance parcourue
=
Kilométrage actuel
-
Kilométrage précédent

```

---

# 14. Suivi de consommation carburant

Une fois le kilométrage disponible, tu peux aller beaucoup plus loin.

Exemple :

```
Carburant consommé : 150 L
Distance : 1 000 km

```

Le système peut calculer :

```
Consommation = 150 / 1000 × 100

              = 15 L/100 km

```

Cela permet d'avoir un indicateur de consommation par véhicule.

**Attention :** une consommation élevée doit être considérée comme un indicateur à examiner, pas comme une preuve de fraude.

---

# 15. Module Maintenance

Créer un carnet d'entretien numérique.

Pour chaque véhicule :

```
Véhicule
   ↓
Historique maintenance
   ├── Vidange
   ├── Freins
   ├── Pneus
   ├── Batterie
   ├── Réparation moteur
   ├── Réparation électrique
   └── Autres

```

Chaque intervention peut contenir :

- date ;
- kilométrage ;
- type d'intervention ;
- fournisseur/garage ;
- montant ;
- pièces utilisées ;
- justificatif ;
- observation.

---

# 16. Module Documents administratifs

Tu peux également ajouter :

- assurance ;
- visite technique ;
- carte grise ;
- documents du véhicule ;
- autres documents administratifs.

Avec :

```
Date d'expiration
        ↓
Alerte automatique

```

Exemple :

> ⚠️ Assurance du véhicule J0244703 expire dans 15 jours.

---

# 17. Dashboard

Le dashboard est l'une des parties les plus importantes du projet.

## Dashboard global

Il peut afficher :

```
┌────────────────┬────────────────┬────────────────┐
│ Véhicules      │ Dépenses       │ Carburant      │
│ 25             │ 45 250 DH      │ 18 500 DH      │
└────────────────┴────────────────┴────────────────┘

```

Puis :

### Dépenses par catégorie

```
Carburant       18 500 DH
Entretien       12 000 DH
Pièces           8 500 DH
Lavage           2 000 DH
Autre            4 250 DH

```

### Dépenses par période

```
        Jan   Fév   Mar   Avr
        │     │     │     │
        ███   ████  ██    █████

```

### Dépenses par véhicule

```
J0244703      8 500 DH
J222691       6 200 DH
J233790       5 800 DH
...

```

---

# 18. Filtres du Dashboard

L'utilisateur doit pouvoir filtrer par :

- véhicule ;
- immatriculation ;
- type de dépense ;
- responsable ;
- mois ;
- trimestre ;
- année ;
- statut ;
- période personnalisée.

Par exemple :

> **Dépenses carburant → véhicule J0244703 → 3ème trimestre 2026**

Le système retourne directement le bilan.

---

# 19. Bilan mensuel

Pour chaque véhicule :

```
VÉHICULE : J0244703
Période : Septembre 2026

Carburant       1 200 DH
Entretien         500 DH
Lavage            100 DH
Réparation          0 DH
Pièces            300 DH
-------------------------
TOTAL           2 100 DH

```

---

# 20. Bilan trimestriel

Même principe :

```
3ème trimestre 2026

Carburant       3 800 DH
Entretien       1 500 DH
Lavage            300 DH
Réparation      2 000 DH
Pièces          1 200 DH
-------------------------
TOTAL           8 800 DH

```

---

# 21. Bilan annuel

```
Année 2026

Véhicules              25
Dépenses totales       185 500 DH

Carburant               82 000 DH
Entretien               42 000 DH
Réparation              25 000 DH
Pièces                  21 500 DH
Lavage                   5 000 DH
Autres                  10 000 DH

```

---

# 22. Système de traçabilité

C'est ici que ton projet devient vraiment intéressant.

**Chaque action importante doit laisser une trace.**

Exemple :

```
22/09/2026 09:15
Chef de parc
→ Création dépense
→ Véhicule J0244703
→ Carburant
→ 500 DH

```

Puis :

```
22/09/2026 11:32
Responsable véhicule
→ Ajout reçu
→ 450 DH

```

Puis :

```
23/09/2026 08:20
Vérificateur
→ Vérification
→ Écart : 50 DH
→ Demande d'explication

```

Puis :

```
23/09/2026 14:00
Responsable
→ Ajout observation
→ Justification de l'écart

```

Puis :

```
24/09/2026
Vérificateur
→ Validation

```

Tu obtiens ainsi une **timeline complète de la dépense**.

---

# 23. Journal d'audit

Je recommande fortement une table :

```
audit_logs

```

Elle enregistre :

```
Utilisateur
Action
Date/heure
Objet concerné
Ancienne valeur
Nouvelle valeur
Adresse IP

```

Exemple :

```
Utilisateur : Chef Parc
Action      : MODIFICATION
Objet       : Dépense #152
Ancien      : 500 DH
Nouveau     : 550 DH
Date        : 22/09/2026 10:32

```

Cela permet de savoir **qui a fait quoi et quand**.

---

# 24. Notifications

Le système peut générer des notifications :

### Justificatif manquant

> ⚠️ La dépense #152 nécessite un justificatif.

### Écart carburant

> ⚠️ Écart détecté entre montant attribué et montant justifié.

### Validation

> ✅ La dépense #152 a été validée.

### Rejet

> ❌ La dépense #152 a été rejetée.

### Document expirant

> ⚠️ L'assurance du véhicule J0244703 expire dans 10 jours.

---

# 25. Rapports et exports

L'application devra permettre l'export :

### Excel

Pour :

- dépenses ;
- carburant ;
- véhicules ;
- maintenance ;
- statistiques.

### PDF

Pour générer par exemple :

> **Bilan des dépenses du parc automobile — 3ème trimestre 2026**

avec :

- tableau ;
- totaux ;
- graphiques ;
- dépenses par véhicule ;
- dépenses par catégorie.

---

# 26. Sécurité

Le système doit utiliser un contrôle d'accès basé sur les rôles.

Exemple :

```
ADMIN
  ↓
Toutes les permissions

CHEF_PARC
  ↓
Gestion véhicules + dépenses

RESPONSABLE_VEHICULE
  ↓
Justificatifs + informations véhicule

VERIFICATEUR
  ↓
Contrôle + validation

CONSULTATION
  ↓
Lecture uniquement

```

Un utilisateur ne doit pas pouvoir modifier une opération qui ne relève pas de ses permissions.

---

# 27. Architecture fonctionnelle globale

Au final, ton application pourrait avoir cette structure :

```
FleetTrack
│
├── Dashboard
│
├── Parc automobile
│   ├── Véhicules
│   ├── Responsables
│   └── Affectations
│
├── Dépenses
│   ├── Toutes les dépenses
│   ├── Carburant
│   ├── Entretien
│   ├── Réparation
│   ├── Lavage
│   └── Pièces
│
├── Vignettes
│   ├── Vignettes
│   ├── Utilisation
│   └── Écarts
│
├── Maintenance
│   ├── Interventions
│   └── Historique
│
├── Justificatifs
│
├── Vérifications
│
├── Rapports
│   ├── Mensuel
│   ├── Trimestriel
│   └── Annuel
│
├── Notifications
│
├── Audit
│
└── Administration
    ├── Utilisateurs
    ├── Rôles
    └── Paramètres

```

# 28. MVP — Première version

Je te conseille **de ne pas développer tout cela immédiatement**.

Ton MVP devrait contenir seulement :

```
1. Authentification
2. Utilisateurs / rôles
3. Véhicules
4. Responsables
5. Dépenses
6. Vignettes carburant
7. Justificatifs
8. Workflow de validation
9. Dashboard
10. Bilans mensuels/trimestriels
11. Historique / audit
12. Export Excel/PDF

```

Puis dans une **V2** :

```
→ Maintenance avancée
→ Alertes automatiques
→ OCR des factures/reçus
→ Notifications
→ Analyse de consommation
→ Détection d'anomalies
→ Application mobile/PWA

```