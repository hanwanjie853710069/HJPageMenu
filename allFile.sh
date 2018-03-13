#!/bin/bash

git add --all

git commit -m "提交代码"

echo "请选择要提价的分支"

echo "1 - master"

echo "2 - develop"

read describe

tempbarch="develop"

if [ $describe == 1 ]
then
tempbarch="master"
fi

git pull origin $tempbarch

git push origin $tempbarch

git push origin --delete tag 1.0.0

git tag -d 1.0.0

git tag "1.0.0"

git push --tag

pod spec lint HJPageMenu.podspec --verbose --allow-warnings