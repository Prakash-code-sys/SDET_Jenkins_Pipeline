## 1. What is Jenkins?
Answer:
Jenkins is an open-source automation server used to automate the software development lifecycle, including:
Build 
Testing 
Deployment 
Continuous Integration (CI) 
Continuous Delivery (CD) 
For Playwright, Jenkins automatically executes automation tests whenever code is pushed to the repository.

## 2. What is Continuous Integration (CI)?
Answer:
Continuous Integration is the practice of automatically building and testing code whenever developers commit changes.
Flow:
Developer
     ↓
Git Push
     ↓
Jenkins detects changes
     ↓
Install dependencies
     ↓
Run Playwright tests
     ↓
Generate Report
     ↓
Email/Slack notification

## 3. How do you integrate Playwright with Jenkins?
Answer:
Steps:
1.Install Jenkins 
2.Install Node.js on Jenkins machine 
3.Clone project from GitHub 
4.Install dependencies 
npm install
5.Install browsers 
npx playwright install
6.Run tests 
npx playwright test
7.Publish HTML Report 

## 4. What is a Jenkins Pipeline?
Answer:
A Pipeline is a script that defines the build process as code.
Example stages:
Checkout 
Install dependencies 
Run Playwright tests 
Generate report 
Archive artifacts 
Send notification 

## 5. Difference between Freestyle Job and Pipeline?
Freestyle	Pipeline
GUI configuration	Code based
Hard to maintain	Easy to maintain
Less flexible	Highly flexible
No version control	Stored in Git
Simple projects	Enterprise projects
Pipeline is preferred.

## 6. What is a Jenkinsfile?
Answer:
A Jenkinsfile is a text file containing pipeline stages.
Example:
pipeline {
    agent any

    stages {

        stage('Checkout'){
            steps{
                git 'https://github.com/user/project.git'
            }
        }

        stage('Install'){
            steps{
                sh 'npm install'
            }
        }

        stage('Playwright'){
            steps{
                sh 'npx playwright test'
            }
        }
    }
}

## 7. How do you trigger Jenkins automatically?
Answer:
Using:
GitHub Webhook 
Poll SCM 
Scheduled Cron Job 
Manual Trigger 
Upstream Job 
API Trigger 

## 8. What is Poll SCM?
Answer:
Jenkins checks the repository at regular intervals.
Example:
H/5 * * * *
Checks every 5 minutes.

## 9. What is GitHub Webhook?
Answer:
Whenever code is pushed to GitHub, GitHub immediately notifies Jenkins.
Flow:
Developer
      ↓
Git Push
      ↓
GitHub Webhook
      ↓
Jenkins
      ↓
Run Tests
Much faster than Poll SCM.

## 10. How do you generate Playwright HTML reports in Jenkins?
Run:
npx playwright test
Playwright automatically creates:
playwright-report/
Publish this folder as HTML Report.

## 11. How do you archive reports in Jenkins?
Use:
Archive Artifacts
Example:
playwright-report/**
This preserves reports after the job completes.

## 12. How do you publish Playwright reports?
Install the HTML Publisher plugin.
Post-build action:
HTML Publisher
Directory:
playwright-report
File:
index.html

## 13. What is an Artifact?
Answer:
Artifacts are files generated during a build.
Examples:
HTML Report 
Screenshots 
Videos 
Trace files 
Logs 
JUnit XML 

## 14. How do you run Playwright in headless mode on Jenkins?
npx playwright test
Playwright runs headless by default in CI.
Or configure:
use: {
    headless: true
}

## 15. How do you run only smoke tests?
Tag tests:
test.describe('@smoke', () => {
});
Run:
npx playwright test --grep @smoke

## 16. How do you pass environment variables in Jenkins?
Example:
ENV=QA
Access in Playwright:
process.env.ENV
Run:
ENV=QA npx playwright test

## 17. How do you run different environments?
Example:
QA

UAT

PROD
Jenkins parameter:
Environment:
QA
UAT
PROD
Run:
BASE_URL=https://qa.site.com npx playwright test

## 18. What plugins are commonly used?
Git 
NodeJS 
HTML Publisher 
JUnit 
Pipeline 
Credentials 
Email Extension 
Slack Notification 

## 19. What is the use of Credentials in Jenkins?
Credentials securely store:
Username 
Password 
API Key 
SSH Key 
Tokens 
Never hardcode secrets.

## 20. How do you use credentials?
environment {
    USER = credentials('login-user')
}

## 21. What is a Jenkins Agent?
Answer:
Agent (formerly Slave) executes build jobs.
Master schedules jobs.
Master
   |
   |------Agent Linux
   |
   |------Agent Windows
   |
   |------Agent Docker

## 22. How do you execute Playwright on Linux?
npm install

npx playwright install

npx playwright test

## 23. How do you execute on Windows?
npm install

npx playwright install

npx playwright test

## 24. How do you schedule nightly execution?
Cron:
0 1 * * *
Runs every day at 1 AM.

## 25. How do you retry failed builds?
Use pipeline:
retry(2){
    sh 'npx playwright test'
}

## 26. What happens when a Playwright test fails?
Jenkins:
Marks build as Failed 
Generates report 
Stores screenshots 
Stores videos 
Stores trace 
Sends notifications 

## 27. How do you send email after execution?
Post section:
post {
    always {
        mail to: 'team@example.com',
             subject: 'Playwright Report',
             body: 'Execution Completed'
    }
}

## 28. How do you parallelize Playwright tests in Jenkins?
Playwright configuration:
workers: 4
Or:
npx playwright test --workers=4

## 29. How do you run specific browsers?
npx playwright test --project=chromium
or
npx playwright test --project=firefox

## 30. Explain a Jenkins Pipeline for Playwright.
Example:
pipeline {
    agent any

    stages {

        stage('Checkout'){
            steps{
                git 'https://github.com/user/playwright-project.git'
            }
        }

        stage('Install'){
            steps{
                sh 'npm ci'
                sh 'npx playwright install'
            }
        }

        stage('Run Tests'){
            steps{
                sh 'npx playwright test'
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: 'playwright-report/**'
            junit 'test-results/*.xml'
        }
    }
}

## 1. A Jenkins build passes locally but fails on the CI server. How would you investigate?
Answer
First, I would compare the local and Jenkins environments to identify differences.
My troubleshooting steps would be:
1.Check the Jenkins console logs for the exact error. 
2.Verify the Node.js and Playwright versions are the same locally and in Jenkins. 
3.Ensure all dependencies are installed using npm ci. 
4.Verify Playwright browsers are installed:
npx playwright install
5.Check whether environment variables (URLs, credentials, API keys) are configured correctly. 
6.Ensure the Jenkins agent has the required permissions. 
7.Review screenshots, videos, traces, and HTML reports generated by Playwright. 
8.Re-run the failed test with tracing enabled:
npx playwright test --trace on
9.If the failure is due to timing, improve synchronization using Playwright's auto-waiting or explicit waits instead of fixed timeouts. 
Interview Tip:
Mention that CI environments are usually slower than local machines, so flaky tests often appear there first.

## 2. How would you execute smoke tests after every commit and regression tests nightly?
Answer
I would create two Jenkins jobs (or two pipeline stages).
Smoke Pipeline
Trigger
GitHub Webhook 
Command
npx playwright test --grep @smoke
Runs after every code commit.

Regression Pipeline
Trigger
Cron Scheduler
0 1 * * *
Runs every day at 1 AM.
Command
npx playwright test
This strategy gives fast feedback for every commit while ensuring complete regression coverage overnight.

## 3. How would you parameterize a Jenkins job to run against QA, UAT, or Production?
Answer
I would create a Jenkins Choice Parameter.
Parameter:
Environment

QA
UAT
PROD
Pipeline:
parameters {
    choice(
        name: 'ENV',
        choices: ['QA','UAT','PROD']
    )
}
Run command:
ENV=$ENV npx playwright test
Playwright configuration:
const env = process.env.ENV;

const urls = {
    QA: "https://qa.company.com",
    UAT: "https://uat.company.com",
    PROD: "https://company.com"
};

export default defineConfig({
    use: {
        baseURL: urls[env]
    }
});
This allows the same automation suite to run against multiple environments without changing the code.

## 4. How do you securely manage usernames, passwords, and API tokens in Jenkins?
Answer
Sensitive information should never be hardcoded.
Instead, I would:
Store credentials in Jenkins Credentials Manager. 
Reference them inside the Jenkins Pipeline. 
Pass them as environment variables. 
Example:
environment {
    USERNAME = credentials('login-user')
}
Playwright:
process.env.USERNAME
This approach keeps credentials encrypted and prevents exposure in source code.

## 5. How would you configure Jenkins to run Playwright tests in parallel across multiple browsers?
Answer
Playwright supports parallel execution using projects and workers.
Example configuration:
projects: [
    { name: 'chromium' },
    { name: 'firefox' },
    { name: 'webkit' }
]
Run command:
npx playwright test
Or specify workers:
npx playwright test --workers=4
Jenkins allocates CPU resources, while Playwright executes tests in parallel, reducing execution time significantly.

## 6. How do you publish Playwright HTML reports and JUnit reports after every execution?
Answer
After execution:
npx playwright test
Playwright generates:
playwright-report/

test-results/
Pipeline:
post {
    always {
        archiveArtifacts artifacts: 'playwright-report/**'

        junit 'test-results/*.xml'
    }
}
Install the HTML Publisher Plugin to publish:
playwright-report/index.html
Even if tests fail, reports are still available for debugging.

## 7. What steps would you take if npx playwright install fails on the Jenkins agent?
Answer
I would investigate in the following order:
Verify internet connectivity. 
Check firewall or proxy restrictions. 
Confirm Node.js is installed correctly. 
Verify disk space. 
Check user permissions. 
Re-run:
npx playwright install
On Linux, install required dependencies:
npx playwright install --with-deps
Review the Jenkins console log for detailed error messages. 

## 8. How do you clean the Jenkins workspace before or after each build?
Answer
Cleaning the workspace prevents leftover files from previous builds from affecting new executions.
Options:
Pipeline:
cleanWs()
Or:
deleteDir()
Freestyle Job:
Use Delete workspace before build starts.
Benefits:
Prevents stale reports 
Removes cached files 
Ensures consistent executions 

## 9. How do you trigger a Jenkins job automatically when code is pushed to GitHub?
Answer
I use a GitHub Webhook.
Process:
Developer
      ↓
Git Push
      ↓
GitHub Webhook
      ↓
Jenkins
      ↓
Run Pipeline
Configuration:
Enable GitHub hook trigger for GITScm polling in Jenkins. 
Add the Jenkins webhook URL in the GitHub repository settings. 
This provides immediate feedback after every commit.

## 10. What is the difference between npm install and npm ci, and which one is preferable in CI/CD?
Answer
npm install	npm ci
Installs dependencies and may update package-lock.json	Installs exactly what's in package-lock.json
Slower	Faster
Used for local development	Used in CI/CD pipelines
Can introduce version differences	Produces consistent builds
Allows dependency changes	Removes node_modules and performs a clean install
Interview Answer:
In Jenkins or any CI/CD pipeline, I prefer npm ci because it performs a clean, deterministic installation based on the package-lock.json file. This ensures every build uses the exact same dependency versions, making test execution more reliable and reproducible.

⭐ Bonus Scenario Questions Frequently Asked
## 11. One Playwright test is flaky in Jenkins but passes on rerun. What would you do?
Answer:
Analyze Playwright traces and screenshots. 
Replace hard waits (waitForTimeout()) with proper locators and assertions. 
Ensure elements are stable before interacting. 
Investigate backend or network delays. 
Retry only if the test is genuinely flaky while working to fix the root cause. 

## 12. Your Jenkins pipeline suddenly starts failing after a new dependency is added. How would you troubleshoot?
Answer:
Review the dependency changes in package.json. 
Run npm ci locally to reproduce the issue. 
Check for version conflicts. 
Verify compatibility with the Node.js version used by Jenkins. 
Review the Jenkins console logs and, if necessary, revert the change to confirm the root cause. 

## 13. How would you reduce Playwright execution time in Jenkins?
Answer:
Run tests in parallel using multiple workers. 
Split smoke and regression suites. 
Execute tests across multiple browsers simultaneously using Playwright projects. 
Reuse authenticated sessions with storageState. 
Run tests on multiple Jenkins agents if available. 
Execute only impacted tests where feasible. 

## 14. A test passes locally but fails only in headless mode. What would you do?
Answer:
Compare headed and headless execution using Playwright traces and screenshots. 
Check for timing or animation issues. 
Ensure the viewport and browser settings are consistent. 
Verify that elements are visible and actionable before interacting with them. 
Avoid relying on visual timing differences between headed and headless modes. 

## Interview Tip
When answering scenario-based questions, use a structured approach:
1.Identify the problem – Explain what you're investigating. 
2.Analyze the logs and evidence – Jenkins console output, Playwright traces, screenshots, reports. 
3.Determine the root cause – Environment, dependencies, synchronization, configuration, or infrastructure. 
4.Implement the fix and verify – Describe the corrective action and how you'd confirm it resolved the issue.  
This problem-solving approach demonstrates practical experience and is often valued more than simply memorizing commands.
