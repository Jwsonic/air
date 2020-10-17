defmodule AirSensors.ParticleWorker do
  use GenServer

  require Logger

  alias AirSensors.{Particle, Repo}

  def start_link(args) do
    GenServer.start_link(__MODULE__, args, name: __MODULE__)
  end

  def init(_args) do
    schedule()

    {:ok, :nostate}
  end

  def handle_info(:particles, state) do
    # There's some messy code right here. I know it, you know it, and my cat probably knows too.
    # This is a temporary mess to get things working like they used to before nerves. It will be fixed.
    with {data, 0} <- read_pm25(), {:ok, pm25} <- parse(data) do
      Logger.info("Got apm25: #{pm25}")

      %Particle{apm25: pm25}
      |> Repo.insert()
      |> inspect()
      |> Logger.info()
    else
      error -> error |> inspect() |> Logger.error()
    end

    schedule()

    {:noreply, state}
  end

  @interval 120_000

  defp schedule do
    Process.send_after(self(), :particles, @interval)
  end

  defp read_pm25 do
    script = :air_sensors |> :code.priv_dir() |> Path.join("pm2.py")

    System.cmd("python3", [script], stderr_to_stdout: true)
  end

  defp parse(data) do
    case Integer.parse(data) do
      {int, _rem} -> {:ok, int + 0.0}
      _ -> {:error, "Invalid int: #{inspect(data)}"}
    end
  end
end
