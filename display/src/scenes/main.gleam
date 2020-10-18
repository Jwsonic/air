import components/high_low.{InitData, Up}
import gleam/list.{List}
import scenic/graph.{Graph}

pub type InitOpts {
  Todo
}

pub fn init(opts: List(InitOpts)) -> Graph {
  []
  |> graph.build()
  |> high_low.add_to_graph(InitData(Up, 1, 2))
}
