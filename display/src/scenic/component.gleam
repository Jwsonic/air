import scenic/graph.{Graph}

pub type Component(opts, state, message) {
  Component(init: fn(opts) -> state, update: fn(state, message) -> state)
}
