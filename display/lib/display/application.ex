defmodule Display.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      {Scenic, viewports: [Application.get_env(:display, :viewport)]}
    ]

    opts = [strategy: :one_for_one, name: Display.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
