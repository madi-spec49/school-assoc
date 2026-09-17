# Portfolio Project — Stage 4

**Plateforme de cours à distance pour une association scolaire**

MVP permettant d'organiser des cours à distance le week-end pour environ **100 élèves** et **10 professeurs**. Développé dans le cadre d'un projet Portfolio (Stage 3), livrable en 3 mois.

## Stack technique

| Couche | Technologie |
| --- | --- |
| Back-end | Python + FastAPI |
| ORM | SQLAlchemy |
| Base de données | PostgreSQL |
| Authentification | JWT + bcrypt |
| Front-end | HTML + JavaScript natif |
| Conteneurisation | Docker (préproduction / production) |

## Périmètre du MVP

Le MVP se concentre sur le **cœur pédagogique** de l'application :

- ✅ Gestion des utilisateurs (élève, parent, professeur, staff) et authentification JWT
- ✅ Création et consultation des cours et sessions
- ✅ Demandes d'inscription et validation par le staff
- ✅ Saisie de l'assiduité par les professeurs
- ✅ Suivi de la progression des élèves

**Reportés en phase future** : signalements d'absence (Report), messagerie (Message), cotisation HelloAsso (Payment). Voir [`docs/7. Roadmap Phase Future.md`](docs/7.%20Roadmap%20Phase%20Future.md).

## Structure du dépôt

```
school-assoc/
├── README.md               # Ce fichier
├── .gitignore
├── .env.example            # Variables d'environnement (modèle)
├── docs/                   # Documentation technique complète
│   ├── README.md
│   ├── 0. User Stories et Maquettes.md
│   ├── 1. Architecture Système.md
│   ├── 2. Composants Classes et BDD.md
│   ├── 3. Diagrammes de Séquence.md
│   ├── 4. Spécifications API.md
│   ├── 5. SCM et QA.md
│   ├── 6. Documentation Technique Finale.md
│   ├── 7. Roadmap Phase Future.md
│   └── maquettes.html      # Wireframes interactifs
├── db/
│   └── schema.sql          # Schéma PostgreSQL des 7 tables du MVP
├── app/                    # Code FastAPI (à venir)
└── tests/                  # Tests pytest (à venir)
```

## Documentation

La documentation technique complète est dans le dossier [`docs/`](docs/) :

| # | Document | Contenu |
| --- | --- | --- |
| 0 | [User Stories et Maquettes](docs/0.%20User%20Stories%20et%20Maquettes.md) | User stories (MoSCoW) + wireframes |
| 1 | [Architecture Système](docs/1.%20Architecture%20Syst%C3%A8me.md) | Architecture 3 couches, flux de données |
| 2 | [Composants, Classes et BDD](docs/2.%20Composants%20Classes%20et%20BDD.md) | Classes, ERD, tables, interactions front |
| 3 | [Diagrammes de Séquence](docs/3.%20Diagrammes%20de%20S%C3%A9quence.md) | Cas d'usage critiques |
| 4 | [Spécifications API](docs/4.%20Sp%C3%A9cifications%20API.md) | Endpoints REST internes |
| 5 | [SCM et QA](docs/5.%20SCM%20et%20QA.md) | Git, tests, pipeline CI/CD |
| 6 | [Documentation Technique Finale](docs/6.%20Documentation%20Technique%20Finale.md) | **Document maître** |
| 7 | [Roadmap Phase Future](docs/7.%20Roadmap%20Phase%20Future.md) | Modules hors MVP |

### Maquettes interactives

Les wireframes des 5 écrans principaux sont dans [`docs/maquettes.html`](docs/maquettes.html) — à ouvrir directement dans un navigateur.

## Stratégie Git

- **`main`** : branche stable, ne reçoit que les versions livrées (fin de phase)
- **`develop`** : branche d'intégration (par défaut)
- **`feature/*`** : une branche par fonctionnalité (auth, courses, attendance, etc.)

### Conventions de commits (Conventional Commits)

`feat:`, `fix:`, `docs:`, `test:`, `refactor:`, `chore:`

Exemples :
- `feat: add POST /api/auth/login endpoint`
- `fix: handle expired JWT token`
- `docs: document registrations endpoints`
- `test: add unit tests for auth service`

### Cycle de travail

1. Une branche `feature/*` est créée depuis `develop`
2. Le travail est commité de façon atomique
3. La branche est fusionnée dans `develop` une fois la fonctionnalité terminée
4. `develop` est fusionnée dans `main` à la fin de chaque phase (jalon de livraison)

## Installation et développement (à venir)

Les instructions d'installation seront ajoutées au fur et à mesure du développement :

```bash
# À venir : création de l'environnement virtuel
# À venir : installation des dépendances
# À venir : configuration de la base de données
# À venir : lancement de l'application
```

## Auteur

**Madi Anli** — Étudiant à Holberton School de Laval