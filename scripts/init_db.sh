#!/bin/bash
## Run as root!
## Starts the database server and creates the first database and sets the user password.

set -x

/etc/init.d/postgresql start
sudo -u postgres psql -f $PWD/scripts/init.sql template1
