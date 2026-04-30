# 🎓 Campus Noticeboard Automation Pipeline

A modern, containerized university digital notice board platform built with a professional CI/CD pipeline, automated linting, and DevOps best practices.

## ✨ Project Highlights

- **Modern Design System**: Professional, responsive UI with smooth animations and accessibility features
- **Fully Automated CI/CD**: 3-stage GitHub Actions pipeline (lint → build → docker)
- **Code Quality**: HTMLHint and Stylelint validation on every commit
- **Production-Ready**: Docker containerization with nginx for scalable deployment
- **GitFlow Discipline**: Strict branching model with protection rules and PR-based workflows
- **Build Optimization**: Parcel bundler with minification and caching strategies

## 📋 Tech Stack

| Component | Version | Purpose |
|-----------|---------|---------|
| **Runtime** | Node.js 20 | Build and test environment |
| **Build Tool** | Parcel 2.15.4 | Bundle and minify assets |
| **HTML Validator** | HTMLHint 1.8.0 | Semantic HTML linting |
| **CSS Validator** | Stylelint 16.22.0 | CSS code quality |
| **Container** | Docker + Nginx Alpine | Production deployment |
| **CI/CD** | GitHub Actions | Automated pipelines |
| **Version Control** | Git + GitFlow | Repository management |

## 🎨 Features

### Design & UX
- **Responsive Layout**: Mobile-first design with breakpoints at 768px (tablet) and 480px (mobile)
- **Modern Color Palette**: Professional blues, purples, and neutrals with CSS variables
- **Smooth Animations**: Fade-in, slide-down, and pulse effects with 250ms transitions
- **Accessibility**: WCAG-compliant contrast ratios, focus states, reduced-motion support
- **Dark Mode**: Native support via `prefers-color-scheme` media query
- **Card-Based Layout**: Flexbox containers with hover elevation effects

### Development
- **Strict Validation**: HTML semantic checks + CSS modern notation enforcement
- **Hot Reload**: Development server with auto-refresh (`npm run dev`)
- **Minification**: Automatic asset optimization for production
- **Caching**: npm cache in CI for 30% faster builds

### DevOps
- **Multi-Stage Pipeline**: Lint → Build → Docker with dependency ordering
- **Branch Protection**: Develop-only CI triggers, no direct commits to main/develop
- **Containerization**: Lightweight nginx:alpine image (~20MB) with proper port exposure
- **Artifact Tracking**: Build logs and Docker image versioning

## 📁 Project Structure

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

## 🚀 Quick Start

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

## 🐳 Docker Deployment

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

## 🔄 GitFlow Workflow

This project implements a strict GitFlow branching model:

### Branch Structure
| Branch | Purpose | Protection |
|--------|---------|-----------|
| `main` | Production releases | ✅ Protected, no direct commits |
| `develop` | Integration/staging | ✅ Protected, PR-only merges |
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
# → CI pipeline runs automatically
# → Code review
# → Merge to develop (no-ff)

# 5. Delete feature branch after merge
git branch -d feature/your-feature-name
```

### Rules
- ✅ All feature work on `feature/*` branches
- ✅ Merge to `develop` **only via Pull Request**
- ✅ No direct commits to `main` or `develop`
- ✅ CI pipeline must pass before merge approval

## 📊 CI/CD Pipeline

The GitHub Actions workflow (`.github/workflows/ci.yml`) provides automated quality gates:

### Pipeline Stages

#### 1️⃣ **Lint Stage** (Runs on push/PR to develop)
```bash
# HTML validation
htmlhint "src/**/*.html"

# CSS validation  
stylelint "styles/**/*.css"
```
- Fails if semantic HTML rules violated
- Fails if CSS formatting/notation incorrect

#### 2️⃣ **Build Stage** (Depends on Lint)
```bash
# Minify and bundle assets
parcel build src/*.html --dist-dir dist
```
- Creates optimized `dist/` directory
- Minifies CSS (6.47 kB production size)
- Combines HTML pages

#### 3️⃣ **Docker Stage** (Depends on Build)
```bash
# Build container image
docker build -t campus-noticeboard-automation-pipeline:ci .
```
- Creates lightweight nginx:alpine image
- Ready for deployment

### Pipeline Triggers
- ✅ Push to `develop` branch
- ✅ Pull Requests targeting `develop`
- ❌ No triggers on `main` branch (prevents accidental deployments)

### View Pipeline Status
1. Go to **Actions** tab on GitHub
2. Select **CI** workflow
3. Click latest run to view job logs

## 🔍 Code Quality Standards

### HTML Validation (.htmlhintrc)
- Lowercase tag/attribute names
- Proper tag pairing and nesting
- DOCTYPE declaration first
- Double-quoted attributes
- No inline styles (use external CSS)
- Unique element IDs
- Images require alt text

### CSS Validation (.stylelintrc.json)
- Modern color notation (rgb with /)
- Short hex color codes
- No redundant longhand properties
- No descending specificity violations
- Consistent formatting

## 🎯 Linting & Fixing

### Check Issues
```bash
npm run lint:html    # Report HTML issues
npm run lint:css     # Report CSS issues
npm run build        # Test full build
```

### Common Fixes
```bash
# Fix inline styles (recommended approach)
# Instead of: <h2 style="color: blue;">Title</h2>
# Use: <h2 class="primary-text">Title</h2>

# Update font names with quotes
/* Before */ font-family: Segoe UI;
/* After */  font-family: "Segoe UI";

# Use modern CSS color syntax
/* Before */ rgba(0, 0, 0, 0.5)
/* After */  rgb(0 0 0 / 50%)
```

## 📱 Responsive Design Breakpoints

```css
/* Desktop (default) */
/* Tablet (≤ 768px) */
@media (width <= 768px) { ... }

/* Mobile (≤ 480px) */
@media (width <= 480px) { ... }
```

## 🛠️ Troubleshooting

| Issue | Solution |
|-------|----------|
| `npm install` fails | Delete `node_modules/` and `package-lock.json`, then reinstall |
| Linting errors | Run `npm run lint:html` and `npm run lint:css` to see details |
| Build fails | Check `.parcel-cache/` is in `.gitignore`, delete cache: `rm -rf .parcel-cache/` |
| Docker won't start | Ensure port 8080 is available: `lsof -i :8080` |
| CSS not updating | Clear browser cache (Ctrl+Shift+R) or use incognito mode |
| Footer positioning wrong | Check `styles/style.css` has flexbox: `body { display: flex; flex-direction: column; }` |

## 📄 Configuration Files

### `.htmlhintrc` - HTML Linting Rules
Defines 10 semantic validation rules for proper HTML structure.

### `.stylelintrc.json` - CSS Linting Rules
Extends `stylelint-config-standard` with modern CSS validation.

### `Dockerfile` - Container Definition
- Base: `nginx:alpine` (20MB, production-optimized)
- Copies source files to nginx document root
- Exposes port 80

### `package.json` - Node.js Configuration
- Production dependencies: None (static site)
- Dev dependencies: Parcel, HTMLHint, Stylelint
- Scripts: `dev`, `build`, `lint:html`, `lint:css`

## 🤝 Contributing Guidelines

1. **Create feature branch**: `git checkout -b feature/description`
2. **Make changes**: Ensure HTML/CSS pass linting
3. **Test locally**: `npm run dev` and verify all pages
4. **Push branch**: `git push origin feature/description`
5. **Create Pull Request**: Provide clear description of changes
6. **Address review feedback**: Make requested changes
7. **Merge**: After approval, merge to `develop` (automatic deployment)

## 📜 License

This project is provided as-is for educational purposes.

## 👤 Author

**Shaafea University** - 6th Semester DevOps Project

---

**Last Updated**: April 2026  
**Status**: Production-Ready ✅
