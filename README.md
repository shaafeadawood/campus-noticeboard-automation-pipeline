# Campus Noticeboard Automation Pipeline

## Project Overview

This repository provides a clean static website baseline for a campus noticeboard platform. It is designed to be simple, maintainable, and ready for DevOps pipeline integration in future phases.

## DevOps Pipeline Concept (High-Level)

The project follows a pipeline-ready structure where:

- Source files are organized by responsibility (content and styling).
- Containerization support is provided through Docker for consistent deployment.
- CI workflow location is predefined under `.github/workflows/` for future automation.
- GitFlow-style branching is used for development and release control.
- `develop` is the default integration branch.
- `main` is reserved for production releases.
- Feature branches must be merged into `develop` only through pull requests.
- Direct commits from feature branches to `main` or `develop` should be blocked by branch protection rules in GitHub.

## Folder Structure

```text
.
|-- .github/
|   `-- workflows/
|       `-- ci.yml
|-- src/
|   |-- index.html
|   |-- notices.html
|   |-- exams.html
|   |-- admissions.html
|   `-- contact.html
|-- styles/
|   `-- style.css
|-- Dockerfile
|-- package.json
|-- .gitignore
|-- .dockerignore
`-- README.md
```

## Tools Used

- Git and GitHub for version control and collaboration
- HTML5 and CSS3 for static site implementation
- Docker (Nginx base image) for containerized hosting
- GitHub Actions for CI on `develop` and pull requests targeting `develop`
