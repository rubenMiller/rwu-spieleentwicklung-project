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
	SignalBus.connect("walk_target",self,"on_set_target")
	_agent.set_target_location(global_translation)
	
func _physics_process(_delta: float) -> void:
	if _agent.is_navigation_finished():
		return
	var direction = global_translation.direction_to(_agent.get_next_location())
	_velocity = direction * 3.0
	_velocity = move_and_slide(_velocity)
	
	global_rotation.y = atan2(direction.x,direction.z)
	
func _on_SelectionArea_selection_toggled(selection):
	isSelected = selection
	display_selected_unit()
	radius_component.visible = selection

func on_set_target(target_position):
	#print("target_position", target_position)
	if isSelected:
		_agent.set_target_location(target_position)
	
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
