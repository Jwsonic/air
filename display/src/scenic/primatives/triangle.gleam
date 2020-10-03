import gleam/option.{None, Some}
import scenic/color.{Color}
import scenic/graph.{Graph, GraphId}

pub type Opts {
  Fill(Color)
  Id(GraphId)
}

pub type Point =
  tuple(Int, Int)

pub type Vertices =
  tuple(Point, Point, Point)

pub type Triangle {
  Triangle(vertices: Vertices, opts: List(Opts))
}

external fn external_triangle(
  graph: Graph,
  vertices: Vertices,
  opts: List(Opts),
) -> Graph =
  "Elixir.Scenic.Primitives" "triangle"

pub fn add(graph: Graph, triangle: Triangle) -> Graph {
  let Triangle(vertices, opts) = triangle

  external_triangle(graph, vertices, opts)
}

external fn external_modify(
  graph: Graph,
  id: GraphId,
  action: fn(Graph) -> Graph,
) -> Graph =
  "Elixir.Scenic.Graph" "modify"

pub fn modify(graph: Graph, id: GraphId, triangle: Triangle) -> Graph {
  let Triangle(vertices, opts) = triangle
  let action = external_triangle(_, vertices, opts)

  external_modify(graph, id, action)
}

pub fn id(graph_id) -> Opts {
  graph_id |> graph.id() |> Id()
}