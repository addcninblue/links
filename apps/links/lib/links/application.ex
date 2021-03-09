defmodule Links.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the PubSub system
      {Phoenix.PubSub, name: Links.PubSub},
      # Start a worker by calling: Links.Worker.start_link(arg)
      {Links.Worker, name: Links.Worker}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Links.Supervisor)
  end
end
