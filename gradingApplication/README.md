# Grading Tool Overview
Scripts for installing and running student projects on a Raspberry Pi and Docker

## Docker Info
To build and run docker containers you need a hypervisor (HyperV, Virtualbox, etc) and Docker itself. The Docker Toolbox can install these.

This project contains a Dockerfile to spin up a grading container for testing. Container based on the default pyhton container.
Add your credential files to the `projects` folder in a subfolder named after your project, and edit `projects_config.conf` to configure your project name. Edit `user_config.conf` to configure your last name (used by the grading script). Save the files and use `docker build -t grader .` to build the container. Start the container to grade.

## TODO
-A web ui could be added to configure projects and display the grades outside of the container console. This may be added in a future release.

-Mongo DB and the project python code is running locally in the container which is bad container design. Ideally mongo, the grading tool, and the project container should be split. Kubernetes or a docker recipe is needed to resolve this, minikube may be added in a future release.
