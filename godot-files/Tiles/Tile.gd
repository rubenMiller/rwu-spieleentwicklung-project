extends KinematicBody

signal tile_selected(vector)


var selectedMaterial: Material = load("res://Art/materials/tile_selected.tres")
var unselectedMaterial: Material = load("res://Art/materials/tile_unselected.tres")

func _ready():
	$MeshInstance.material_override = unselectedMaterial


func _on_Area_input_event(camera, event, position, normal, shape_idx):
	if event.is_action_pressed("mouse_left"):
		print("I am node at: ", global_transform.origin)
		$MeshInstance.material_override = selectedMaterial
		emit_signal("tile_selected", self)
		print("signal emitted")
	if event.is_action_pressed("mouse_right"):
		$MeshInstance.material_override = unselectedMaterial
