defmodule AirDisplayTest do
  use ExUnit.Case
  doctest AirDisplay

  test "greets the world" do
    assert AirDisplay.hello() == :world
  end
end
