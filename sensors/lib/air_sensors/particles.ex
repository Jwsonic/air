defmodule AirSensors.Particle do
  use Ecto.Schema

  @primary_key false
  schema "particles" do
    field(:apm10, :float, default: 0.0)
    field(:apm25, :float, default: 0.0)
    field(:apm100, :float, default: 0.0)
    field(:pm10, :float, default: 0.0)
    field(:pm25, :float, default: 0.0)
    field(:pm100, :float, default: 0.0)
    field(:gt03um, :float, default: 0.0)
    field(:gt05um, :float, default: 0.0)
    field(:gt10um, :float, default: 0.0)
    field(:gt25um, :float, default: 0.0)
    field(:gt100um, :float, default: 0.0)
    field(:time, :naive_datetime)
  end
end
