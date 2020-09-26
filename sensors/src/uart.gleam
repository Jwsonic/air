import gleam/dynamic.{Dynamic}
import gleam/io
import gleam/result.{Nil, Result}

pub type UartOption {
  Active(Bool)
  Speed(Int)
}

pub external type Pid

pub external type Error

pub external fn start_link() -> Result(Pid, Error) =
  "Elixir.Circuits.UART" "start_link"

external fn uart_open(
  pid: Pid,
  name: String,
  options: List(UartOption),
) -> Dynamic =
  "Elixir.Circuits.UART" "open"

pub fn open(
  pid: Pid,
  name: String,
  options: List(UartOption),
) -> Result(Nil, String) {
  let result =
    pid
    |> uart_open(name, options)
    |> dynamic.atom()

  case result {
    Ok(_) -> Ok(Nil)
    Error(error) -> {
      io.debug(error)
      Error("Open error. Please see debug.")
    }
  }
}

pub external fn read(pid: Pid, timeout: Int) -> Result(String, Error) =
  "Elixir.Circuits.UART" "read"
