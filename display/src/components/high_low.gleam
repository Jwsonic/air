import gleam/atom.{Atom}
import gleam/int
import gleam/io
import scenic/component.{Component, Ok, Push, Result}
import scenic/graph.{Graph}
import scenic/primative.{Fill}
import scenic/primatives/text
import scenic/primatives/triangle.{Triangle}
import scenic/style.{Black, Color, Red}

pub type HighLowId {
  Arrow
  ValueText
}

pub type Direction {
  Down
  Up
}

pub type InitData {
  InitData(direction: Direction, value: Int, bound: Int)
}

pub type State {
  State(graph: Graph, direction: Direction, value: Int, bound: Int)
}

pub type Message {
  NewData(Int)
}

fn build_fill(data: InitData) -> primative.Opt {
  case data {
    InitData(Up, value, bound) if value >= bound -> Red
    InitData(Down, value, bound) if value <= bound -> Red
    _ -> Black
  }
  |> Color()
  |> Fill()
}

fn add_text(graph: Graph, value: Int, fill: primative.Opt) -> Graph {
  value
  |> int.to_string()
  |> text.add(graph, _, [fill])
}

const up_triangle: Triangle = tuple(tuple(10, 0), tuple(0, 20), tuple(20, 20))

const down_triangle: Triangle = tuple(
  tuple(10, 20),
  tuple(0, 20),
  tuple(20, 20),
)

fn add_arrow(graph: Graph, direction: Direction, fill: primative.Opt) -> Graph {
  let tri = case direction {
    Up -> up_triangle
    Down -> down_triangle
  }

  triangle.add(graph, tri, [fill])
}

fn init(data: InitData) -> Result(State) {
  let fill = build_fill(data)
  let InitData(direction, value, bound) = data

  let graph =
    []
    |> graph.build()
    |> add_text(value, fill)
    |> add_arrow(direction, fill)

  let state = State(graph, direction, value, bound)

  Push(state, graph)
}

pub fn update(state: State, message: Message) -> Result(State) {
  Ok(state)
}

pub fn add_to_graph(graph: Graph, data: InitData) -> Graph {
  "HighLow"
  |> atom.create_from_string()
  |> Component(init, update)
  |> component.add_to_graph(graph, _, data)
}
