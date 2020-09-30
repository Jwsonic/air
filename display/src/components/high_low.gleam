import gleam/int
import gleam/io
import scenic/color.{Black}
import scenic/component.{Component, Ok, Push, Result}
import scenic/graph.{Graph, Id}
import scenic/primatives/text.{Text}
import scenic/primatives/triangle.{Triangle, Vertices}

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

fn add_text(graph: Graph, value: Int) -> Graph {
  value
  |> int.to_string()
  |> Text([text.Fill(Black)])
  |> text.add(graph, _)
}

const up_vertices: Vertices = tuple(tuple(10, 0), tuple(0, 20), tuple(20, 20))

const down_vertices: Vertices = tuple(
  tuple(10, 20),
  tuple(0, 20),
  tuple(20, 20),
)

fn add_triangle(graph: Graph, direction: Direction) -> Graph {
  let vertices = case direction {
    Up -> up_vertices
    Down -> down_vertices
  }

  let opts = [triangle.Fill(Black)]

  triangle.add(graph, Triangle(vertices, opts))
}

pub fn init(opts: InitOpts) -> Result(State) {
  let graph =
    []
    |> graph.build()
    |> add_text(opts.value)
    |> add_triangle(opts.direction)

  let state = State(graph, opts.direction, opts.value, opts.bound)

  Push(state, graph)
}

pub fn update(state: State, message: Message) -> Result(State) {
  Ok(state)
}

pub fn new() -> Component(InitOpts, State, Message) {
  Component(init, update)
}
