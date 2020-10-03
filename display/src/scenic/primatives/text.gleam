import scenic/color.{Color}
import scenic/graph.{Graph, GraphId}

pub type Opts {
  Fill(Color)
  Id(GraphId)
}

pub type Text {
  Text(text: String, opts: List(Opts))
}

external fn external_text(graph: Graph, text: String, opts: List(Opts)) -> Graph =
  "Elixir.Scenic.Primitives" "text"

pub fn add(graph: Graph, text: Text) -> Graph {
  let Text(text, opts) = text

  external_text(graph, text, opts)
}

external fn external_modify(graph: Graph, id: GraphId, action: fn(Graph) -> Graph) -> Graph =
  "Elixir.Scenic.Graph" "modify"

pub fn modify(graph: Graph, id: GraphId, text: Text) -> Graph {
  let Text(text, opts) = text
  let action = external_text(_, text, opts)

  external_modify(graph, id, action)
}

pub fn id(graph_id) -> Opts {
  graph_id |> graph.id() |> Id()
}