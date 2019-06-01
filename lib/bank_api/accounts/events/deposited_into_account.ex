defmodule BankAPI.Accounts.Events.DepositedIntoAccount do
  @derive [Jason.Encoder]

  defstruct [
    :account_uuid,
    :new_current_balance,
    :transfer_uuid
  ]
end
