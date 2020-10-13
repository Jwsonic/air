defmodule AirSensors.Temp do
  use Ecto.Schema

  @primary_key false
  schema "readings" do
    field(:temperature, :float)
    field(:humidity, :float)
  end
end
