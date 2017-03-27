#!/bin/bash

echo 'start postgresql'
/etc/init.d/postgresql start 

su postgres
cd /usr/src/app
psql -f /usr/src/app/local_pop_script.sql

npm install
nodejs index.js
