#!/bin/sh

echo "listen_addresses = '*'
" >> /etc/postgresql/9.6/main/postgresql.conf
/etc/init.d/postgresql start
mv -f /opt/pg_hba.conf /etc/postgresql/9.6/main/
sleep 5
sudo -u postgres psql -c "ALTER USER postgres PASSWORD 'postgres';"
/etc/init.d/postgresql restart
