#!/bin/bash

HOST=$1
PORT=$2

sed -i 's/static_url\:.*/static_url: [host: "'"$HOST"'", port: '"$PORT"'],/g' /opt/devspaces.exs
mv -f /opt/devspaces.exs /data/config/
echo "DevSpaces environment set up!
You can now run the application [mix do deps.get, compile, ecto.create, ecto.migrate, phx.server]."
