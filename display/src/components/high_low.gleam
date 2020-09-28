import gleam/int
import scenic/component.{Component}
import scenic/graph.{Graph, Id}
import scenic/primatives/text.{Text}

pub type HighLowId {
  Arrow
  Value
}

pub type Direction {
  Down
  Up
}

pub type InitOpts {
  InitOpts(direction: Direction, value: Int, bound: Int)
}

pub type State {
  State(graph: Graph, direction: Direction, value: Int, bound: Int)
}

pub type Message {
  NewData(Int)
}

fn extract_text(state: State) -> Text {
  let State(_, _, value, _) = state

  value
  |> int.to_string()
  |> Text([])
}

fn add_text(graph: Graph, value: Int) {
  value
  |> int.to_string()
  |> Text([])
  |> text.add(graph, _)
}

fn init(opts: InitOpts) -> State {
  let graph =
    []
    |> graph.build()
    |> add_text(opts.value)

  State(graph, opts.direction, opts.value, opts.bound)
}

fn update(state: State, message: Message) -> State {
  state
}

pub fn component() -> Component(InitOpts, State, Message) {
  Component(init, update)
}
