# Use Jenkins JNLP agent as the base image for copying Jenkins agent files
FROM jenkins/inbound-agent:4.11-1 as jnlp

# Use the Python image based on Ubuntu as the base image
FROM python:3.9

# Install OpenJDK 11 JRE on the Python image based on Ubuntu
RUN apt-get update && \
    apt-get install -y --no-install-recommends openjdk-11-jre && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy Jenkins agent files from the JNLP agent image
COPY --from=jnlp /usr/local/bin/jenkins-agent /usr/local/bin/jenkins-agent
COPY --from=jnlp /usr/share/jenkins/agent.jar /usr/share/jenkins/agent.jar

# Install additional packages
RUN set -ex && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends git && \  # Installing Git
    apt-get install -y \
        python3 \
        python3-pip \
        python3-venv \
        unixodbc-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Docker on the Ubuntu-based image
RUN apt-get update && apt-get install -y docker.io  # Installing Docker

# Set the entry point to run the Jenkins agent
ENTRYPOINT ["/usr/local/bin/jenkins-agent"]
