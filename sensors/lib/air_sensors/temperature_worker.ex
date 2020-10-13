defmodule AirSensors.TemperatureWorker do
  use GenServer

  require Logger

  alias AirSensors.{Repo, Temp}

  def start_link(args) do
    GenServer.start_link(__MODULE__, args, name: __MODULE__)
  end

  def init(_args) do
    schedule()

    {:ok, :nostate}
  end

  @pin 4

  def handle_info(:temp, state) do
    case DHT.read(@pin, :dht22) do
      {:ok, %{humidity: humidity, temperature: temperature}} ->
        %Temp{humidity: humidity, temperature: temperature}
        |> Repo.insert()
        |> inspect()
        |> Logger.info()

      error ->
        error |> inspect() |> Logger.error()
    end

    schedule()

    {:noreply, state}
  end

  @interval 60_000

  defp schedule do
    Process.send_after(self(), :temp, @interval)
  end
end
