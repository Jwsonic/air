import gleam/map
import gleam/option
import gleam/result

pub type Coordinate =
  tuple(Int, Int)

pub type Color {
  Accent
  Black
  White
}

pub type DisplayMap =
  map.Map(Coordinate, Color)

pub opaque type Display {
  Display(display: DisplayMap, width: Int, height: Int)
}

pub fn new(width: Int, height: Int) -> Display {
  Display(map.new(), width, height)
}

fn is_visible(display: Display, coordinate: Coordinate) -> Bool {
  let tuple(x, y) = coordinate
  let Display(_, width, height) = display
  x >= 0 && x < width && y >= 0 && y < height
}

fn map_(
  over: Display,
  coordinate: Coordinate,
  with: fn(DisplayMap) -> DisplayMap,
) -> Display {
  case is_visible(over, coordinate) {
    True -> Display(..over, display: with(over.display))
    False -> over
  }
}

pub fn set_pixel(
  display: Display,
  coordinate: Coordinate,
  color: Color,
) -> Display {
  map_(display, coordinate, map.insert(_, coordinate, color))
}

pub fn get_pixel(
  display: Display,
  coordinate: Coordinate,
) -> option.Option(Color) {
  case is_visible(display, coordinate) {
    True ->
      display.display
      |> map.get(coordinate)
      |> result.unwrap(White)
      |> option.Some()
    _ -> option.None
  }
}

pub fn get_pixels(display: Display) -> DisplayMap {
  display.display
}