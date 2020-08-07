# Multistage docker is not required as only requirements are installed
FROM tiangolo/uwsgi-nginx-flask:python3.8

ENV UWSGI_INI=/app/uwsgi.ini
ENV LISTEN_PORT=12121

# Disable nagging pip upgrade warning
ENV PIP_DISABLE_PIP_VERSION_CHECK=1
# Don't cache for docker images
ENV PIP_NO_CACHE_DIR=1
# Prevents Python from buffering stdout and stderr
ENV PYTHONUNBUFFERED=1

# First install requirements as they can be cached in docker layer
COPY tools/requirements.txt requirements.txt
RUN pip install -r requirements.txt

# Set the working directory to /app
WORKDIR /app
# Copy the current directory contents into the container at /app
COPY . $WORKDIR
