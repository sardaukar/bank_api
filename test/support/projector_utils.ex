defmodule BankAPI.Test.ProjectorUtils do
  alias BankAPI.Repo
  import Ecto.Query, only: [from: 2]

  def truncate_database do
    truncate_readstore_tables_sql = """
    TRUNCATE TABLE
      accounts,
      projection_versions
    RESTART IDENTITY
    CASCADE;
    """

    {:ok, _result} = Repo.query(truncate_readstore_tables_sql)

    :ok
  end

  def get_last_seen_event_number(name) do
    from(
      p in "projection_versions",
      where: p.projection_name == ^name,
      select: p.last_seen_event_number
    )
    |> Repo.one() || 0
  end

  def only_instance_of(module) do
    module |> Repo.one()
  end
end
