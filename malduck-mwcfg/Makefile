.PHONY: mwcfg-server install test clean

PWD := $(shell pwd)
USER_ID := $(shell id -u ${USER})
GROUP_ID := $(shell id -g ${USER})
tag=22.04
version=1.0.0

# Installation targets
install:
	pip install -e .

install-dev:
	pip install -e ".[dev]"

# Testing targets
test:
	pytest tests/ -v

test-coverage:
	pytest tests/ --cov=malduck --cov=libmwcfg --cov-report=html --cov-report=term

# Docker server targets
mwcfg-server:
	@if [ -z "`docker images -q mwcfg-server:${version} 2> /dev/null`" ]; then \
		docker build \
			-t mwcfg-server:${version} \
			--build-arg tag=${tag} \
			-f docker/mwcfg-server.docker .; \
	else \
		echo "docker build for mwcfg-server:${version} already exists..."; \
	fi

mwcfg-server-start:
	@if [ -z "`docker ps | grep "mwcfg-server:${version}" | grep -Po '^[a-f0-9]+'`" ]; then \
		mkdir -p uploads/; \
		docker run \
			-d \
			--rm \
			-v ${PWD}/modules/:/mnt/modules/ \
			-v ${PWD}/uploads/:/mnt/uploads/ \
			-v ${PWD}/docker/etc/uwsgi/apps-enabled/:/etc/uwsgi/apps-enabled/ \
			-v ${PWD}/docker/etc/nginx/conf.d/:/etc/nginx/conf.d/ \
			-v ${PWD}/docker/etc/nginx/ssl/:/etc/nginx/ssl/ \
			-p 80:80 \
			-p 443:443 \
			-t mwcfg-server:${version} > /dev/null; \
		echo "mwcfg-server:${version} started"; \
	else \
		echo "mwcfg-server:${version} is already running"; \
	fi

mwcfg-server-stop:
	@ID=`docker ps | grep "mwcfg-server:${version}" | grep -Po '^[a-f0-9]+'`; \
		if [ ! -z "$${ID}" ]; then \
			docker stop $${ID} > /dev/null; \
			echo "mwcfg-server:${version} stopped"; \
		else \
			echo "mwcfg-server:${version} is not running"; \
		fi

mwcfg-server-restart: mwcfg-server-stop mwcfg-server-start

mwcfg-server-status:
	@if [ -z "`docker ps | grep "mwcfg-server:${version}" | grep -Po '^[a-f0-9]+'`" ]; then \
		echo "mwcfg-server:${version} is not running"; \
	else \
		echo "mwcfg-server:${version} is running"; \
	fi

mwcfg-server-clean:
	@docker rmi --force `docker images | grep mwcfg-server | grep ${version} | tr -s ' ' | cut -d ' ' -f 3`

mwcfg-server-logs:
	@docker logs -f `docker ps | grep "mwcfg-server:${version}" | grep -Po '^[a-f0-9]+'`

# Docker cleanup
docker-clean:
	@docker stop $(shell docker ps -a -q) 2>/dev/null || echo > /dev/null
	@docker rm $(shell docker ps -a -q) 2>/dev/null || echo > /dev/null
	@docker rmi $(shell docker images -a -q) 2>/dev/null || echo > /dev/null

# Documentation
docs:
	cd docs && make html

docs-serve:
	cd docs/_build/html && python -m http.server 8000

# Cleanup
clean:
	find . -type f -name '*.pyc' -delete
	find . -type d -name '__pycache__' -delete
	find . -type d -name '*.egg-info' -exec rm -rf {} +
	rm -rf build/ dist/ .pytest_cache/ .coverage htmlcov/

# Development helpers
format:
	black malduck/ libmwcfg/ tests/
	isort malduck/ libmwcfg/ tests/

lint:
	flake8 malduck/ libmwcfg/
	mypy malduck/

# Module management
list-modules:
	@echo "Available extraction modules:"
	@find modules/ -mindepth 1 -maxdepth 1 -type d -exec basename {} \;

# Help
help:
	@echo "Malduck-MWCFG Makefile Commands:"
	@echo ""
	@echo "Installation:"
	@echo "  make install          - Install package"
	@echo "  make install-dev      - Install with development dependencies"
	@echo ""
	@echo "Testing:"
	@echo "  make test             - Run tests"
	@echo "  make test-coverage    - Run tests with coverage report"
	@echo ""
	@echo "MWCFG Server (Docker):"
	@echo "  make mwcfg-server        - Build server image"
	@echo "  make mwcfg-server-start  - Start server"
	@echo "  make mwcfg-server-stop   - Stop server"
	@echo "  make mwcfg-server-restart- Restart server"
	@echo "  make mwcfg-server-status - Check server status"
	@echo "  make mwcfg-server-logs   - View server logs"
	@echo "  make mwcfg-server-clean  - Remove server image"
	@echo ""
	@echo "Documentation:"
	@echo "  make docs             - Build documentation"
	@echo "  make docs-serve       - Serve documentation locally"
	@echo ""
	@echo "Development:"
	@echo "  make format           - Format code with black and isort"
	@echo "  make lint             - Run linters"
	@echo "  make list-modules     - List available extraction modules"
	@echo "  make clean            - Clean build artifacts"
	@echo ""
	@echo "Docker:"
	@echo "  make docker-clean     - Remove all Docker containers and images"
