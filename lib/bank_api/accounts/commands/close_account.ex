defmodule BankAPI.Accounts.Commands.CloseAccount do
  @enforce_keys [:account_uuid]

  defstruct [:account_uuid]

  alias BankAPI.Accounts

  def valid?(command) do
    Skooma.valid?(Map.from_struct(command), schema())
  end

  defp schema do
    %{
      account_uuid: [:string, Skooma.Validators.regex(Accounts.uuid_regex())]
    }
  end
end
