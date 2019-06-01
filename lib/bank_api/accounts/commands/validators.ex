defmodule BankAPI.Accounts.Commands.Validators do
  def positive_integer(data, minimum \\ 0) do
    if is_integer(data) do
      if data > minimum do
        :ok
      else
        {:error, "Argument must be bigger than #{minimum}"}
      end
    else
      {:error, "Argument must be an integer"}
    end
  end
end
