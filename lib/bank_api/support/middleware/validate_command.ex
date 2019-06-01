defmodule BankAPI.Middleware.ValidateCommand do
  @behaviour Commanded.Middleware

  alias Commanded.Middleware.Pipeline

  def before_dispatch(%Pipeline{command: command} = pipeline) do
    case command.__struct__.valid?(command) do
      :ok ->
        pipeline

      {:error, messages} ->
        pipeline
        |> Pipeline.respond({:error, :command_validation_failure, command, messages})
        |> Pipeline.halt()
    end
  end

  def after_dispatch(pipeline), do: pipeline
  def after_failure(pipeline), do: pipeline
end
