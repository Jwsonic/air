import gleam/list
import scenic/graph.{Graph, GraphId}
import scenic/primative.{Opt}

pub type Point =
  tuple(Int, Int)

pub type Triangle =
  tuple(Point, Point, Point)

pub external fn add(graph: Graph, triangle: Triangle, opts: List(Opt)) -> Graph =
  "Elixir.Scenic.Primitives" "triangle"
