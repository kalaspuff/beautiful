.PHONY: test version tests build dist release
ifndef VERBOSE
.SILENT:
endif

default:
	@echo "Usage:"
	@echo "- make test         | run tests"
	@echo "- make black        | run black -l 120"
	@echo "- make release      | upload dist and push tag"

pytest:
	PYTHONPATH=. poetry run pytest --cov-report term-missing --cov=beautiful tests/

flake8:
	poetry run flake8 beautiful/ tests/

mypy:
	poetry run mypy beautiful/

version:
	poetry version `python beautiful/__version__.py`

black:
	poetry run black -l 120 beautiful/ tests/

isort:
	poetry run isort -rc beautiful/ tests/

build:
	rm -rf dist/
	poetry build

release:
	make pytest
	make flake8
	make mypy
	make version
	make build
	poetry publish
	git add pyproject.toml beautiful/__version__.py
	git commit -m "Bumped version" --allow-empty
	git tag -a `python beautiful/__version__.py` -m `python beautiful/__version__.py`
	git push
	git push --tags

test: pytest flake8 mypy
tests: test
dist: build
lint: flake8 mypy
pylint: flake8 mypy
