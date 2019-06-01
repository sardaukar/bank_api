defmodule BankAPI.Repo.Migrations.AddStatusToAccounts do
  use Ecto.Migration

  def change do
    alter table(:accounts) do
      add :status, :text
    end
  end
end
