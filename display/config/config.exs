import Config

config :air_display, :viewport, %{
  name: :main_viewport,
  default_scene: {AirDisplay.Scenes.Main, nil},
  size: {400, 300},
  opts: [scale: 1.0],
  drivers: [
    %{
      module: Scenic.Driver.Glfw
    }
  ]
}
