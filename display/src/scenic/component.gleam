import scenic/graph.{Graph}

pub type Result(state) {
  Ok(state)
  Push(state, Graph)
  Error(String)
}

pub type Component(opts, state, message) {
  Component(
    init: fn(opts) -> Result(state),
    update: fn(state, message) -> Result(state),
  )
}
