extends KinematicBody

export var idleMaterial: Material
export var selectedMaterial: Material

onready var attack_component: Spatial = $Attack_component
onready var nav_component: Spatial = $Navigation_component
onready var radius_component: Area = $Radius_Component
onready var health_component: Spatial = $HealtComponent

onready var nav_agent = $NavigationAgent
onready var isSelected = false

enum States  {IDLE, WALK, SHOOT}
onready var current_state = States.IDLE

func _ready():
	display_selected_unit()
	#nav_component.setup_nav_server()
	
func _process(_delta: float) -> void:
	if isSelected:
		nav_component.get_path_to_target_tile()
		nav_agent.get_next_location()
	
	if nav_component.path.size() > 0:
		current_state = States.WALK
	else: 
		current_state = States.IDLE

	if attack_component.target_list.size() > 0:
		current_state = States.SHOOT
	
	#print(self, " State: ", current_state)
	
func _on_SelectionArea_selection_toggled(selection):
	isSelected = selection
	display_selected_unit()
	radius_component.visible = selection
	
func display_selected_unit():
	$Label3D.visible = isSelected
	if isSelected: 
		for mesh in $meshes.get_children():
			mesh.material_override = selectedMaterial
	else: 
		for mesh in $meshes.get_children():
			mesh.material_override = idleMaterial

func _on_HealtComponent_i_am_dead():
	queue_free()

func _on_Health_Component_shot(base_health, rest_health) -> void:
	#print(rest_health/base_health)
	if rest_health / base_health < 0.75:
		$meshes/troop_4.visible = false
	if rest_health / base_health < 0.5:
		$meshes/troop_3.visible = false
	if rest_health / base_health < 0.25:
		$meshes/troop_2.visible = false
