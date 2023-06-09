extends KinematicBody

export var idleMaterial: Material
export var selectedMaterial: Material

onready var attack_component: Spatial = $Attack_component

onready var isSelected = false

func _ready():
	display_selected_unit()

func _on_SelectionArea_selection_toggled(selection):
	isSelected = selection
	display_selected_unit()
	
func display_selected_unit():
	$Label3D.visible = isSelected
	if isSelected: $MeshInstance.material_override = selectedMaterial
	else: $MeshInstance.material_override = idleMaterial

func _on_Health_Component_i_am_dead() -> void:
	queue_free()
