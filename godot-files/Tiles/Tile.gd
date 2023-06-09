extends Position3D
class_name Tile

var is_tile_selected = false

export (SpatialMaterial) var selectedMaterial
export (SpatialMaterial) var unselectedMaterial
export (Resource) var win_unselected_material

func _ready():
	$MeshInstance.material_override = unselectedMaterial

func _process(_delta: float) -> void:
	if is_tile_selected:
		$MeshInstance.material_override = selectedMaterial
	else:
		if is_in_group("win_tiles"):
			$MeshInstance.material_override = win_unselected_material
		else:
			$MeshInstance.material_override = unselectedMaterial
	
func _on_Area_input_event(_camera, event, _position, _normal, _shape_idx):
	if event.is_action_pressed("mouse_right"):
		reset_all_tiles()
		is_tile_selected = true
		add_to_group("selected_tile")
		print("tile selected at:", translation)
		
func reset_all_tiles():
	var tiles = get_tree().get_nodes_in_group("selectable_tiles")
	for tile in tiles:
		tile.is_tile_selected = false
		if tile.is_in_group("selected_tile"):
			tile.remove_from_group("selected_tile")
			
func setMaterial(material):
	$MeshInstance.material_override = material;

	
