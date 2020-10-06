import components/high_low.{Up}
import gleam/atom
import scenic/component.{Component, Ok, Push, Result}
import scenic/graph.{Graph}

pub type InitOpts {
  Todo
}

pub type State {
  State(graph: Graph)
}

pub type Message {
  NewData
}

fn init(opts: InitOpts) -> Result(State) {
  let graph =
    []
    |> graph.build()

  // |> high_low.add_to_graph(high_low.InitOpts(Up, 10, 10))
  let state = State(graph)

  Push(state, graph)
}

pub fn update(state: State, message: Message) -> Result(State) {
  Ok(state)
}

pub fn build() -> Component(InitOpts, State, Message) {
  "Main"
  |> atom.create_from_string()
  |> Component(init, update)
}
