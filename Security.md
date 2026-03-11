# Sensitive Data Management
This repository must never contain sensitive information. Secrets should always be stored securely using environment variables or secret managers.
# Information That Must Never Be Pushed
Do not commit the following:
- API keys and tokens
- Private keys (SSH, SSL, signing keys)
- Database credentials (usernames, passwords, connection strings)
- .env files or environment variables
- Cloud credentials (AWS, Azure, GCP keys)
- Passwords or authentication tokens
These should be added to .gitignore to prevent accidental commits.

## Risks of Committed Secrets
Committing secrets can lead to:
- Account takeover – attackers gain access to services
- Data breaches – sensitive user or company data exposed
- Infrastructure abuse – attackers use cloud resources
- Permanent exposure – secrets remain in Git history even if deleted

## Public vs Private Repository
- Public repository
Anyone on the internet can view and clone the code.
- Private repository
Only authorized users can access it.

Note: Even in private repositories, secrets should never be committed.

