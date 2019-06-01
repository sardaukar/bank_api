defmodule BankAPI.Accounts.Commands.OpenAccount do
  @enforce_keys [:account_uuid]

  defstruct [:account_uuid, :initial_balance]

  alias BankAPI.Accounts
  alias BankAPI.Accounts.Commands.Validators

  def valid?(command) do
    Skooma.valid?(Map.from_struct(command), schema())
  end

  defp schema do
    %{
      account_uuid: [:string, Skooma.Validators.regex(Accounts.uuid_regex())],
      initial_balance: [:int, &Validators.positive_integer(&1)]
    }
  end
end
