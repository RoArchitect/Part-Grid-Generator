# Part-Grid-Generator
Generates a grid based on parts.

```lua
local GridModule : Table = require(game:GetService("ReplicatedStorage"):WaitForChild("Grid"))

-- << Creating your first grid >> --
local NewGrid : Table = GridModule.new(Vector3.new(0.5,0.5,0.5) , 0.2 , 32)
--[[
	[1] = BLOCK_SIZE; : Vector3
	[2] = BLOCK_SPACING; : Number
	[3] = BLOCK_AMOUNT; : Number
]]

local GeneratedGrid : Table = NewGrid:Generate()
local GridBlock : Part = GeneratedGrid.GetGridBlock(1023)
--[[
To get the total amount of grid blocks, just do your BLOCK_AMOUNT multiplied by BLOCK_AMOUN
T
GenerateGrid.GetGridBlock(1023) -- 1023 being the grid block number (1-1024 if it's 32x32 )
]]
```
