#! /bin/bash
account_id=$(curl --silent --request POST --header 'Content-Type: application/json' --data '{"account": {"initial_balance": 1000}}' http://localhost:4000/api/accounts | jq -r '.data.uuid')
echo "get: $(curl --silent --request GET http://localhost:4000/api/accounts/${account_id})"
echo "deposit: $(curl --silent --request POST --header 'Content-Type: application/json' --data '{"deposit_amount": 42}' http://localhost:4000/api/accounts/${account_id}/deposit)"
echo "withdraw: $(curl --silent --request POST --header 'Content-Type: application/json' --data '{"withdrawal_amount": 1042}' http://localhost:4000/api/accounts/${account_id}/withdraw)"
echo "delete: done! $(curl --silent --request DELETE http://localhost:4000/api/accounts/${account_id})"
