defmodule Display.Scenes.Main do
  use Scenic.Scene
  alias Scenic.Graph

  import Scenic.Primitives
  require Logger

  alias Display.Components.CurrentStatus
  alias Display.Components.CurrentStatus.Status

  @width 400
  @height 300

  @x_offset 5
  @y_offset 10

  @y_top_row @y_offset + 5

  @init_temp %Status{
    data: 0,
    last_updated: DateTime.from_unix!(0),
    title: "TEMP",
    unit: "F"
  }

  @init_humidity %Status{
    data: 0,
    last_updated: DateTime.from_unix!(0),
    title: "HUMIDITY",
    unit: "%"
  }

  @init_aqi %Status{
    data: 0,
    last_updated: DateTime.from_unix!(0),
    title: "AQI",
    unit: ""
  }

  @graph Graph.build(font_size: 32, font: :roboto, clear_color: :white)
         |> rectangle({400, 300}, fill: :white)
         |> CurrentStatus.add_to_graph(
           @init_temp,
           id: :temp,
           translate: {@x_offset, @y_top_row}
         )
         |> CurrentStatus.add_to_graph(
           @init_humidity,
           id: :humidity,
           translate: {@x_offset + 140, @y_top_row}
         )
         |> CurrentStatus.add_to_graph(
           @init_aqi,
           id: :aqi,
           translate: {@x_offset + 280, @y_top_row}
         )
         |> line({{0, @y_offset + 50}, {@width, @y_offset + 50}}, stroke: {2, :black})

  def init(_scene_args, _opts) do
    state = %{
      graph: @graph
    }

    {:ok, state, push: @graph}
  end
end
