import gleam/atom.{Atom}
import gleam/list.{List}
import scenic/graph.{Graph}

pub type Result(state) {
  Ok(state)
  Push(state, Graph)
  Error(String)
}

pub type Component(data, state, message) {
  Component(
    init: fn(data) -> Result(state),
    update: fn(state, message) -> Result(state),
  )
}

pub type Opt(id_type) {
  // Transforms
  Pin(pin: tuple(Int, Int))
  Rotate(radians: Float)
  Scale(multiplier: Float)
  Translate(offset: tuple(Int, Int))
  // ID for locating component in a graph
  Id(id: id_type)
}

external fn external_build(component: Component(opts, state, message)) -> Atom =
  "Elixir.Display.Bridge.Component" "build!"

external fn external_add_to_graph(
  graph: Graph,
  mod: Atom,
  data: data_type,
  opts: List(Opt(id_type))
) -> Graph =
  "Elixir.Display.Bridge.Component" "add_to_graph"

pub fn add_to_graph(
  graph: Graph,
  component: Component(data_type, state, message),
  data: data_type,
  opts: List(Opt(id_type))
) -> Graph {
  let module = external_build(component)

  external_add_to_graph(graph, module, data, opts)
}
