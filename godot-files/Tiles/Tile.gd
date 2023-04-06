extends KinematicBody

signal tile_selected(vector)

export var selectedMaterial: Material 
export var unselectedMaterial: Material 

func _ready():
	$MeshInstance.material_override = unselectedMaterial

func _on_Area_input_event(camera, event, position, normal, shape_idx):
	if event.is_action_pressed("mouse_left"):
		emit_signal("tile_selected", self)
		$MeshInstance.material_override = selectedMaterial
		
	if event.is_action_pressed("mouse_right"):
		$MeshInstance.material_override = unselectedMaterial
