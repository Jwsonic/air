import gleam/atom
import gleam/dynamic.{Dynamic}
import inky/display as display_

pub type Type {
  Phat
  What
}

pub type Accent {
  Black
  Red
  Yellow
}

pub external type Pid

pub type GenServerOnStart {
  Ok(Pid)
  Ignore
  Error(Dynamic)
}

pub external fn start_link(type_: Type, accent: Accent) -> GenServerOnStart =
  "Elixir.Inky" "start_link"

external fn inky_set_pixels(
  pid: Pid,
  pixels: display_.DisplayMap,
) -> Result(Nil, atom.Atom) =
  "Elixir.Inky" "set_pixels"

pub fn set_display(pid: Pid, display: display_.Display) -> Result(Nil, atom.Atom) {
  inky_set_pixels(pid, display_.get_pixels(display))
}
