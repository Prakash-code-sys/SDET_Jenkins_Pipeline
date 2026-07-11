# Jenkins Pipeline Configuration for Playwright Automation

This repository demonstrates a production-style **Jenkins Declarative Pipeline** for executing **Playwright (JavaScript)** automation tests. It covers parameterized builds, secure credential management, environment configuration, HTML report publishing, and CI/CD best practices.

---

## 🚀 Features

- ✅ Declarative Jenkins Pipeline
- ✅ GitHub Integration
- ✅ Parameterized Builds
- ✅ Secure `.env` File Management using Jenkins Credentials
- ✅ Node.js Tool Configuration
- ✅ Playwright Browser Installation
- ✅ Cross-Browser Test Execution
- ✅ HTML Report Publishing
- ✅ Artifact Archiving
- ✅ Post Build Actions

---

## 🛠 Tech Stack

- Jenkins
- Playwright
- JavaScript (Node.js)
- Git & GitHub
- HTML Publisher Plugin

---

## 📂 Repository Structure

```text
.
├── Jenkinsfile
├── package.json
├── playwright.config.js
├── tests/
├── pages/
├── utils/
└── README.md
```

---

## 📦 Jenkins Plugins Required

Install the following plugins before running the pipeline:

- Pipeline
- Git
- Git Client
- Credentials
- Credentials Binding
- NodeJS
- HTML Publisher
- Workspace Cleanup
- JUnit (Optional)

---

## ⚙️ Jenkins Configuration

### 1. Configure Node.js

Navigate to:

```
Manage Jenkins → Tools → NodeJS Installations
```

Add a Node.js installation (e.g., **Node22**) and save.

---

### 2. Configure Credentials

Store your `.env` file securely in Jenkins.

Navigate to:

```
Manage Jenkins
→ Credentials
→ System
→ Global Credentials
→ Add Credentials
```

Choose:

```
Kind: Secret File
```

Example Credential ID:

```
env-file
```

---

### 3. Create a Pipeline Job

- Create a new **Pipeline** job.
- Select **Pipeline script from SCM**.
- Configure your Git repository.
- Set the **Script Path** to:

```
Jenkinsfile
```

---

## ▶️ Build Parameters

The pipeline supports parameterized execution.

| Parameter | Description |
|-----------|-------------|
| BROWSER | Browser to execute tests (`chromium`, `firefox`, `webkit`) |
| WORKERS | Number of parallel workers |
| HEADLESS | Execute tests in headless/headed mode |

---

## ▶️ Running the Pipeline

The pipeline performs the following steps:

1. Checkout source code from GitHub
2. Install Node.js dependencies
3. Install Playwright browsers
4. Copy the `.env` file from Jenkins Credentials
5. Execute Playwright tests
6. Generate Playwright HTML Report
7. Publish the report in Jenkins
8. Archive build artifacts

---

## 📊 Reports

After successful execution, Jenkins publishes the Playwright HTML report.

Example report location:

```
playwright-report/index.html
```

---

## 🔒 Security

Sensitive information such as environment variables is **not stored in the Git repository**.

Instead, Jenkins securely injects the `.env` file using the **Credentials Binding Plugin** during pipeline execution.

---

## 📖 Learning Objectives

This repository demonstrates:

- Jenkins Declarative Pipeline
- CI/CD Best Practices
- Parameterized Builds
- Secure Secret Management
- Playwright Integration
- HTML Report Publishing
- Build Automation

---

## 🤝 Contributing

Contributions, suggestions, and improvements are welcome. Feel free to fork this repository and submit a pull request.

---

## ⭐ Support

If you found this repository helpful, consider giving it a ⭐ on GitHub.
