FROM python:3

RUN apt-get update && apt-get -y install git-core mongodb-org build-essential

WORKDIR /usr/src/app

COPY . .

CMD bash start_grading.sh