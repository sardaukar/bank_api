#! /bin/bash
account_id=$(curl --silent --request POST --header "Content-Type: application/json" --data "{\"account\": {\"initial_balance\": 1000}}" http://localhost:4000/api/accounts | jq -r ".data.uuid")
echo "get: $(curl --silent --request GET http://localhost:4000/api/accounts/${account_id})"
deposit_response=$(curl --silent --request POST --header "Content-Type: application/json" --data "{\"deposit_amount\": 42}" http://localhost:4000/api/accounts/${account_id}/deposit)
echo "deposit: ${deposit_response}"
withdraw_response=$(curl --silent --request POST --header "Content-Type: application/json" --data "{\"withdrawal_amount\": 1042}" http://localhost:4000/api/accounts/${account_id}/withdraw)
echo "withdraw: ${withdraw_response}"
echo "delete: done! $(curl --silent --request DELETE http://localhost:4000/api/accounts/${account_id})"
