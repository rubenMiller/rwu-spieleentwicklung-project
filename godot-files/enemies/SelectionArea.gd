extends Area

export var selection_action = "mouse_left"
export (NodePath) var radiusPath
onready var radiusNode = get_node(radiusPath)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _input_event(_camera: Object, event: InputEvent, _position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if event.is_action_pressed(selection_action):
		radiusNode.get_child(0).visible = not radiusNode.get_child(0).visible
