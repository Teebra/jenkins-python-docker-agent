# jenkins-python-docker-agent (python version 3.8-buster and openjdk-11-jre)

# [DockerHub](https://hub.docker.com/r/teebro/jenkins-agent-docker-python/tags)
```
docker pull teebro/jenkins-agent-docker-python:v1
```

# jenkins pipeline (Test pipeline)

```
pipeline {
    agent {
        docker {
            image 'teebro/jenkins-agent-docker-python:v1'
            args '--user root -v /var/run/docker.sock:/var/run/docker.sock' // mount Docker socket to access the host's Docker daemon
        }
    }

    stages {
        stage('python') {
            steps {
                sh 'python --version'
                sh 'pip --version'
            }
        }

        stage('Run Docker Container') {
            steps {
                sh 'docker run hello-world'
            }
        }
    }
}
```
