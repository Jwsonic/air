defmodule AirUi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      AirUiWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: AirUi.PubSub},
      # Start the Endpoint (http/https)
      AirUiWeb.Endpoint
      # Start a worker by calling: AirUi.Worker.start_link(arg)
      # {AirUi.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: AirUi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    AirUiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
