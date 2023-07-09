extends KinematicBody

export var idleMaterial: Material
export var selectedMaterial: Material
export var health := 1
onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var animation_player_2: AnimationPlayer = $AnimationPlayer2
onready var selected_radius: Spatial = $selected_radius
onready var radius: MeshInstance = $selected_radius/MeshInstance


signal selection_changed(selection)

onready var isSelected = false

func _ready() -> void:
	animation_player.play("unit_idle")
	animation_player_2.play("arrow_animation")
	selected_radius.visible = false;
	
func _on_SelectionArea_selection_toggled(selection):
	isSelected = selection
	emit_signal("selection_changed", selection)
#	display_selected_unit()

func _on_HealtComponent_i_am_dead():
	queue_free()


func _process(delta):
	if isSelected:
		for mesh in $meshes.get_children():
			selected_radius.visible = true;
			radius.rotation.y += 0.002
			#mesh.material_override = selectedMaterial
	else: 
		for mesh in $meshes.get_children():
			selected_radius.visible = false;
			#mesh.material_override = idleMaterial
