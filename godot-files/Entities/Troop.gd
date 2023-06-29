extends KinematicBody

export var idleMaterial: Material
export var selectedMaterial: Material
export var health := 1

signal selection_changed(selection)

onready var attack_component: Spatial = $Attack_component
#onready var radius_component: Area = $Radius_Component

onready var isSelected = false

func _ready():
	display_selected_unit()
	
func _physics_process(_delta: float) -> void:
	pass
	
func _on_SelectionArea_selection_toggled(selection):
	isSelected = selection
	emit_signal("selection_changed", selection)
	display_selected_unit()
	#radius_component.visible = selection	
	
func display_selected_unit():
	#$Label3D.visible = isSelected
	if isSelected: 
		for mesh in $meshes.get_children():
			mesh.material_override = selectedMaterial
	else: 
		for mesh in $meshes.get_children():
			mesh.material_override = idleMaterial

func _on_HealtComponent_i_am_dead():
	queue_free()


