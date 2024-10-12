extends Node2D


@onready var camera_2d: Camera2D = $player/Camera2D

var genterater:= preload("res://sence/gameplay/map/proc_map_generater.tscn")


func _ready() -> void:
	var map_instence = genterater.instantiate()
	add_child(map_instence)
	map_instence.load_map()
	map_instence.limit_camera(camera_2d)


func _process(delta: float) -> void:
	if Input.is_action_pressed("north"):
		camera_2d.position.y = camera_2d.position.y - 5
	elif Input.is_action_pressed("south"):
		camera_2d.position.y = camera_2d.position.y + 5
	elif Input.is_action_pressed("west"):
		camera_2d.position.x = camera_2d.position.x - 5
	elif Input.is_action_pressed("east"):
		camera_2d.position.x = camera_2d.position.x + 5

func _input(event):
	if Input.is_action_just_pressed("zoom_in"):
		var zoom_val =camera_2d.zoom.x + 0.1
		
		camera_2d.zoom = Vector2(zoom_val, zoom_val)
	elif Input.is_action_just_pressed("zoom_out"):
		var zoom_val =camera_2d.zoom.x - 0.1
		if zoom_val == 0:
			
			zoom_val =camera_2d.zoom.x - 0.2
		
		camera_2d.zoom = Vector2(zoom_val, zoom_val)
		
	
