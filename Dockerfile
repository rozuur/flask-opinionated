# Multistage docker is not required as only requirements are installed
FROM tiangolo/uwsgi-nginx-flask:python3.8 AS compile-image

ENV UWSGI_INI=/app/uwsgi.ini
ENV LISTEN_PORT=12121

# Enable saner defaults for pip in docker
ENV PIP_DISABLE_PIP_VERSION_CHECK=1
ENV PIP_NO_CACHE_DIR=1

# Set the working directory to /app
WORKDIR /app

# First install requirements as they can be cached in docker layer
COPY tools/requirements.txt tools/requirements.txt
RUN pip install -r tools/requirements.txt

# Copy the current directory contents into the container at /app
COPY . $WORKDIR
