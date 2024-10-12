extends Node2D
@onready var grass: TileMapLayer = $grass
@onready var stone_ground: TileMapLayer = $"stone ground"
@onready var wall: TileMapLayer = $wall
@onready var props: TileMapLayer = $props
@onready var struct: TileMapLayer = $struct
@onready var plant: TileMapLayer = $plant
@onready var camera_2d: Camera2D = $player/Camera2D

@export var noise_textrue : NoiseTexture2D




@export var width : int = 100
@export var height : int = 100
var noise : Noise
var noise_val_arr = []
var grass_arr = []
var n_wall_arr = []
var s_wall_arr = []
var l_wall_arr = []
var r_wall_arr = []
var room_ground = []


var room_num : int = 3
var max_room_size_x : int = 20
var min_room_size_x : int = 13
var max_room_size_y : int = 20
var min_room_size_y : int = 13

var mapgrid : MapGrid = MapGrid.new(width,height)
# Called when the node enters the scene tree for the first time.
	
	
func limit_camera(camera_2d: Camera2D):
	var used:= grass.get_used_rect().grow(-1)
	var tile_size := grass.tile_set.tile_size
	
	camera_2d.limit_top = used.position.y * tile_size.y
	camera_2d.limit_right = used.end.x * tile_size.x
	camera_2d.limit_bottom = used.end.y * tile_size.y
	camera_2d.limit_left = used.position.x * tile_size.x
	camera_2d.reset_smoothing()

func generate_world():
	generate_room()
	for x in range(-width/2, width/2):
		for y in range(-height/2, height/2):
			mapgrid.grid[x][y].pos = Vector2i(x,y)
			if mapgrid.grid[x][y].type == MapGridCell.GridType.N_WALL:
				n_wall_arr.append(mapgrid.grid[x][y].pos)
			elif mapgrid.grid[x][y].type == MapGridCell.GridType.S_WALL:
				s_wall_arr.append(mapgrid.grid[x][y].pos)
			elif mapgrid.grid[x][y].type == MapGridCell.GridType.L_WALL:
				room_ground.append(mapgrid.grid[x][y].pos)
				l_wall_arr.append(mapgrid.grid[x][y].pos)
			elif mapgrid.grid[x][y].type == MapGridCell.GridType.R_WALL:
				r_wall_arr.append(mapgrid.grid[x][y].pos)
				room_ground.append(mapgrid.grid[x][y].pos)
			elif mapgrid.grid[x][y].type == MapGridCell.GridType.ROOM:
				room_ground.append(mapgrid.grid[x][y].pos)
			#var noise_val : float = noise.get_noise_2d(x,y)
			#noise_val_arr.append(noise_val)
			grass_arr.append(Vector2i(x,y))
	grass.set_cells_terrain_connect(grass_arr,0,0)
	wall.set_cells_terrain_connect(n_wall_arr,0,0)
	wall.set_cells_terrain_connect(s_wall_arr,0,1)
	wall.set_cells_terrain_connect(l_wall_arr,0,2)
	wall.set_cells_terrain_connect(r_wall_arr,0,3)
	stone_ground.set_cells_terrain_connect(room_ground,0,0)
	save_map()
	
func reload_map(mapgrid : MapGrid):
	for x in range(-width/2, width/2):
		for y in range(-height/2, height/2):
			mapgrid.grid[x][y].pos = Vector2i(x,y)
			if mapgrid.grid[x][y].type == MapGridCell.GridType.N_WALL:
				n_wall_arr.append(mapgrid.grid[x][y].pos)
			elif mapgrid.grid[x][y].type == MapGridCell.GridType.S_WALL:
				s_wall_arr.append(mapgrid.grid[x][y].pos)
			elif mapgrid.grid[x][y].type == MapGridCell.GridType.L_WALL:
				room_ground.append(mapgrid.grid[x][y].pos)
				l_wall_arr.append(mapgrid.grid[x][y].pos)
			elif mapgrid.grid[x][y].type == MapGridCell.GridType.R_WALL:
				r_wall_arr.append(mapgrid.grid[x][y].pos)
				room_ground.append(mapgrid.grid[x][y].pos)
			elif mapgrid.grid[x][y].type == MapGridCell.GridType.ROOM:
				room_ground.append(mapgrid.grid[x][y].pos)

func get_mapgrid() -> MapGrid:
	return mapgrid

func generate_room():
	var gen_room_num : int = 0
	var room : Room
	while gen_room_num <  room_num:
		room = Room.new(randi_range(-width/2+1, width/2),randi_range(-height/2+1, height/2),randi_range(min_room_size_x,max_room_size_x),randi_range(min_room_size_y,max_room_size_y),Room.roomtype.none)
		if room.check_room(mapgrid):
			room.place_room(mapgrid)
			gen_room_num += 1
			

func save_map():
	var file = FileAccess.open("user://map1.dat", FileAccess.WRITE)
	if file:
		file.store_var(mapgrid.grid)
		file.close()
		print("Map saved successfully.")
	else:
		print("Failed to open file for writing.")

func load_map():
	var file = FileAccess.open("user://map1.dat", FileAccess.READ)
	if file:  # 确保文件存在且不为空
		var load_mapgrid : MapGrid = MapGrid.new(width, height)
		load_mapgrid.grid = file.get_var()
		file.close()
		reload_map(load_mapgrid)
		print("Map loaded successfully.")
	else:
		generate_world()
		print("No map file found, generating a new world.")
