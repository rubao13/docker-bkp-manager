#!/bin/bash

set -e

# This script fills a mongo database

MONGO_ROOT_USERNAME=admin
MONGO_ROOT_PASSWORD=s3cr3t
MONGO_HOST=mongo
MONGO_PORT=27017
MONGO_CONTAINER_NAME=devops_mongodb

function main(){
    docker exec -it $MONGO_CONTAINER_NAME mongosh \
        --port 27017  \
        --authenticationDatabase "admin" \
        -u "admin" \
        -p s3cr3t \
        --eval '
            db = db.getSiblingDB("ironmanmovies");
            db.goodJokes.insertMany([
                {"text":"Iron Man", "year": "2008"},
                {"text":"The Incredible Hulk", "year": "2008"},
                {"text":"Iron Man 2", "year": "2010"},
                {"text":"The Avengers", "year": "2012"},
                {"text":"Iron Man 3", "year": "2013"},
                {"text":"Avengers: Age of Ultron", "year": "2015"},
                {"text":"Captain America: Civil War", "year": "2016"},
                {"text":"Spider-Man: Homecoming", "year": "2017"},
                {"text":"Avengers: Infinity War", "year": "2018"},
                {"text":"Avengers: Endgame", "year": "2019"},
                ]);

            db = db.getSiblingDB("locations");
            db.cities.insertMany([
                {"city":"Paris", "country": "France"},
                {"city":"Tokyo", "country": "Japan"}
            ]);
            '
}

main
