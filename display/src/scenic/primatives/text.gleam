import scenic/graph.{Graph, GraphId}
import scenic/primative.{Opt}

pub external fn add(graph: Graph, text: String, opts: List(Opt)) -> Graph =
  "Elixir.Scenic.Primitives" "text"
