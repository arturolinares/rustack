CREATE user ~db_user~ WITH CREATEDB PASSWORD '~db_pass~';
CREATE DATABASE ~db_name~;
GRANT all privileges ON DATABASE ~db_name~ TO ~db_user~;
