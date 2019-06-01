defmodule BankAPI.Accounts.Projectors.AccountOpenedTest do
  use BankAPI.ProjectorCase, async: true

  alias BankAPI.Accounts.Projections.Account
  alias BankAPI.Accounts.Events.AccountOpened
  alias BankAPI.Accounts.Projectors.AccountOpened, as: Projector

  test "should succeed with valid data" do
    uuid = UUID.uuid4()

    account_opened_evt = %AccountOpened{
      account_uuid: uuid,
      initial_balance: 1_000
    }

    last_seen_event_number = get_last_seen_event_number("Accounts.Projectors.AccountOpened")

    assert :ok =
             Projector.handle(
               account_opened_evt,
               %{event_number: last_seen_event_number + 1}
             )

    assert only_instance_of(Account).current_balance == 1_000
    assert only_instance_of(Account).uuid == uuid
  end
end
