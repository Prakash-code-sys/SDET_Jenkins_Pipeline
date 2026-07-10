pipeline {

    agent any

    tools {
        nodejs 'Node26'
    }

    parameters {

        choice(
            name: 'BROWSER',
            choices: ['chromium','firefox','webkit'],
            description: 'Browser'
        )

        booleanParam(
            name: 'HEADLESS',
            defaultValue: true,
            description: 'Headless Execution'
        )

        string(
            name: 'WORKERS',
            defaultValue: '2',
            description: 'Workers'
        )

        choice(
            name: 'ENV',
            choices: ['QA','UAT','PROD'],
            description: 'Environment'
        )
    }

    stages {

        stage('Checkout') {

            steps {
                checkout scm
            }

        }

        stage('Install') {

            steps {

                bat 'npm ci'

                bat 'npx playwright install'

            }

        }

        stage('Copy .env') {

            steps {

                withCredentials([
                    file(credentialsId: 'playwright', variable: 'ENV_FILE')
                ]) {

                    bat 'copy "%ENV_FILE%" .env'

                }

            }

        }

        stage('Run Tests') {

            steps {

                

                    

                 

                    bat """
                    npx playwright test ^
                    --project=%BROWSER% ^
                    --workers=%WORKERS%
                    """

                

            }

        }

    }

   post {
    always {
        publishHTML(target: [
            allowMissing: false,
            alwaysLinkToLastBuild: true,
            keepAll: true,
            reportDir: 'playwright-report',
            reportFiles: 'index.html',
            reportName: 'Playwright Report'
        ])
    }
}
}