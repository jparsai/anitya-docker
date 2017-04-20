#!/usr/bin/env groovy

node('docker') {

    def image = docker.image('slavek/anitya-server')
    def commitId

    stage('Checkout') {
        checkout scm
        commitId = sh(returnStdout: true, script: 'git rev-parse --short HEAD').trim()
    }

    stage('Build') {
        dockerCleanup()
        sh 'make clean'
        sh 'make'
        dir('openshift') {
            stash name: 'template', includes: 'template.yaml'
        }
    }

    if (env.BRANCH_NAME == 'master') {
        stage('Push Images') {
            docker.withRegistry('https://docker-registry.usersys.redhat.com/') {
                image.push('latest')
                image.push(commitId)
            }
            docker.withRegistry('https://registry.devshift.net/') {
                image.push('latest')
                image.push(commitId)
            }
        }
    }
}

if (env.BRANCH_NAME == 'master') {
    node('oc') {
        stage('Deploy - dev') {
            unstash 'template'
            sh 'oc --context=dev process -f template.yaml | oc --context=dev apply -f -'
        }

        stage('Deploy - rh-idev') {
            unstash 'template'
            sh 'oc --context=rh-idev process -f template.yaml | oc --context=rh-idev apply -f -'
        }
    }
}
