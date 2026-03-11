# Git Security Project

This repository serves as a guide and practice environment for Git security best practices.

## Modules
- [Sensitive Data Management](Security.md) - Learn how to protect secrets and avoid accidental leaks.
- [Security Scanner](scan-secrets.ps1) - Use the local scanner to verify your commits before pushing.

## Quick Start
1. Run a security scan before committing:
   ```powershell
   .\scan-secrets.ps1
   ```
2. Keep your `.gitignore` updated with any new sensitive file patterns.