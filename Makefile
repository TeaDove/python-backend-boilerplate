PYTHON ?= .venv/bin/python

backend-install:
	cd backend && python3.11 -m venv .venv
	cd backend && $(PYTHON) -m pip install poetry
	cd backend && $(PYTHON) -m poetry update

backend-run:
	cd backend && $(PYTHON) web_entrypoint.py

backend-docker-exec:
	docker compose exec backend_web /bin/bash

lint:
	pre-commit run -a

infra-run:
	docker compose -f docker-compose-infra.yaml up -d

update:
	git pull
	docker compose up -d --build
	docker compose logs -f backend_web

logs:
	docker compose logs -f backend_web
