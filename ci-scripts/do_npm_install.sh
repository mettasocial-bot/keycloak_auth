#!/bin/bash
if [ -d ./node_modules ]
then
    echo "Skipping npm install as already got from gitlab ci cache"
else
    npm ci
fi