import scenic/color.{Color}
import scenic/graph.{Graph, Id}

pub type Opts {
  Fill(Color)
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
  id: Id(id),
  action: fn(Graph) -> Graph,
) -> Graph =
  "Elixir.Scenic.Graph" "modify"

pub fn modify(graph: Graph, id: Id(a), triangle: Triangle) -> Graph {
  let action = add(_, triangle)

  external_modify(graph, id, action)
}
