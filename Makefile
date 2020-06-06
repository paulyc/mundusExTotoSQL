_: demo

schema: drop
	mysql -u root -proot < sql/00001_schema.sql

functions: schema
	mysql -u root -proot -D extotosql < sql/functions.sql

demo: functions
	mysql -u root -proot -D extotosql < sql/demo.sql

drop:
	echo 'drop database extotosql' | mysql -u root -proot
.PHONY: drop
