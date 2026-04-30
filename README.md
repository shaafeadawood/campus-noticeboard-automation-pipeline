# Campus Noticeboard Automation Pipeline

A modern, containerized university digital notice board platform built with a professional CI/CD pipeline, automated linting, and DevOps best practices. This project demonstrates enterprise-grade development practices including continuous integration, code quality validation, and containerized deployment.

## Project Highlights

- **Modern Design System** — Professional, responsive UI with smooth animations and accessibility features
- **Fully Automated CI/CD** — 3-stage GitHub Actions pipeline (lint → build → docker)
- **Code Quality** — HTMLHint and Stylelint validation on every commit
- **Production-Ready** — Docker containerization with nginx for scalable deployment
- **GitFlow Discipline** — Strict branching model with protection rules and PR-based workflows
- **Build Optimization** — Parcel bundler with minification and caching strategies

## Tech Stack

| Component | Version | Purpose |
|-----------|---------|---------|
| **Runtime** | Node.js 20 | Build and test environment |
| **Build Tool** | Parcel 2.15.4 | Bundle and minify assets |
| **HTML Validator** | HTMLHint 1.8.0 | Semantic HTML linting |
| **CSS Validator** | Stylelint 16.22.0 | CSS code quality |
| **Container** | Docker + Nginx Alpine | Production deployment |
| **CI/CD** | GitHub Actions | Automated pipelines |
| **Version Control** | Git + GitFlow | Repository management |

## Features

### Design & User Experience
- **Responsive Layout** — Mobile-first design with breakpoints at 768px (tablet) and 480px (mobile)
- **Modern Color Palette** — Professional blues, purples, and neutrals with CSS variables
- **Smooth Animations** — Fade-in, slide-down, and pulse effects with 250ms transitions
- **Accessibility** — WCAG-compliant contrast ratios, focus states, reduced-motion support
- **Dark Mode** — Native support via `prefers-color-scheme` media query
- **Card-Based Layout** — Flexbox containers with hover elevation effects

### Development Tools
- **Strict Validation** — HTML semantic checks + CSS modern notation enforcement
- **Hot Reload** — Development server with auto-refresh (`npm run dev`)
- **Minification** — Automatic asset optimization for production
- **Caching** — npm cache in CI for 30% faster builds

### DevOps Infrastructure
- **Multi-Stage Pipeline** — Lint → Build → Docker with dependency ordering
- **Branch Protection** — Develop-only CI triggers, no direct commits to main/develop
- **Containerization** — Lightweight nginx:alpine image (~20MB) with proper port exposure
- **Artifact Tracking** — Build logs and Docker image versioning

## Project Structure

```
campus-noticeboard-automation-pipeline/
├── .github/
│   └── workflows/
│       └── ci.yml                   # 3-job GitHub Actions pipeline
├── src/                             # HTML pages
│   ├── index.html                   # Home page
│   ├── notices.html                 # Notice board
│   ├── exams.html                   # Exam schedule
│   ├── admissions.html              # Admissions info
│   └── contact.html                 # Contact page
├── styles/
│   └── style.css                    # Modern design system (6.47 kB minified)
├── .htmlhintrc                      # HTML validation rules
├── .stylelintrc.json                # CSS validation rules
├── Dockerfile                       # nginx container definition
├── package.json                     # Node.js project manifest
├── .gitignore                       # Git exclusions (node_modules, dist, .parcel-cache)
└── README.md                        # This file
```

## Quick Start

### Prerequisites

- Node.js 20+ ([Download](https://nodejs.org/))
- Docker Desktop ([Download](https://www.docker.com/products/docker-desktop))
- Git

### Installation

```bash
# Clone the repository
git clone https://github.com/shaafeadawood/campus-noticeboard-automation-pipeline.git
cd campus-noticeboard-automation-pipeline

# Install dependencies
npm install

# Verify linting and build
npm run lint:html && npm run lint:css && npm run build
```

### Development

```bash
# Start local dev server with hot reload
npm run dev
# Opens http://localhost:1234 automatically

# Run individual linters
npm run lint:html    # Check HTML semantic rules
npm run lint:css     # Check CSS quality

# Build for production
npm run build        # Creates dist/ directory with minified assets
```

## Docker Deployment

### Build Image
```bash
docker build -t campus-noticeboard:latest .
```

### Run Container
```bash
# Development/testing
docker run -d -p 8080:80 --name noticeboard campus-noticeboard:latest

# Production (detached, restart policy)
docker run -d \
  -p 80:80 \
  --name noticeboard \
  --restart unless-stopped \
  campus-noticeboard:latest
```

### Access Container
- Local: http://localhost:8080
- Pages available:
  - `/index.html` - Home
  - `/notices.html` - Notices
  - `/exams.html` - Exams
  - `/admissions.html` - Admissions
  - `/contact.html` - Contact

### Cleanup
```bash
docker stop noticeboard
docker rm noticeboard
```

## GitFlow Workflow

This project implements a strict GitFlow branching model:

### Branch Structure

| Branch | Purpose | Protection |
|--------|---------|-----------|
| `main` | Production releases | Protected, no direct commits |
| `develop` | Integration/staging | Protected, PR-only merges |
| `feature/*` | Feature development | Regular branches, PR to develop |

### Development Workflow

```bash
# 1. Create feature branch from develop
git checkout develop
git pull origin develop
git checkout -b feature/your-feature-name

# 2. Make changes and commit
git add .
git commit -m "Add your feature"

# 3. Push to remote
git push origin feature/your-feature-name

# 4. Create Pull Request to develop (requires approval)
# CI pipeline runs automatically
# Code review conducted
# Merge to develop (no-ff)

# 5. Delete feature branch after merge
git branch -d feature/your-feature-name
```

### Workflow Rules

- All feature work must be on `feature/*` branches
- Merge to `develop` only via Pull Request
- No direct commits to `main` or `develop`
- CI pipeline must pass before merge approval

## CI/CD Pipeline

The GitHub Actions workflow (`.github/workflows/ci.yml`) provides automated quality gates across three distinct stages:

### Stage 1: Lint Validation

Runs on all push and pull request events targeting the `develop` branch.

```bash
# HTML validation
htmlhint "src/**/*.html"

# CSS validation  
stylelint "styles/**/*.css"
```

Validation rules:
- Semantic HTML structure requirements enforced
- CSS formatting and modern notation checked
- Fails pipeline if violations detected

### Stage 2: Build Optimization

Depends on successful lint completion.

```bash
# Minify and bundle assets
parcel build src/*.html --dist-dir dist
```

Output:
- Optimized `dist/` directory created
- CSS minified to 6.47 kB production size
- HTML pages compiled and bundled

### Stage 3: Docker Container Build

Depends on successful build completion.

```bash
# Build container image
docker build -t campus-noticeboard-automation-pipeline:ci .
```

Result:
- Lightweight nginx:alpine image created
- Ready for staging and production deployment

### Pipeline Configuration

**Triggers:**
- Push events to `develop` branch
- Pull requests targeting `develop` branch
- No automatic triggers on `main` branch (prevents accidental deployments)

**Viewing Pipeline Status:**
1. Navigate to Actions tab on GitHub repository
2. Select CI workflow from the list
3. Click latest run to view detailed job logs

## Code Quality Standards

### HTML Validation (.htmlhintrc)

Semantic HTML requirements:
- Lowercase tag and attribute names enforced
- Proper tag pairing and nesting validation
- DOCTYPE declaration must appear first
- Double-quoted attribute values required
- No inline styles permitted (use external CSS classes)
- Unique element IDs throughout document
- Images require descriptive alt text

### CSS Validation (.stylelintrc.json)

Modern CSS standards applied:
- Modern color notation (rgb with `/` syntax)
- Short hex color code format required
- No redundant longhand properties
- No descending specificity violations
- Consistent formatting and spacing

## Linting and Code Fixing

### Validate Your Code

```bash
npm run lint:html    # Report HTML issues
npm run lint:css     # Report CSS issues
npm run build        # Test full build pipeline
```

### Common Issues and Solutions

**Inline Styles**
```bash
# Incorrect approach
<h2 style="color: blue;">Title</h2>

# Correct approach
<h2 class="primary-text">Title</h2>
```

**Font Family Quotes**
```css
/* Incorrect */
font-family: Segoe UI;

/* Correct */
font-family: "Segoe UI";
```

**Color Notation**
```css
/* Incorrect (deprecated) */
rgba(0, 0, 0, 0.5)

/* Correct (modern) */
rgb(0 0 0 / 50%)
```

## Responsive Design

### Breakpoint Structure

```css
/* Desktop (default) */
/* Tablet (≤ 768px) */
@media (width <= 768px) { ... }

/* Mobile (≤ 480px) */
@media (width <= 480px) { ... }
```

## Troubleshooting

Common issues and their solutions:

| Issue | Solution |
|-------|----------|
| `npm install` fails | Delete `node_modules/` and `package-lock.json`, then reinstall |
| Linting errors appear | Run `npm run lint:html` and `npm run lint:css` for detailed output |
| Build process fails | Check `.parcel-cache/` is in `.gitignore`, then delete cache: `rm -rf .parcel-cache/` |
| Docker container won't start | Verify port 8080 is available: `lsof -i :8080` |
| CSS changes not visible | Clear browser cache (Ctrl+Shift+R) or open in incognito mode |
| Footer positioning incorrect | Verify `styles/style.css` has flexbox: `body { display: flex; flex-direction: column; }` |

## Configuration Files

### .htmlhintrc — HTML Validation Rules

Defines 10 semantic validation rules for proper HTML structure and best practices.

### .stylelintrc.json — CSS Validation Rules

Extends `stylelint-config-standard` configuration with modern CSS validation rules.

### Dockerfile — Container Definition

- Base image: `nginx:alpine` (20MB, production-optimized)
- Copies source files to nginx document root
- Exposes port 80 for web traffic

### package.json — Node.js Project Configuration

- Production dependencies: None (static site only)
- Development dependencies: Parcel, HTMLHint, Stylelint
- Available scripts: `dev`, `build`, `lint:html`, `lint:css`

## Contributing Guidelines

1. Create a feature branch from develop: `git checkout -b feature/description`
2. Make code changes and commit with clear messages
3. Ensure HTML and CSS pass linting validations
4. Test locally: `npm run dev` and verify all pages render correctly
5. Push branch to remote: `git push origin feature/description`
6. Create Pull Request with detailed description of changes
7. Address any review feedback from team members
8. After approval, merge to develop branch (automatic deployment)
