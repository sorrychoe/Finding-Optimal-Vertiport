.PHONY: init format lint clean

NAME = ML Team 4

SHELL := bash
python = python3

ifeq ($(OS),Windows_NT)
	python := python
endif

ifdef user
	pip_user_option = --user
endif

init:
	$(python) -m pip install $(pip_user_option) --upgrade pip
	$(python) -m pip install $(pip_user_option) --upgrade 'build>=0.7' 'setuptools>=61.0,<64.0' 'wheel>=0.37'
	$(python) -m pip install $(pip_user_option) -r requirements.txt
	$(python) -m pre_commit install

format:
	@echo "formatting notebooks..."
	$(python) -m nbqa black --config=pyproject.toml notebook
	$(python) -m nbqa isort --settings-file=isort.cfg notebook

lint:
	@echo "Linting notebooks..."
	$(python) -m nbqa flake8 --config=.flake8 notebook

clean:
	shopt -s globstar ; \
	rm -fr **/.ipynb_checkpoints **/.mypy_cache **/__pycache__ ;
