import scenic/graph.{Graph, Id}

pub type Opts =
  List(String)

pub type Text {
  Text(text: String, opts: Opts)
}

external fn external_text(graph: Graph, text: String, opts: Opts) -> Graph =
  "Elixir.Scenic.Primitives" "text"

pub fn add(graph: Graph, text: Text) -> Graph {
  let Text(text, opts) = text

  external_text(graph, text, opts)
}

external fn external_modify(
  graph: Graph,
  id: Id(id),
  action: fn(Graph) -> Graph,
) -> Graph =
  "Elixir.Scenic.Graph" "modify"

pub fn modify(graph: Graph, id: Id(a), text: Text) -> Graph {
  let action = add(_, text)

  external_modify(graph, id, action)
}
