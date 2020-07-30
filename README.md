# Flask opinionated

## Tutorial

Follow [The Flask Mega-Tutorial Part I: Hello, World!](https://blog.miguelgrinberg.com/post/the-flask-mega-tutorial-part-i-hello-world)

## Pip requirements
Don't add packages to _requirements.txt_, instead add them to **requirements.in**.

`pip-tools` is used to manage requirements and it generates requirements.txt based on requirements.in

## Local Development

Application runs on port **12121**

For local development use `./develop_using.sh`.

Above script also formats and fixes code.

## Makefile
Makefile is used to run various tasks. Run `make` to get a list of tasks.

Currently supported tasks
```
venv:   Setup virtual environment
run:    Run flask app
debug:  Debug flask app
uwsgi:  Run flask app in uwsgi
test:   Run tests and fail if coverage is not met
format: Format and fix python code
lint:   Run static analysis with flake8, pylint, bandit and mypy
help:   List make tasks which are documented, doc string starts with #:

docker-run: Run app in docker
```

# Swagger
Open http://127.0.0.1:12121/flask-opinionated/api/v1/swagger
