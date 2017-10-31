FROM python:3

#i didn't want to put mongo here, but i don't want to setup docker compose or k8 yet
#git is used to pull student code down
#build-tools is used for make file functionality
RUN echo "deb http://repo.mongodb.org/apt/debian jessie/mongodb-org/3.4 main" | tee /etc/apt/sources.list.d/mongodb-org-3.4.list
RUN apt-get update && apt-get -y --force-yes install git-core mongodb-org build-essential

#setup python requirements
COPY gradingApplication/requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

#needed for mongo
RUN mkdir -p /data/db

#setup grader app & mongo
WORKDIR /usr/src/app

COPY gradingApplication/. .

#setup mongo
RUN chmod +x configureMongoDB.sh
RUN bash configureMongoDB.sh

#Lots of projects have sh not bash and source breaks
RUN ln -sf bash /bin/sh

#go
CMD bash start_grading.sh