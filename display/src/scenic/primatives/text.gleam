import scenic/graph.{Graph}
import scenic/style.{Font, Paint, TextAlign}

pub type Opt(id_type) {
  // Styles
  Fill(paint: Paint)
  Hidden(hide: Bool)
  Font(font: Font)
  FontSize(size: Int)
  FontBlur(blur: Int)
  TextAlign(align: TextAlign)
  TextHeight(spacing: Int)
  // Transforms
  Pin(pin: tuple(Int, Int))
  Rotate(radians: Float)
  Scale(multiplier: Float)
  Translate(offset: tuple(Int, Int))
  // ID for locating primative in a graph
  Id(id: id_type)
}

pub external fn add(graph: Graph, text: String, opts: List(Opt(id))) -> Graph =
  "Elixir.Scenic.Primitives" "text"
