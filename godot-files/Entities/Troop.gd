extends KinematicBody

export var idleMaterial: Material
export var selectedMaterial: Material

onready var attack_component: Spatial = $Attack_component
onready var nav_component: Spatial = $Navigation_component
onready var radius_component: Area = $Radius_Component
onready var health_component: Spatial = $HealtComponent
onready var nav_agent: NavigationAgent = $NavigationAgent
onready var _agent: NavigationAgent = $NavigationAgent

var _velocity := Vector3.ZERO
onready var isSelected = false

enum States  {IDLE, WALK, SHOOT}
onready var current_state = States.IDLE

func _ready():
	display_selected_unit()
	#nav_agent.set_target_location()
	SignalBus.connect("walk_target",self,"on_set_target")
	_agent.set_target_location(global_translation)
	#nav_component.setup_nav_server()
	
func _physics_process(_delta: float) -> void:
	if _agent.is_navigation_finished():
		return
	var direction = global_translation.direction_to(_agent.get_next_location())
	var desired_velocity = direction * 10.0
	_velocity = desired_velocity
	_velocity = move_and_slide(_velocity)
	
	
	if isSelected:
		pass
		#nav_component.get_path_to_target_tile()
		
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

func on_set_target(target_position):
	print("target_position", target_position)
	if isSelected:
		_agent.set_target_location(target_position)
		#nav_component.get_path_to_target_tile(target_position)
	
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
