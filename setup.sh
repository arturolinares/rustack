#!/bin/bash
if [ -f .initialized ]; then
  echo "Project already configured."
  exit 0
fi

echo "---"
echo "Rustack setup script"
echo "---"
echo

line_db_url=2
line_secret=7

read -p 'Project name (snake_case): ' project_name
read -p 'Author name: ' author
read -p 'Author email: ' email
read -p 'Database name: ' db_name
read -p 'DB user: ' db_user
read -sp 'DB pass: ' db_pass
echo
read -p 'Create postgres user with provided data? (y/n) ' -n 1 create_user
echo

# Generate .env
echo "DATABASE_URL=postgres://$db_user:$db_pass@localhost/$db_name" > .env
echo -e "APP_DEBUG=1\nRUN_MODE=development\nRUST_LOG=debug" >> .env
echo "Generated dot env file."

# Generate development.toml

# DB url
db_url="url = \"postgres://$db_user:$db_pass@localhost/$db_name\""
sed "${line_db_url}s,.*,$db_url," conf/default.toml > conf/development.toml
sed -i "s/~db_user~/$db_user/g" scripts/init.sql
sed -i "s/~db_pass~/$db_pass/g" scripts/init.sql
sed -i "s/~db_name~/$db_name/g" scripts/init.sql

# Secret used to store session.
secret=$(tr -dc 'A-Za-z0-9' </dev/urandom | head -c 48 ; echo)

secret_str="secret = \"$secret\""

sed -i "${line_secret}s/.*/$secret_str/" conf/development.toml

find src -type f -name '*.rs' -exec sed -i "s/rustack/$project_name/g" {} \;

for x in {Cargo.toml,package.json}; do
	sed -i "s/rustack/$project_name/g" $x
	sed -i "s/~author~/$author <$email>/g" $x
done

touch .initialized