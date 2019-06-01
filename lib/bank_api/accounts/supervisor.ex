defmodule BankAPI.Accounts.Supervisor do
  use Supervisor

  alias BankAPI.Accounts.Projectors
  alias BankAPI.Accounts.ProcessManagers

  def start_link do
    Supervisor.start_link(__MODULE__, nil)
  end

  def init(_arg) do
    children = [
      # Projectors
      worker(Projectors.AccountOpened, [], id: :account_opened),
      worker(Projectors.AccountClosed, [], id: :account_closed),
      worker(Projectors.DepositsAndWithdrawals, [], id: :deposits_and_withdrawals),

      # Process managers
      worker(ProcessManagers.TransferMoney, [], id: :transfer_money)
    ]

    supervise(children, strategy: :one_for_one)
  end
end
