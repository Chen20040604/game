class_name MapGrid

var grid : Array

func _init(size_x : int, size_y : int):
	grid = []
	for x in range(-size_x/2, size_x/2):
		var row = []
		for y in range(-size_y/2, size_y/2):
			var cell = MapGridCell.new()
			row.append(cell)
		grid.append(row)
