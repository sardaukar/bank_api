defmodule BankAPI.Accounts.Events.AccountOpened do
  @derive [Jason.Encoder]

  defstruct [
    :account_uuid,
    :initial_balance
  ]
end
