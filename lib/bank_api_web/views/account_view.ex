defmodule BankAPIWeb.AccountView do
  use BankAPIWeb, :view
  alias BankAPIWeb.AccountView

  alias BankAPI.Accounts.Projections.Account

  def render("show.json", %{account: account}) do
    %{data: render_one(account, AccountView, "account.json")}
  end

  def render("account.json", %{account: account}) do
    if account.status == Account.status().closed do
      %{
        uuid: account.uuid,
        current_balance: account.current_balance
      }
    else
      %{
        uuid: account.uuid,
        current_balance: account.current_balance,
        status: account.status
      }
    end
  end
end
