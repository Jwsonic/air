pub type Color {
  Black
  Red
}

const high_humidity: Int = 50

const low_humidity: Int = 40

pub fn humidity(num: Int) -> Color {
  case num > high_humidity, num < low_humidity {
    False, False -> Black
    _, _ -> Red
  }
}
