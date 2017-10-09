FROM python:3

RUN apt-get update && apt-get -y install git-core mongodb-org-server

WORKDIR /usr/src/app

COPY . .

RUN make install
	
CMD bash start_grading.sh