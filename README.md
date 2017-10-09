# grading
Scripts for installing and running student projects on a Raspberry Pi

Contains a Dockerfile to spin up a grading container for testing.
Add your credential files to the `projects` folder and edit `user_config.conf` to configure your projects.
Mongo DB and the project python code is running locally in the container which is bad container design. Kubernetes is needed to resolve this, minikube may be added in a future release.
