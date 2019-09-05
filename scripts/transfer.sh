#! /bin/bash
from_id=$(curl --silent --request POST --header "Content-Type: application/json" --data "{\"account\": {\"initial_balance\": 42}}" http://localhost:4000/api/accounts | jq -r ".data.uuid")
to_id=$(curl --silent --request POST --header "Content-Type: application/json" --data "{\"account\": {\"initial_balance\": 73}}" http://localhost:4000/api/accounts | jq -r ".data.uuid")
echo "get(from): $(curl --silent --request GET http://localhost:4000/api/accounts/${from_id})"
echo "get(to): $(curl --silent --request GET http://localhost:4000/api/accounts/${to_id})"
transfer_response=$(curl --silent --request POST --header "Content-Type: application/json" --data "{\"transfer_amount\": 42, \"destination_account\": \"${to_id}\"}" http://localhost:4000/api/accounts/${from_id}/transfer)
echo "transfer: done! ${transfer_response}"
echo "get(from): $(curl --silent --request GET http://localhost:4000/api/accounts/${from_id})"
echo "get(to): $(curl --silent --request GET http://localhost:4000/api/accounts/${to_id})"
echo "delete(from): done! $(curl --silent --request DELETE http://localhost:4000/api/accounts/${from_id})"
echo "delete(to): done! $(curl --silent --request DELETE http://localhost:4000/api/accounts/${to_id})"
