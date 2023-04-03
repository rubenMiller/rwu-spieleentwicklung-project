extends KinematicBody

signal Won

var path = []
var path_node = 0

var speed = 10

onready var nav = get_parent()
onready var move = false
onready var material = $MeshInstance.get_surface_material(0)
onready var tile_handler = get_node("../tile_handler")
onready var navigating_to_win_tile = false

func _ready():
	print(tile_handler)
	tile_handler.connect("tile_selected", self, "move") # aufruf der move funktion
	
func _physics_process(delta: float) -> void:
	if path_node < path.size():
		var direction = (path[path_node] - global_transform.origin)
		if direction.length() < 1:
			path_node += 1
		else:
			move_and_slide(direction.normalized() * speed)
		if path_node == path.size():
			move_and_collide(direction.normalized())
			if navigating_to_win_tile == true:
				emit_signal("Won")
			
func move(child):
	
	if(child.filename == "res://Tiles/Tile.tscn"):
		navigating_to_win_tile = false
	if(child.filename == "res://win_tile/win_tile.tscn"):
		print("On the way to the win")
		navigating_to_win_tile = true
	move_to(child.global_transform.origin)
			
func move_to(target_pos):
	if move == true:
		path = nav.get_simple_path(global_transform.origin, target_pos)
		print(global_transform.origin)
		print(target_pos)
		path_node = 0

func _on_Area_input_event(camera, event, position, normal, shape_idx):
	var material = get_node("MeshInstance").get_surface_material(0)
	if event.is_action_pressed("mouse_left"):
		print("I am Troop at: ", global_transform.origin)
		if move == true:
			print("move to false")
			print(material.albedo_color)
			material.albedo_color = Color(1, 1, 1)
			move = false
		elif move == false:
			print(material.albedo_color)
			print("move to true")
			material.albedo_color = Color(1, 0, 0)
			move = true
