# Jenkins Slave with Docker client and `kubectl` CLI

Custom Jenkins JNLP slave for the [Kubernetes Plugin for Jenkins](github.com/jenkinsci/kubernetes-plugin) based on the [official JNLP agent image from Jenkins](https://github.com/jenkinsci/docker-jnlp-slave).

# How is this different?

Starting from the base image I added the Docker client in order to build any kind of project and `kubectl` to update the application on the cluster.
