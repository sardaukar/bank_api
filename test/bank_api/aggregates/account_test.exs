defmodule BankAPI.Aggregates.AgentTest do
  use BankAPI.Test.InMemoryEventStoreCase

  alias BankAPI.Accounts.Aggregates.Account, as: Aggregate
  alias BankAPI.Accounts.Events.AccountOpened
  alias BankAPI.Accounts.Commands.OpenAccount

  test "ensure agregate gets correct state on creation" do
    uuid = UUID.uuid4()

    account =
      %Aggregate{}
      |> evolve(%AccountOpened{
        initial_balance: 1_000,
        account_uuid: uuid
      })

    assert account.uuid == uuid
    assert account.current_balance == 1_000
  end

  test "errors out on invalid opening balance" do
    invalid_command = %OpenAccount{
      initial_balance: -1_000,
      account_uuid: UUID.uuid4()
    }

    assert {:error, :initial_balance_must_be_above_zero} =
             Aggregate.execute(%Aggregate{}, invalid_command)
  end

  test "errors out on already opened account" do
    command = %OpenAccount{
      initial_balance: 1_000,
      account_uuid: UUID.uuid4()
    }

    assert {:error, :account_already_opened} =
             Aggregate.execute(%Aggregate{uuid: UUID.uuid4()}, command)
  end
end
