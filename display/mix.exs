defmodule AirDisplay.MixProject do
  use Mix.Project

  def project do
    [
      app: :air_display,
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
      mod: {AirDisplay.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:mix_gleam, "~> 0.1.0"},
      {:gleam_stdlib, "~> 0.11.0"},
      {:inky, "~> 1.0.1"},
      {:scenic, "~> 0.10.3", override: true},
      {:scenic_driver_inky, "~> 1.0.0", targets: :rpi0},
      {:scenic_driver_nerves_rpi, "~> 0.10", targets: :rpi0, override: true},
      {:scenic_driver_glfw, "~> 0.10.1", targets: :host}
    ]
  end
end
