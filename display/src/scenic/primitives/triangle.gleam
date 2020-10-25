import gleam/list
import scenic/graph.{Graph}
import scenic/style.{Join, Paint}

pub type Point =
  tuple(Int, Int)

pub type Triangle =
  tuple(Point, Point, Point)

pub type Opt(id_type) {
  // Styles
  Fill(paint: Paint)
  Hidden(hide: Bool)
  Join(join: Join)
  MiterLimit(limit: Int)
  Stroke(tuple(Int, Paint))
  // Transforms
  Pin(pin: tuple(Int, Int))
  Rotate(radians: Float)
  Scale(multiplier: Float)
  Translate(offset: tuple(Int, Int))
  // ID for locating primitive in a graph
  Id(id: id_type)
}

pub external fn add(
  graph: Graph,
  triangle: Triangle,
  opts: List(Opt(id)),
) -> Graph =
  "Elixir.Scenic.Primitives" "triangle"
