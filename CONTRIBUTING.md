# Contributing

When contributing to this repository, please first discuss the change you wish to make via issue preferably ([GS Terraform Templates Request](https://gsinput.akamai.com/GS_TERRAFORM_REQUEST_FORM)), email, or any other method with the owners of this repository before making a change.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Branching Strategy](#branching-strategy)
- [Development Workflow](#development-workflow)
- [GitHub Workflows](#github-workflows)
- [Commit Conventions](#commit-conventions)
- [Pull Request Process](#pull-request-process)
- [Module Versioning](#module-versioning)
- [Testing](#testing)

## Prerequisites

**Required:**
* [Terraform >= 1.9.0](https://developer.hashicorp.com/terraform/downloads?product_intent=terraform)
* [PowerShell 7+](https://github.com/PowerShell/PowerShell) (not Windows PowerShell 5.1)
* [Akamai PowerShell v2+](https://techdocs.akamai.com/powershell/docs/overview) - For testing with `deploy.ps1`
* [`pre-commit`](https://pre-commit.com/) - Pre-commit hook framework
* [`terraform-docs`](https://terraform-docs.io/) - Auto-generates module documentation
* [`tflint`](https://github.com/terraform-linters/tflint) - Terraform linting
* [`trivy`](https://github.com/aquasecurity/trivy) - Security scanning

### Setup Pre-Commit Hooks

**You must install pre-commit hooks** to ensure code quality before committing:

```bash
pre-commit install
```

This will automatically run validation checks (format, docs, lint) on every commit. To manually run all checks:

```bash
pre-commit run --all-files   
```

**Why required?** The PR validation workflow will **fail** if:
- Code is not formatted (`terraform fmt`)
- README.md is outdated (needs `terraform-docs`)
- Linting issues exist (`tflint`)

Pre-commit hooks catch these issues locally before you push.

## Branching Strategy

This repository uses a **three-stage branching model** with automated CI/CD:

```
feature branch → integration (PR validation + auto-docs) → main (release automation)
```

### Branch Purposes

| Branch | Purpose | Triggers |
|--------|---------|----------|
| **Feature branches** | Active development work | Nothing |
| **`integration`** | Pre-release testing and validation | **PR validation workflow** (on PR) + **Terraform Docs workflow** (on merge) |
| **`main`/`master`** | Production-ready code | **Release automation workflow** |

### Branch Protection Rules

**Required for `integration` branch:**
- Require pull request reviews before merging
- Require status checks to pass (PR validation workflow)
- Require branches to be up to date before merging

**Required for `main` branch:**
- All of the above, plus:
- Restrict push access (only allow merges from `integration`)
- Require linear history (squash or rebase merges)

### Branch Naming Convention

Use descriptive branch names that match commit types for consistency:

**Format:** `<type>/<short-description>` or `<type>/<issue>-<short-description>`

**Examples:**
```bash
# New features
feat/custom-rate-policies
feat/DOHRMY-126-botman-integration

# Bug fixes
fix/rate-policy-import
fix/DOHRMY-456-state-file-conflict

# Improvements
improvement/deploy-script-retry

# Documentation
docs/update-readme-examples

# Refactoring
refactor/module-structure

# CI/CD changes
ci/add-security-scan
```

**Guidelines:**
- Use lowercase with hyphens (kebab-case)
- Be descriptive but concise (3-5 words max)
- Include issue/ticket number when applicable
- Match the commit type you'll use later
- Avoid special characters except hyphens and forward slashes

## Development Workflow

### 1. Create Feature Branch

Always branch from `integration`, not `main`. See [Branch Naming Convention](#branch-naming-convention) above for required format.

```bash
git checkout integration
git pull origin integration
git checkout -b feat/add-custom-rate-policies
```

### 2. Make Changes

- Follow Terraform best practices
- Update documentation (`main.tf` comments, `.tfvars.dist` examples)
- Test locally using `deploy.ps1`
- Pre-commit hooks will auto-run on `git commit` (formats code, updates README.md)
- Or run manually: `pre-commit run --all-files`

### 3. Commit with Conventional Commits

See [Commit Conventions](#commit-conventions) below for required format.

```bash
git add .
git commit -m "feat(aap): add support for custom rate policies"
```

### 4. Push and Create Pull Request

```bash
git push origin feat/add-custom-rate-policies
```

Open PR against **`integration`** branch (not `main`). This triggers the **PR Validation workflow**. See [Pull Request Process](#pull-request-process) below.

### 5. Integration Testing

After PR is merged to `integration`:
- **Terraform Docs workflow auto-runs** - Updates template README.md files automatically
- Test the integrated changes thoroughly
- Verify multiple templates work together
- Confirm template release version compatibility
- Template README.md files should now reflect latest changes (auto-committed by workflow)

### 6. Promote to Production

When ready for release, create PR from `integration` to `main`. Once merged, this triggers the **Release Automation workflow** which:
- Analyzes commits and determines version bump
- Updates `VERSION` file and `CHANGELOG.md`
- Creates Git tag and GitHub release

## GitHub Workflows

This repository uses **three automated workflows** that execute in sequence:

### 1. PR Validation (`.github/workflows/pr-validation.yml`)

**Trigger:** Pull requests to `integration` branch

**Purpose:** Validate code quality and security before merging

**Runs:**
1. **Terraform Format Check** - Ensures consistent formatting
2. **Terraform Validate** - Tests all templates (AAP, AAP+ASM, Property)
3. **TFLint** - Static analysis for best practices
4. **Trivy Security Scan** - Identifies vulnerabilities (uploads to GitHub Security tab)

**Note:** This workflow does NOT modify code. All checks are read-only validation.

### 2. Terraform Docs Automation (`.github/workflows/tf-docs.yml`)

**Trigger:** Pushes to `integration` branch (i.e., when PRs are merged)

**Purpose:** Auto-generate and commit updated README.md files for all templates

**Runs:**
1. **Generate terraform-docs for AAP Configuration** - Updates `new-aap-configuration/README.md`
2. **Generate terraform-docs for AAP/ASM Configuration** - Updates `new-aapasm-configuration/README.md`
3. **Generate terraform-docs for Property** - Updates `new-property/README.md`
4. **Auto-commit** - Pushes updated README.md files back to `integration` branch

**Note:** This workflow runs AFTER merge to `integration`, ensuring documentation stays in sync with code changes.

### 3. Release Automation (`.github/workflows/release.yml`)

**Trigger:** Merges to `main` or `master` branch

**Purpose:** Create versioned releases with changelog and tags

**Runs:**
1. Analyzes conventional commits since last tag
2. Determines version bump (major/minor/patch)
3. Updates `VERSION` file
4. Generates/updates `CHANGELOG.md`
5. Commits changes with `[skip ci]` to prevent loops
6. Creates Git tag (e.g. `v1.2.3`)
7. Publishes GitHub release with extracted release notes

**Version Bump Logic:**
- `feat!:` or `BREAKING CHANGE:` → **Major** (1.0.0 → 2.0.0)
- `feat:` or `feature:` → **Minor** (1.0.0 → 1.1.0)
- `fix:` or `bugfix:` → **Patch** (1.0.0 → 1.0.1)

### 4. Automated Template Updates (`.github/workflows/release.yml`)

**Trigger:** Successful completion of Release Automation workflow

**Purpose:** Automatically propagate module version updates to the `terraform-templates` repository

**Runs:**
1. **Checkout Templates Repository** - Clones `terraform-templates` on the `integration` branch using PAT authentication
2. **Create Update Branch** - Creates a feature branch named `chore/update-modules-<version>` (e.g., `chore/update-modules-v1.2.3`)
3. **Update Module References** - Uses `sed` to find and replace all module source references in `main.tf` files with the new version tag
4. **Commit and Push** - Commits changes with message `chore: update terraform-templates-modules to <version>` and pushes to remote
5. **Create Pull Request** - Opens a PR against the `integration` branch in `terraform-templates` with:
   - Description of changes
   - Link to the release changelog
   - List of updated module references

**What This Means:**
- Whenever a new release is tagged in `terraform-templates-modules`, an automated PR is created in `terraform-templates`
- The PR updates all module version references from the old version to the new release tag
- This ensures templates are kept in sync with module updates automatically
- The PR targets the `integration` branch for validation before promoting to production
- Reviewers can verify changes and test before merging

**Note:** This step only runs if the release workflow successfully creates a new version. If no semantic commits are found (release skipped), this step is also skipped.

### Setting Up Required Secrets

#### PAT_TOKEN for Accessing the `terraform-templates` Repository`

The Release Automation workflow requires a **Personal Access Token (PAT)** to create automated pull requests in the `terraform-templates` repository whenever a new module version is released.

**Creating a Fine-Grained Personal Access Token:**

1. **Navigate to GitHub Settings:**
   - Click your profile picture → **Settings**
   - Scroll down to **Developer settings** (bottom left)
   - Click **Personal access tokens** → **Fine-grained tokens**
   - Click **Generate new token**

2. **Configure Token Details:**
   - **Token name:** `MODULES_TO_TEMPLATES_AUTOMATION` (or similar descriptive name)
   - **Expiration:** Recommend 90 days or 1 year (set a calendar reminder to rotate)
   - **Description:** `Automated PR creation for module version updates in terraform-templates`
   - **Resource owner:** Select your organization or personal account
   - **Repository access:** Select **Only select repositories**
     - Choose: `terraform-templates` (the repository receiving the automated PRs)

3. **Configure Repository Permissions:**
   
   Under "Repository permissions," set these specific permissions:
   
   | Permission | Access Level | Purpose |
   |------------|--------------|---------|
   | **Contents** | **Read and write** | Required to clone repository, create branches, and push commits |
   | **Pull requests** | **Read and write** | Required to create pull requests via GitHub CLI |
   | **Metadata** | **Read-only** | Always enabled by default, allows repository discovery |

   **Important:** Do NOT grant broader permissions than necessary. The token should only have access to `terraform-templates` and only the permissions listed above.

4. **Generate and Copy Token:**
   - Click **Generate token**
   - **Immediately copy the token** - you won't see it again!
   - Store it securely (consider using a password manager)

5. **Add Token to Repository Secrets:**
   - Navigate to the **`terraform-templates-modules`** repository (the modules repo, not templates)
   - Go to **Settings** → **Secrets and variables** → **Actions**
   - Click **New repository secret**
   - **Name:** `PAT_TOKEN` (must match exactly as referenced in workflow)
   - **Value:** Paste the token you just copied
   - Click **Add secret**

6. **Token Rotation:**
   - Set a reminder to rotate the token before expiration
   - When rotating, generate a new token with identical permissions
   - Update the `PAT_TOKEN` secret with the new value
   - Test the workflow by creating a test release

**Security Best Practices:**
- ✅ Use fine-grained tokens instead of classic tokens (more secure, scoped permissions)
- ✅ Limit token to only the `terraform-templates` repository
- ✅ Set expiration dates and rotate regularly
- ✅ Never commit the token to version control
- ✅ Audit token usage periodically in GitHub settings
- ❌ Never use tokens with broader organization-wide permissions
- ❌ Never share tokens across multiple workflows unless necessary

## Commit Conventions

This repository follows [Conventional Commits](https://www.conventionalcommits.org/) for automated changelog generation.

### Format

```
<type>(<scope>): <subject>
```

### Types

| Type | Purpose | Version Bump | Example |
|------|---------|--------------|---------|
| `feat!:` | Breaking changes | Major (1.0.0→2.0.0) | `feat!: upgrade to Terraform 1.9` |
| `feat:` or `feature:` | New features | Minor (1.0.0→1.1.0) | `feat(aap): add custom rate policies` |
| `fix:` or `bugfix:` | Bug fixes | Patch (1.0.0→1.0.1) | `fix(asm): correct match target config` |
| `improvement:` | Enhancements | Patch | `improvement: optimize state backend` |
| `docs:` | Documentation | None | `docs: update README examples` |
| `refactor:` | Code restructuring | None | `refactor: simplify module calls` |
| `chore:` | Maintenance | None (skipped) | `chore: update dependencies` |
| `test:` | Add or Update Tests | None | `test: deployment script` |

### Breaking Changes

Add `!` after type or include `BREAKING CHANGE:` in commit body:

```bash
git commit -m "feat!: require PowerShell 7+"

# Or with body:
git commit -m "feat: upgrade Akamai provider

BREAKING CHANGE: Provider v9.0 requires Terraform >= 1.9.0"
```

### Scopes (Optional)

Use scopes to indicate which template is affected:
- `(aap)` - App & API Protector template
- `(aapasm)` - AAP+ASM template  
- `(pm)` - Property Manager template
- `(deploy)` - deploy.ps1 script
- `(ci)` - CI/CD workflows
- `(docs)`: Documentation

### Examples

```bash
# Feature (minor bump)
git commit -m "feat(aap): add support for custom rate policies"

# Bug fix (patch bump)
git commit -m "fix(asm): correct match target configuration"

# Breaking change (major bump)
git commit -m "feat!: upgrade to Terraform 1.6"

# Documentation
git commit -m "docs: update README with new examples"

# Chore
git commit -m "chore: update dependencies"
```

## Pull Request Process

### Creating a Pull Request

1. **Fork the project** (for external contributors) or create branch (for team members)

2. **Create feature branch from `integration`**:
   ```bash
   git checkout -b feat/your-feature-name integration
   ```

3. **Make your changes**:
   - Update code/templates
   - Update documentation (`main.tf`, `.tfvars.dist`)
   - Test with: `pwsh deploy.ps1 <template> -Env dev -Save -Dry`
   - Pre-commit hooks will run on commit (or manually: `pre-commit run --all-files`)

4. **Commit with conventional format**:
   ```bash
   git commit -m "feat(aap): add new feature"
   ```

5. **Push to remote**:
   ```bash
   git push origin feat/your-feature-name
   # Git will output a URL - click it to create PR
   ```

6. **Create PR against `integration`**:
   ```bash
   # Option 1: Open repo in browser - GitHub will show "Compare & pull request" banner
   open https://github.com/akamai/terraform-templates/pulls
   
   # Option 2: Use GitHub CLI (requires 'gh' installed)
   gh pr create --base integration --title "feat(aap): add new feature" --body "Description of changes"
   ```

7. **Wait for PR validation to pass** - All checks must be green

8. **Address review feedback** if requested

8. **Merge to integration** - Test thoroughly

9. **Create PR from `integration` to `main`** when ready for release

### PR Checklist

Before submitting, ensure:

- [ ] Pre-commit hooks installed and run successfully
- [ ] Conventional commit format used (at least one semantic commit)
- [ ] Documentation updated (`main.tf`, inline comments, `.tfvars.dist`)
- [ ] Tested with `deploy.ps1` for affected templates
- [ ] Module version references are pinned (never use `ref=main`)
- [ ] PR validation workflow passes (all checks green)

**Note:** Template README.md files are auto-generated by the Terraform Docs workflow after merge to `integration`, so you don't need to update them manually.

**Note:** If PR validation fails on formatting/docs, run `pre-commit run --all-files` locally and push the fixes.

## Module Versioning

Each merge to `main` will trigger the release workflow, which will tag the module with a version based on the `conventional-changelog-action@v6.`

### Using Modules in Templates Repository

Always pin modules to specific versions using Git tags:

```hcl
module "security" {
  source = "git::ssh://git@github.com/akamai/terraform-templates-modules.git//aap/security?ref=v1.1.1"
  # ...
}
```

**Never use:** `ref=main` or `ref=master` in production templates.

## Testing

### Local Testing
- Test the modules by calling them from the Templates code (i.e. running the `deploy.ps1` script). 
- Update your `main.tf` module references in your Templates code with the new tag (e.g. `ref=v1.2.3`).

Before submitting PR, test your changes:

```bash
pwsh deploy.ps1 <template> -Env dev -Save

# or

# Dry-run (plan only, no changes)
pwsh deploy.ps1 <template> -Env dev -Save -Dry

# Examples:
pwsh deploy.ps1 aap -Env dev -Save -Dry
pwsh deploy.ps1 aapasm -Env qa -Save -Dry
pwsh deploy.ps1 pm -Env dev -Save -Dry
```

### Debug Mode

Enable detailed logging for troubleshooting:

```bash
pwsh deploy.ps1 aap -Env dev -Save -Debug
# Logs saved to: ./new-aap-configuration/environments/dev/dev-akamai_tf.log
```

### Terraform Commands

While `deploy.ps1` is the primary interface, you can run Terraform directly for debugging:

```bash
cd new-aap-configuration
terraform init -backend-config="./environments/dev/config.backend"
terraform plan -var-file="./environments/dev/dev.tfvars"
```

**Note:** Direct Terraform usage bypasses state isolation and retry logic.

## Versioning and Changelog

### Automated Process

With the release workflow, versioning is **fully automated**:
- ✅ Commits analyzed for semantic prefixes
- ✅ `VERSION` file auto-updated on `main` branch
- ✅ `CHANGELOG.md` auto-generated with categorized entries
- ✅ Git tags created automatically
- ✅ GitHub releases published

**No manual changelog or version updates needed!**

**Note:** `VERSION` and `CHANGELOG.md` files in the `integration` branch may be outdated. The `main` branch is the single source of truth for releases. Always check the latest tag or `main` branch to see the current version.

### Manual Override (Emergency Only)

If automation fails, manually update:

1. **VERSION file** - Single line with semantic version
2. **CHANGELOG.md** - Add entry following existing format
3. **Git tag** - Create and push tag matching VERSION

## Questions or Issues?

- Open an issue: [GitHub Issues](https://github.com/akamai/terraform-templates/issues)
- Request features: [GS Terraform Templates Request Form](https://gsinput.akamai.com/GS_TERRAFORM_REQUEST_FORM)
- Support: [Webex Space: Terraform Templates Support](webexteams://im?space=52d5bcf0-42d2-11f0-9dd9-91df9cb369f0)

---

Thank you for contributing to PS Terraform Templates!
