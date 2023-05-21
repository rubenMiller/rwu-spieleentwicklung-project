extends KinematicBody

export var idleMaterial: Material
export var selectedMaterial: Material

onready var attack_component: Spatial = $Attack_component
onready var nav_component: Spatial = $Navigation_component
onready var isSelected = false

func _ready():
	display_selected_unit()
	nav_component.setup_navserver()
	
func _process(_delta: float) -> void:
	if isSelected:
		nav_component.get_path_to_target_tile()

func _on_SelectionArea_selection_toggled(selection):
	isSelected = selection
	display_selected_unit()
	attack_component.change_radius_visibility()
	
func display_selected_unit():
	$Label3D.visible = isSelected
	if isSelected: $MeshInstance.material_override = selectedMaterial
	else: $MeshInstance.material_override = idleMaterial

func _on_HealtComponent_i_am_dead():
	queue_free()
