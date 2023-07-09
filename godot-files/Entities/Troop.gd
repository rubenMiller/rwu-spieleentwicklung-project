extends KinematicBody

export var idleMaterial: Material
export var selectedMaterial: Material
export var health := 1
onready var marker: MeshInstance = $marker
onready var animation_player: AnimationPlayer = $AnimationPlayer

signal selection_changed(selection)

onready var isSelected = false

func _ready() -> void:
	animation_player.play("unit_idle")
	
func _on_SelectionArea_selection_toggled(selection):
	isSelected = selection
	emit_signal("selection_changed", selection)
#	display_selected_unit()

func _on_HealtComponent_i_am_dead():
	queue_free()


func _process(delta):
	if isSelected:
		for mesh in $meshes.get_children():
			marker.visible = true;
			#mesh.material_override = selectedMaterial
	else: 
		for mesh in $meshes.get_children():
			marker.visible = false;
			#mesh.material_override = idleMaterial
