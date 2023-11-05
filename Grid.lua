-- << Type Inheritance >> --
type Vectors = {
	main: () -> (Vector3);
}
type Numeral = {
	main: () -> (number);
}
type SizeTy = Vectors&{SIZE:()->()};
type SpacingTy = Vectors&{SPACING:()->()};
type GridBlockAmountTy = Numeral&{BLOCKAMOUNT:()->()};

-- << Main Variables >> --
local Grid = {
	-- DO NOT CONFIGURE --
	SIZE = Vector3.new(0,0,0);
	SPACING = Vector3.new(0,0,0);
}
local LastBlock = nil

local GridContainer = workspace:FindFirstChild("GridContainer") or Instance.new("Folder")
GridContainer.Name = "GridContainer"
GridContainer.Parent = workspace

-- << Functions >> --
function Grid:Generate()
	-- << Looping from index[1] to index[BLOCKAMOUNT] (Grid.BLOCKAMOUNT) >> --
	local Row1 = {}
	
	--[[
		
		FIRST ROW
		
	--]]
	local GridNum = 0
	
	for i=1, self.BLOCKAMOUNT do
		GridNum += 1 -- Incrementing the amount of grids
		task.wait() -- Preventing crashes
		
		-- << Creating the grid block >> --
		local GridPart = Instance.new("Part")
		GridPart.Parent = self.GRIDPARENT;
		GridPart.Size = self.SIZE;
		GridPart.Name = "Grid_"..GridNum
		GridPart.Anchored = true

		-- << Positioning the grid block >> --
		local NewPos -- The new position to set to
		if (LastBlock) then
			-- << If there's a last block, meaning it isnt the first >> --
			NewPos = ((LastBlock.Position + Vector3.new(GridPart.Size.X,0,0)) + Vector3.new(self.SPACING,0,0))
		else
			-- << If there's no last block, meaning it's the first >> --
			NewPos = Vector3.new(0,1,0)
		end	

		GridPart.Position = NewPos -- Setting to the new position
		LastBlock = GridPart; -- Setting the LastBlock
		Row1[i] = GridPart -- Setting the index of loop([i]) to Row1 table[index]
	end
	
	--[[
		
		FILLING OTHER ROWS
		
	--]]
	
	for i=1, #Row1 do
		task.wait() -- Preventing crashes
		for j=2, #Row1 do
			GridNum += 1 -- Incrementing the amount of grids
			task.wait() -- Preventing crashes

			-- << Creating a grid block >> --
			local GridPart = Row1[i]:Clone()
			GridPart.Name = "Grid_"..GridNum
			GridPart.Parent = self.GRIDPARENT

			-- << Setting it's position based on the Row1[index] block's position >> --
			GridPart.Position = ((Row1[i].Position + Vector3.new(0,0,GridPart.Size.Z)) + Vector3.new(0,0,self.SPACING))
			Row1[i] = GridPart
		end
	end
	
	return {
		GetGridBlock = function(...)
			local args = {...}
			if not args[1] then
				return warn('Tried to get GridBlock without the specified number.')
			else
				return self.GRIDPARENT["Grid_"..args[1]]
			end
		end,
	}
end

function Grid.new(Size : SizeTy , Spacing : SpacingTy , GridBlockAmount : GridBlockAmountTy )
	local self = setmetatable(Grid,{});
	
	local Children = #GridContainer:GetChildren()
	local GridParent = Instance.new("Folder")
	GridParent.Name = "Grid"..Children
	GridParent.Parent = GridContainer
	
	Grid.SIZE = Size;
	Grid.SPACING = Spacing;
	Grid.BLOCKAMOUNT = GridBlockAmount;
	Grid.GRIDPARENT = GridParent;
	
	return self;
end

return Grid
