defmodule BankAPI.Accounts.Events.MoneyTransferRequested do
  @derive [Jason.Encoder]

  defstruct [
    :transfer_uuid,
    :source_account_uuid,
    :destination_account_uuid,
    :amount
  ]
end
