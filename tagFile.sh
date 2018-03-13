#!/bin/bash

git push origin --delete tag 1.0.0

git tag -d 1.0.0

git tag "1.0.0"

git push --tag
