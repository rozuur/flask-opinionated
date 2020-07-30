VENV_NAME?=.venv
VENV_BIN=$(VENV_NAME)/bin
APP_NAME=flask-opinionated
APP_DIR=app
TESTS_DIR=tests
PORT?=12121

.DEFAULT_GOAL := help

export PIP_DISABLE_PIP_VERSION_CHECK=1

venv: $(VENV_NAME)/bin/black #: Setup virtual environment
$(VENV_NAME)/bin/black: $(VENV_BIN)/pip-compile tools/requirements.in tools/dev-requirements.in
	$(VENV_BIN)/pip-compile -q tools/requirements.in
	$(VENV_BIN)/pip-compile -q tools/dev-requirements.in
	$(VENV_BIN)/pip-sync -q tools/requirements.txt tools/dev-requirements.txt
	touch $(VENV_NAME)/bin/black

$(VENV_BIN)/pip-compile: $(VENV_NAME)/bin/activate
	$(VENV_BIN)/pip install -q pip-tools
	touch $(VENV_BIN)/pip-compile

$(VENV_NAME)/bin/activate:
	test -d $(VENV_NAME) || tools/setup_virtualenv.sh $(VENV_NAME)
	touch $(VENV_NAME)/bin/activate

uwsgi: venv #: Run flask app in uwsgi
	$(VENV_BIN)/uwsgi --ini uwsgi.ini --http :$(PORT)

format: venv #: Format and fix python code
	$(VENV_BIN)/isort $(APP_DIR) $(TESTS_DIR)
	$(VENV_BIN)/black $(APP_DIR) $(TESTS_DIR)
	$(VENV_BIN)/autoflake --remove-all-unused-imports --remove-unused-variables \
		--remove-duplicate-keys --ignore-init-module-imports -i -r $(APP_DIR) $(TESTS_DIR)

check-flake8: venv
	$(VENV_BIN)/flake8 $(APP_DIR) $(TESTS_DIR)

check-bandit: venv
# -ll MEDIUM severity, iii HIGH confidence
	$(VENV_BIN)/bandit -ll -ii -r $(APP_DIR) --format=custom

lint: check-flake8 check-bandit #: Run static analysis with flake8 and bandit

.PHONY: docker-run
docker-run: #: Run app in docker
	@docker build -t $(APP_NAME) .
	@docker run --rm -it -p $(PORT):$(PORT) $(APP_NAME)

.PHONY: help
help: #: List make tasks which are documented, doc string starts with #:
	@grep -E '^[a-zA-Z0-9_-]+:.*?#: .*$$' $(MAKEFILE_LIST) \
	| cut -d: -f1,3-
