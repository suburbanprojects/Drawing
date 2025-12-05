local config = {}

config.backgroundColor = {1, 1, 1}
config.colors = {
    {0, 0, 0},       -- black
    {1, 0, 0},       -- red
    {0, 0.4, 0},       -- green
    {0, 0, 1},       -- blue
    {1, 0.5, 0},     -- orange
    {0.5, 0, 0.5},   -- purple
}
config.currentColorIndex = 1
config.brushSize = 5

-- GUI palette layout
config.palette = {
    x = 5,
    y = 550, --i had to put this value so it won't overlap with the grid ffs
    size = 20,
    spacing = 5
}

config.clearButton = {
  x = 650,
  y = 550,
  width = 100,
  height = 40,
  label = "Clear"
}

return config
