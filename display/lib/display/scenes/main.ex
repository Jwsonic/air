defmodule Display.Scenes.Main do
  use Scenic.Scene

  def init(_scene_args, options) do
    graph = :scenes@main.init(options)

    {:ok, graph, push: graph}
  end
end
