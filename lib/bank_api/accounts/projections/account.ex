defmodule BankAPI.Accounts.Projections.Account do
  use Ecto.Schema

  @primary_key {:uuid, :binary_id, autogenerate: false}

  schema "accounts" do
    field :current_balance, :integer
    field :status, :string

    timestamps()
  end

  def status do
    %{
      open: "open",
      closed: "closed"
    }
  end
end
