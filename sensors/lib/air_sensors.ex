defmodule AirSensors do
  @moduledoc """
  Documentation for `AirSensors`.
  """

  def script do
    :air_sensors |> :code.priv_dir() |> Path.join("pm2.py")
  end

  def pm2(serial) do
    System.cmd("python3", [AirSensors.script(), serial], stderr_to_stdout: true)
  end
end
