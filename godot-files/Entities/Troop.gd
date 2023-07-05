extends KinematicBody

export var idleMaterial: Material
export var selectedMaterial: Material
export var health := 1

signal selection_changed(selection)

onready var isSelected = false

func _ready():
	display_selected_unit()
	
func _physics_process(_delta: float) -> void:
	pass
	
func _on_SelectionArea_selection_toggled(selection):
	isSelected = selection
	emit_signal("selection_changed", selection)
	display_selected_unit()
	
func display_selected_unit():
	if isSelected: 
		for mesh in $meshes.get_children():
			mesh.material_override = selectedMaterial
	else: 
		for mesh in $meshes.get_children():
			mesh.material_override = idleMaterial

func _on_HealtComponent_i_am_dead():
	queue_free()


