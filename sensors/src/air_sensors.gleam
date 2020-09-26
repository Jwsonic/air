import gleam/string
import uart.{Pid}

const baudrate: Int = 9600

pub fn pm2(pid: Pid) -> Result(Int, String) {
  case uart.read(pid, 10_000) {
    Ok(<<66, 77, frame_length:size(16), pm1:size(8), pm2:size(8), _rest:binary>>) ->
      Ok(pm2)
    Ok(data) ->
      ["Unexpected read response: ", data]
      |> string.concat()
      |> Error()
    _ -> Error("Error")
  }
}
