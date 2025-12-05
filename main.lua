local config = require("config")

function love.load()
  love.graphics.setBackgroundColor(config.backgroundColor) -- store the color chosen
  cellSize = 15
  gridXCount = 50
  gridYCount = 35
  
  grid = {}
  for y = 1, gridYCount do
    grid[y] = {}
    for x = 1, gridXCount do
      grid[y][x] = false -- set to false so the cells are empty when stared
    end
  end
end

function love.mousepressed(x, y, button)
    if button == 1 then
        -- Check if clicked on palette
        for i, color in ipairs(config.colors) do
            local px = config.palette.x + (i - 1) * (config.palette.size + config.palette.spacing)
            local py = config.palette.y
            if x >= px and x <= px + config.palette.size and y >= py and y <= py + config.palette.size then
                config.currentColorIndex = i
                return
            end
        end
        currentLine = {{x = x, y = y, color = config.colors[config.currentColorIndex]}}
    end

    -- Check if clicked on clear button
    if x >= config.clearButton.x and x <= config.clearButton.x + config.clearButton.width and
       y >= config.clearButton.y and y <= config.clearButton.y + config.clearButton.height then
        for yy = 1, gridYCount do
            for xx = 1, gridXCount do
                grid[yy][xx] = false
            end
        end
        return
    end
end

function love.update()
    selectedX = math.min(math.floor(love.mouse.getX() / cellSize) + 1, gridXCount)
    selectedY = math.min(math.floor(love.mouse.getY() / cellSize) + 1, gridYCount)

  if love.mouse.isDown(1) then
    grid[selectedY][selectedX] = config.colors[config.currentColorIndex]
  elseif love.mouse.isDown(2) then
    grid[selectedY][selectedX] = false
end
end

function love.draw()
  for y = 1, gridYCount do
    for x = 1, gridXCount do
      local cellDrawSize = cellSize - 1
      if x == selectedX and y == selectedY then
        love.graphics.setColor(config.colors[config.currentColorIndex])
      elseif grid[y][x] then
        love.graphics.setColor(grid[y][x])
      else
        love.graphics.setColor(.86, .86, .86)
      end
      love.graphics.rectangle('fill', 
        (x - 1) * cellSize, 
        (y - 1) * cellSize, 
        cellDrawSize, 
        cellDrawSize)
    end
  end
      -- Draw color palette
  for i, color in ipairs(config.colors) do
    local px = config.palette.x + (i - 1) * (config.palette.size + config.palette.spacing)
    local py = config.palette.y
    love.graphics.setColor(color)
    love.graphics.rectangle("fill", px, py, config.palette.size, config.palette.size)
    if i == config.currentColorIndex then
      love.graphics.setColor(0, 0, 0)
      love.graphics.rectangle("line", px - 2, py - 2, config.palette.size + 4, config.palette.size + 4)
    end
  end
  --draw clear button
  love.graphics.setColor(0.8, 0.8, 0.8)
  love.graphics.rectangle("fill", config.clearButton.x, config.clearButton.y, config.clearButton.width, config.clearButton.height)
  
  love.graphics.setColor(0, 0, 0)
  love.graphics.rectangle("line", config.clearButton.x, config.clearButton.y, config.clearButton.width, config.clearButton.height)
  -- button label
  love.graphics.print(config.clearButton.label, config.clearButton.x + 25, config.clearButton.y + 12)
  --include oher stuff here  
  love.graphics.setColor(0, 0, 0)
  love.graphics.print("Left click to draw, and right click to clear", 175, 555)
  love.window.setTitle("Drawing")
  
end
