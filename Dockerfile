FROM python:3

RUN echo "deb http://repo.mongodb.org/apt/debian jessie/mongodb-org/3.4 main" | tee /etc/apt/sources.list.d/mongodb-org-3.4.list
RUN apt-get update && apt-get -y --force-yes install git-core mongodb-org build-essential
RUN service mongodb stop

WORKDIR /usr/src/app

COPY . .

RUN chmod +x configureMongoDB.sh && configureMongoDB.sh

CMD bash start_grading.sh