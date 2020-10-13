import Config

config :air_sensors, AirSensors.Repo,
  database: System.get_env("PG_DB"),
  username: System.get_env("PG_HOST"),
  password: System.get_env("PG_USER"),
  hostname: System.get_env("PG_PASSWORD")

config :air_sensors, ecto_repos: [AirSensors.Repo]
