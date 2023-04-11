extends Area

signal selection_toggled(selection)

export var exclusive = true
export var selection_group_name = "tile_selection"
export var selection_action = "mouse_left"

var selected = false setget set_selected

func set_selected(selection):
	if selection:
		_make_exclusive()
		add_to_group(selection_group_name)
	else:
		remove_from_group(selection_group_name)
	
	selected = selection
	emit_signal("selection_toggled", selected)

func _make_exclusive():
	if not exclusive:
		return
	reset_selection()
	
func _input_event(_camera: Object, event: InputEvent, _position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if event.is_action_pressed(selection_action):
		set_selected(not selected)
		
func reset_selection():
	get_tree().call_group(selection_group_name, "set_selected", false)
	
