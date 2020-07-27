FROM tiangolo/uwsgi-nginx-flask:python3.8 AS compile-image

RUN pip install virtualenv
ENV VIRTUAL_ENV=/opt/venv
RUN mkdir -p $VIRTUAL_ENV && virtualenv $VIRTUAL_ENV
# Make sure we use the virtualenv:
ENV PATH=$VIRTUAL_ENV/bin:$PATH

COPY tools/requirements.txt .
RUN pip install -r requirements.txt

# ------------------------------------------------------------------------- #
FROM tiangolo/uwsgi-nginx-flask:python3.8

COPY --from=compile-image /opt/venv /opt/venv

ENV VIRTUAL_ENV=/opt/venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
ENV PYTHONPATH=".:$PYTHONPATH"
ENV UWSGI_INI /app/uwsgi.ini
ENV LISTEN_PORT 12121

COPY . /app
WORKDIR /app
