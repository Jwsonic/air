import gleam/list.{List}
import scenic/color.{Black, Red, White}
import scenic/style

pub external type Graph

pub external type GraphId

pub external fn id(a) -> GraphId =
  "Elixir.Display.GraphExtra" "id"

pub type BuildOpt {
  ClearColor(clear_color: color.Color)
  Fill(fill: style.Paint)
  Font(font: style.Font)
  FontSize(size: Int)
}

pub external fn build(opts: List(BuildOpt)) -> Graph =
  "Elixir.Scenic.Graph" "build"

pub fn test() -> Graph {
  build([
    ClearColor(White),
    Fill(style.Color(Black)),
    Font(style.Roboto),
    FontSize(32),
  ])
}
