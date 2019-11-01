defmodule GDrive.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Starts a worker by calling: GDrive.Worker.start_link(arg)
      {GDrive.Worker, %{"test" => "http://drive.google.com/"}}
      # GDrive.Worker.start_link(%{})
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GDrive.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
