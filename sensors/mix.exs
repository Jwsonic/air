defmodule AirSensors.MixProject do
  use Mix.Project

  def project do
    [
      app: :air_sensors,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      erlc_paths: ["src", "gen"],
      compilers: [:gleam | Mix.compilers()]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {AirSensors.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:mix_gleam, "~> 0.1.0"},
      {:gleam_stdlib, "~> 0.11.0"},
      {:circuits_uart, "~> 1.3"}
    ]
  end
end
