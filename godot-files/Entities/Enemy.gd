extends KinematicBody

var path = []
var path_node = 0

var speed = 10

onready var nav = get_parent()
onready var player1 = $"/root/pathfinding/Navigation/Tile1"
onready var player2 = $"/root/pathfinding/Navigation/Tile2"

func _ready():
	InputDefault
	
func _physics_process(delta: float) -> void:
	if path_node < path.size():
		var direction = (path[path_node] - global_transform.origin)
		if direction.length() < 1:
			path_node += 1
		else:
			move_and_slide(direction.normalized() * speed, Vector3.UP)
			
func move_to(target_pos):
	path = nav.get_simple_path(global_transform.origin, target_pos)
	path_node = 0

func _input(event):
	if event.is_action_pressed("move_forward"):
		move_to(player1.global_transform.origin)
	if event.is_action_pressed("move_backward"):
		move_to(player2.global_transform.origin)
