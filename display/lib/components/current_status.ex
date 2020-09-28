defmodule Display.Components.CurrentStatus do
  defmodule Status do
    defstruct data: nil, high: 0, last_updated: nil, low: 0, title: "", unit: ""
  end

  use Scenic.Component

  import Scenic.Primitives

  alias Display.Components.CurrentStatus.Status
  alias Scenic.Graph

  @doc false
  def info(data) do
    """
    #{IO.ANSI.red()}CurrentStatus data must be a valid Status
    #{IO.ANSI.yellow()}Received: #{inspect(data)}
    #{IO.ANSI.default_color()}
    """
  end

  # --------------------------------------------------------
  @doc false
  def verify(
        %Status{
          data: data,
          high: high,
          last_updated: %DateTime{},
          low: low,
          title: title,
          unit: unit
        } = status
      )
      when not is_nil(data) and
             is_binary(title) and bit_size(title) > 0 and
             is_binary(unit) and
             is_integer(high) and
             is_integer(low),
      do: {:ok, status}

  def verify(_), do: :invalid_data

  @graph Graph.build()
         |> text("", fill: :black, font_size: 15, id: :title)
         |> text("", fill: :black, font_size: 30, id: :data, translate: {0, 23})
         |> text("▲", fill: :black, font_size: 12, id: :high, translate: {30, 20})
         |> text("▼", fill: :black, font_size: 12, id: :low, translate: {30, 27})
         |> text("Last updated", fill: :black, font_size: 12, id: :timestamp, translate: {0, 35})

  def init(%Status{} = status, opts) do
    graph = update(@graph, status)

    state = %{
      graph: graph,
      status: status
    }

    {:ok, state, push: graph}
  end

  @height 38
  @width 64

  defp update(%Graph{} = graph, %Status{} = status) do
    graph
    |> update_title(status)
    |> update_data(status)
    |> update_timestamp(status)
  end

  defp update_title(%Graph{} = graph, %Status{title: title}) do
    Graph.modify(graph, :title, &text(&1, title))
  end

  defp update_data(%Graph{} = graph, %Status{data: data, unit: unit}) do
    Graph.modify(graph, :data, &text(&1, "#{inspect(data)}#{unit}"))
  end

  defp update_high(%Graph{} = graph, %Status{high: high}) do
    Graph.modify(graph, :data, &text(&1, "#{inspect(high)} ▲"))
  end

  defp update_low(%Graph{} = graph, %Status{low: low}) do
    Graph.modify(graph, :data, &text(&1, "#{inspect(low)} ▲"))
  end

  defp update_timestamp(%Graph{} = graph, %Status{
         last_updated: %DateTime{hour: hour, minute: minute}
       }) do
    {hour, ampm} =
      case hour do
        0 -> {12, "AM"}
        hour when hour > 12 -> {hour - 12, "PM"}
        _ -> {hour, "AM"}
      end

    [hour, minute] =
      [hour, minute] |> Enum.map(&to_string/1) |> Enum.map(&String.pad_leading(&1, 2, "0"))

    Graph.modify(graph, :timestamp, &text(&1, "Last updated #{hour}:#{minute}#{ampm}"))
  end
end
