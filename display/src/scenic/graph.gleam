import gleam/list.{List}
import scenic/style

pub external type Graph

pub type BuildOpt {
  ClearColor(clear_color: style.Color)
  Fill(fill: style.Paint)
  Font(font: style.Font)
  FontSize(size: Int)
}

pub external fn build(opts: List(BuildOpt)) -> Graph =
  "Elixir.Scenic.Graph" "build"
