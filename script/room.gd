class_name Room

extends  Object

enum roomtype {none,new,old} 
var pos : Vector2i
var size_x
var size_y
var type = roomtype.none
var gen_dis : int = 10



func _init(pos_x : int,pos_y : int ,sz_x : int , sz_y : int,  tp : roomtype) -> void:
	pos = Vector2i(pos_x,pos_y)
	size_x = sz_x
	size_y = sz_y
	type = tp

func place_room(mapgrid : MapGrid):
	for i in range(size_x):
		for j in range(size_y):
			mapgrid.grid[pos.x+i][pos.y+j].type = MapGridCell.GridType.ROOM
	put_wall(mapgrid)

func check_room(mapgrid : MapGrid) -> bool:
	if not(abs(pos.x + size_x) < mapgrid.grid.size()/2-1 and abs(pos.y + size_y) < mapgrid.grid.size()/2-1):
		return false
	for i in range(size_x+2*gen_dis):
		for j in range(size_y+2*gen_dis):
			if mapgrid.grid[pos.x+i-gen_dis][pos.y+j-gen_dis].type != MapGridCell.GridType.NONE:
				return false
	return true

func put_wall(mapgrid : MapGrid) -> void:
	for i in range(size_x):
		mapgrid.grid[pos.x+i][pos.y].type = MapGridCell.GridType.N_WALL
		mapgrid.grid[pos.x+i][pos.y+size_y-1].type = MapGridCell.GridType.S_WALL
	for i in range(size_y-2):
		mapgrid.grid[pos.x][pos.y+i+1].type = MapGridCell.GridType.L_WALL
		mapgrid.grid[pos.x+size_x-1][pos.y+i+1].type = MapGridCell.GridType.R_WALL
	
