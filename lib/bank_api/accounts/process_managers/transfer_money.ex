defmodule BankAPI.Accounts.ProcessManagers.TransferMoney do
  use Commanded.ProcessManagers.ProcessManager,
    name: "Accounts.ProcessManagers.TransferMoney",
    router: BankAPI.Router

  @derive Jason.Encoder
  defstruct [
    :transfer_uuid,
    :source_account_uuid,
    :destination_account_uuid,
    :amount,
    :status
  ]

  alias __MODULE__

  alias BankAPI.Accounts.Events.{
    MoneyTransferRequested,
    WithdrawnFromAccount,
    DepositedIntoAccount
  }

  alias BankAPI.Accounts.Commands.{
    WithdrawFromAccount,
    DepositIntoAccount
  }

  def interested?(%MoneyTransferRequested{transfer_uuid: transfer_uuid}),
    do: {:start!, transfer_uuid}

  def interested?(%WithdrawnFromAccount{transfer_uuid: transfer_uuid})
      when is_nil(transfer_uuid),
      do: false

  def interested?(%WithdrawnFromAccount{transfer_uuid: transfer_uuid}),
    do: {:continue!, transfer_uuid}

  def interested?(%DepositedIntoAccount{transfer_uuid: transfer_uuid})
      when is_nil(transfer_uuid),
      do: false

  def interested?(%DepositedIntoAccount{transfer_uuid: transfer_uuid}),
    do: {:stop, transfer_uuid}

  def interested?(_event), do: false

  ###

  def handle(
        %TransferMoney{},
        %MoneyTransferRequested{
          source_account_uuid: source_account_uuid,
          amount: transfer_amount,
          transfer_uuid: transfer_uuid
        }
      ) do
    %WithdrawFromAccount{
      account_uuid: source_account_uuid,
      withdraw_amount: transfer_amount,
      transfer_uuid: transfer_uuid
    }
  end

  def handle(
        %TransferMoney{transfer_uuid: transfer_uuid} = pm,
        %WithdrawnFromAccount{transfer_uuid: transfer_uuid}
      ) do
    %DepositIntoAccount{
      account_uuid: pm.destination_account_uuid,
      deposit_amount: pm.amount,
      transfer_uuid: pm.transfer_uuid
    }
  end

  ###

  def apply(%TransferMoney{} = pm, %MoneyTransferRequested{} = evt) do
    %TransferMoney{
      pm
      | transfer_uuid: evt.transfer_uuid,
        source_account_uuid: evt.source_account_uuid,
        destination_account_uuid: evt.destination_account_uuid,
        amount: evt.amount,
        status: :withdraw_money_from_source_account
    }
  end

  def apply(%TransferMoney{} = pm, %WithdrawnFromAccount{}) do
    %TransferMoney{
      pm
      | status: :deposit_money_in_destination_account
    }
  end
end
