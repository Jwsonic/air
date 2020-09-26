defmodule AirFirmwareTest do
  use ExUnit.Case
  doctest AirFirmware

  test "greets the world" do
    assert AirFirmware.hello() == :world
  end
end
