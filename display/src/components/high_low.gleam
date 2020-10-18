import gleam/atom
import gleam/int
import gleam/io
import scenic/component.{Component, Ok, Push, Result}
import scenic/graph.{Graph}
import scenic/primatives/text
import scenic/primatives/triangle.{Triangle}
import scenic/style.{Black, Color, Paint, Red}

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

fn build_fill(
  direction: Direction,
  value: Int,
  bound: Int,
  constructor: fn(Paint) -> fill,
) -> fill {
  case direction, value, bound {
    Up, value, bound if value >= bound -> Red
    Down, value, bound if value <= bound -> Red
    _, _, _ -> Black
  }
  |> Color()
  |> constructor()
}

fn init_text(graph: Graph, data: InitData) -> Graph {
  let InitData(direction, value, bound) = data

  let opts = [
    build_fill(direction, value, bound, text.Fill),
    text.Id(ValueText),
  ]

  value
  |> int.to_string()
  |> text.add(graph, _, opts)
}

const up_triangle: Triangle = tuple(tuple(10, 0), tuple(0, 20), tuple(20, 20))

const down_triangle: Triangle = tuple(
  tuple(10, 20),
  tuple(0, 20),
  tuple(20, 20),
)

fn init_arrow(graph: Graph, data: InitData) -> Graph {
  let InitData(direction, value, bound) = data

  let tri = case direction {
    Up -> up_triangle
    Down -> down_triangle
  }

  let opts = [
    build_fill(direction, value, bound, triangle.Fill),
    triangle.Id(Arrow),
  ]

  triangle.add(graph, tri, opts)
}

pub fn init(data: InitData) -> Result(State) {
  let InitData(direction, value, bound) = data

  let graph =
    []
    |> graph.build()
    |> init_text(data)
    |> init_arrow(data)

  let state = State(graph, direction, value, bound)

  Push(state, graph)
}

pub fn update(state: State, message: Message) -> Result(State) {
  Ok(state)
}

pub fn add_to_graph(graph: Graph, data: InitData) -> Graph {
  Component(init, update)
  |> component.add_to_graph(graph, _, data, [])
}
