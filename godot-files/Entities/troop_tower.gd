extends KinematicBody

export var idleMaterial: Material
export var selectedMaterial: Material

onready var attack_component: Spatial = $Attack_component
onready var body: MeshInstance = $body

onready var isSelected = false

func _ready():
	display_selected_unit()
	
func _process(delta: float) -> void:
	if attack_component.current_target != null:
		var target = attack_component.current_target
		var v = target.global_translation - global_translation
		body.global_rotation.y = lerp_angle(body.global_rotation.y, atan2(v.x,v.z), 0.5)
		$Radius_Component.global_rotation.y = lerp_angle($Radius_Component.global_rotation.y, atan2(v.x,v.z), 0.5)
		
func _on_SelectionArea_selection_toggled(selection):
	isSelected = selection
	display_selected_unit()
	
func display_selected_unit():
	$Label3D.visible = isSelected
	print(body)
	if isSelected: body.material_override = selectedMaterial
	else: body.material_override = idleMaterial

func _on_Health_Component_i_am_dead() -> void:
	queue_free()
