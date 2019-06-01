defmodule BankAPI.Repo do
  use Ecto.Repo,
    otp_app: :bank_api,
    adapter: Ecto.Adapters.Postgres
end
