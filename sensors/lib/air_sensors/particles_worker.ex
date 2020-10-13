defmodule AirSensors.ParticleWorker do
  use GenServer

  require Logger

  def start_link(args) do
    GenServer.start_link(__MODULE__, args, name: __MODULE__)
  end

  @name "ttyAMA0"
  @speed 9600

  def init(_args) do
    {:ok, pid} = Circuits.UART.start_link()

    :ok = Circuits.UART.open(pid, @name, speed: @speed, active: false)

    schedule()

    {:ok, pid}
  end

  def handle_info(:particles, pid) do
    {:ok, data} = Circuits.UART.read(pid)

    data |> Base.encode16() |> parse()

    schedule()

    {:noreply, pid}
  end

  @interval 60_000

  defp schedule do
    Process.send_after(self(), :particles, @interval)
  end

  defp parse(<<
        66,
        77,
        _fr_len::big-integer-size(16),
        pm1::big-integer-size(16),
        data2::big-integer-size(16),
        data3::big-integer-size(16),
        data4::big-integer-size(16),
        pm25::big-integer-size(16),
        data6::big-integer-size(16),
        data7::big-integer-size(16),
        data8::big-integer-size(16),
        data9::big-integer-size(16),
        data10::big-integer-size(16),
        data11::big-integer-size(16),
        data12::big-integer-size(16),
        _reserved::big-integer-size(16),
        _check_code::big-integer-size(16),
        _rest::binary
      >>) do
    Logger.info("pm 1.0 cf: #{pm1} ug/m^3")
    Logger.info("pm 2.5 atmospheric: #{pm25} ug/m^3")
  end

  defp parse(_data) do
    Logger.warn("Invalid frame")
  end
end
