import components/high_low.{InitData, Up}
import gleam/list.{List}
import scenic/graph.{ClearColor, Graph}
import scenic/style.{White}

pub type InitOpts {
  Todo
}

pub fn init(opts: List(InitOpts)) -> Graph {
  [ClearColor(White)]
  |> graph.build()
  |> high_low.add_to_graph(InitData(Up, 100, 2), [])
}
