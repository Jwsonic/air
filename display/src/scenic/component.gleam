import gleam/atom.{Atom}
import gleam/list.{List}
import scenic/graph.{Graph}

pub type Result(state) {
  Ok(state)
  Push(state, Graph)
  Error(String)
}

pub type Component(opts, state, message) {
  Component(
    name: Atom,
    init: fn(opts) -> Result(state),
    update: fn(state, message) -> Result(state),
  )
}

external fn external_build(component: Component(opts, state, message)) -> Atom =
  "Elixir.Display.Bridge.Component" "build!"

external fn external_add_to_graph(
  graph: Graph,
  mod: tuple(Atom, data_type),
  List(Int),
) -> Graph =
  "Elixir.Primitive.SceneRef" "add_to_graph"

pub fn add_to_graph(
  graph: Graph,
  component: Component(opts, state, message),
  data: opts,
) -> Graph {
  let module = external_build(component)

  external_add_to_graph(graph, tuple(module, data), [])
}
