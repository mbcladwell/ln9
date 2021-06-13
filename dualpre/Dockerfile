# Use the official image as a parent image.
FROM postgres:12.4
ENV POSTGRES_USER ln_admin
ENV POSTGRES_PASSWORD welcome
ENV POSTGRES_DB lndb

ENV dummy jkj
# Set the working directory.
WORKDIR /usr/src/app
ARG egdata=0
# Copy the file from your host to your current location.

COPY initdb.sql /docker-entrypoint-initdb.d/a.sql
COPY create-db.sql /docker-entrypoint-initdb.d/b.sql
COPY example-data.sql /docker-entrypoint-initdb.d/c.sql


# Add metadata to the image to describe which port the container is listening on at runtime.
EXPOSE 5432


### https://stackoverflow.com/questions/26598738/how-to-create-user-database-in-script-for-docker-postgres
### https://stackoverflow.com/questions/37836764/run-command-in-docker-container-only-on-the-first-start
# docker build . --tag labsolns/ln-srv


# docker run -it --name=ln1 limsn /bin/bash
# docker exec -it ln1 /bin/bash -c /ln-init.sh

# mbc@HP8300:~$ su
# Password: 
# root@HP8300:/home/mbc# mkdir /sys/fs/cgroup/systemd
# root@HP8300:/home/mbc# mount -t cgroup -o none,name=systemd cgroup /sys/fs/cgroup/systemd
# root@HP8300:/home/mbc# exit
# docker run --rm --network ln-net --gateway -p 6543:5432 -v $HOME/docker/volumes/lnsrv:/var/lib/postgresql/data labsolns/ln-srv
