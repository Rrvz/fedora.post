#!/usr/bin/env bash
# https://docs.pipenv.org/basics/#general-recommendations-version-control

mkdir new-project && cd new-project
pipenv --three
pipenv install requests
pipenv lock
pipenv graph
