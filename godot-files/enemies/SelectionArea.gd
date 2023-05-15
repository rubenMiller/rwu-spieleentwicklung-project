extends Area

export var selection_action = "mouse_left"
export (NodePath) var attack_component_path
onready var attack_component = get_node(attack_component_path)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _input_event(_camera: Object, event: InputEvent, _position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if event.is_action_pressed(selection_action):
		print("pressed")
		attack_component.change_radius_visibility()

