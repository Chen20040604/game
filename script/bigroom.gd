extends Room
class_name BigRoom

enum bigroomtype {l1 = 1,l2 = 2,c = 3,o = 4}

var hallway_width : int = 5
var min_single_room_width : int = 10
var max_single_room_width : int = 15


func _init(pos_x : int,pos_y : int ,sz_x : int , sz_y : int,  tp : bigroomtype) -> void:
	pos = Vector2i(pos_x,pos_y)
	size_x = sz_x
	size_y = sz_y
	type = tp

func put_wall(mapgrid : MapGrid) -> void:
	for i in range(size_x):
		mapgrid.grid[pos.x+i][pos.y].type = MapGridCell.GridType.N_WALL
		mapgrid.grid[pos.x+i][pos.y+size_y-1].type = MapGridCell.GridType.S_WALL
	for i in range(size_y-2):
		mapgrid.grid[pos.x][pos.y+i+1].type = MapGridCell.GridType.L_WALL
		mapgrid.grid[pos.x+size_x-1][pos.y+i+1].type = MapGridCell.GridType.R_WALL
		
