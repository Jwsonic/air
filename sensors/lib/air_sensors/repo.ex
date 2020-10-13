defmodule AirSensors.Repo do
  use Ecto.Repo,
    otp_app: :air_sensors,
    adapter: Ecto.Adapters.Postgres
end
