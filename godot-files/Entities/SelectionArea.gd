extends Area

signal selection_toggled(selection)

export var exclusive = true
export var selection_group_name = "troop_selection"
export var attack_selection_group_name = "attacked_tower"

onready var selection_action = "mouse_left"
onready var attack_selection_action = "mouse_right"

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
	get_tree().call_group(selection_group_name, "set_selected", false)
	
func _input_event(_camera: Object, event: InputEvent, _position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if event.is_action_pressed(selection_action):
		set_selected(not selected)
	if event.is_action_pressed(attack_selection_action) and not get_parent().is_in_group("troop"):
		get_parent().add_to_group(attack_selection_group_name)
		#var group = get_tree().get_nodes_in_group(attack_selection_group_name)
		#print(group)
		

	
	
