import scenic/color.{Color}
import scenic/style.{Font, Paint}

pub external type Primative

// TODO: Figure out id

pub type Opt {
  // Styles
  ClearColor(clear: Color)
  Fill(paint: Paint)
  Font(font: Font)
  FontSize(size: Int)
  // Transforms
  Pin(pin: tuple(Int, Int))
  Rotate(radians: Float)
  Scale(multiplier: Float)
  Translate(offset: tuple(Int, Int))
}
