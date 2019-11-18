#! /bin/bash

MIX_ENV=test && mix ecto.drop && mix ecto.create && mix ecto.migrate
MIX_ENV=dev && mix ecto.drop && mix ecto.create && mix ecto.migrate
MIX_ENV=dev && mix event_store.drop && mix event_store.create && mix event_store.init
