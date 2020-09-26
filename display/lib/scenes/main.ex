defmodule AirDisplay.Scenes.Main do
  use Scenic.Scene
  alias Scenic.Graph

  import Scenic.Primitives
  require Logger

  @day_sunny_path :code.priv_dir(:air_display) |> Path.join("wi-day-sunny.png")
  @day_sunny_hash Scenic.Cache.Hash.file!(@day_sunny_path, :sha)

  @x_start 145
  @y_start 150
  @width 100
  @height 100

  @graph Graph.build(font_size: 32, font: :roboto_mono, theme: :light, clear_color: :white)

  def init(_scene_args, _opts) do
    state = %{
      graph: @graph,
      count: 0
    }

    {:ok, state, push: @graph}
  end
end
