defmodule Sequence.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, initial_number) do
    children = [
      {Sequence.Stash, initial_number},
      {Sequence.Server, nil}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :rest_for_one, name: Sequence.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
