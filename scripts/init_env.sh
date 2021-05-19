#!/bin/bash
set -x

# install dependencies
source $HOME/.nvm/nvm.sh
npm i -g yarn
yarn install
npm run build

$PWD/setup.sh

# setup the database
sudo $PWD/scripts/init_db.sh

if [ -d "$PWD/migrations" ]; then
  sqlx migrate run
fi