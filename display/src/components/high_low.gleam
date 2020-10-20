import gleam/atom
import gleam/int
import gleam/io
import gleam/list.{List}
import gleam/string
import scenic/component.{Component, Ok, Opt, Push, Result}
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

const text_pos: tuple(Int, Int) = tuple(0, 20)

fn init_text(graph: Graph, data: InitData) -> Graph {
  let InitData(direction, value, bound) = data

  let opts = [
    build_fill(direction, value, bound, text.Fill),
    text.Id(ValueText),
    text.Translate(text_pos),
    text.Font(style.RobotoMono),
  ]

  text.add(graph, int.to_string(value), opts)
}

const width: Int = 8

const x_pos: Int = 12

const y_pos: Int = 9

fn init_arrow(graph: Graph, data: InitData) -> Graph {
  let InitData(direction, value, bound) = data

  let tri = case direction {
    Up -> tuple(tuple(width / 2, 0), tuple(0, width), tuple(width, width))
    Down -> tuple(tuple(width / 2, width), tuple(0, width), tuple(width, width))
  }

  let arrow_pos = case value {
    value if value > 99 -> tuple(x_pos + 25, y_pos)
    value if value > 9 -> tuple(x_pos + 15, y_pos)
    _ -> tuple(x_pos, y_pos)
  }

  let opts = [
    build_fill(direction, value, bound, triangle.Fill),
    triangle.Id(Arrow),
    triangle.Translate(arrow_pos),
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

pub fn add_to_graph(graph: Graph, data: InitData, opts: List(Opt(id))) -> Graph {
  Component(init, update)
  |> component.add_to_graph(graph, _, data, opts)
}
