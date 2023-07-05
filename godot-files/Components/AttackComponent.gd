extends Node

export var target_group_name := ""
export (NodePath) var attack_pattern_path
export var damage := 1.0
export var fire_rate := 1.0

onready var reload_timer = $Load_timer
onready var health_bar = $Health_bar
onready var progress_lights: Spatial = $"../turret/progress_lights"

var attack_pattern 
var target_list := []
var current_target = null

onready var in_reach setget set_in_reach, get_in_reach

func _ready():
	attack_pattern = get_node(attack_pattern_path)
	reload_timer.wait_time = fire_rate
	set_in_reach(false)

func _physics_process(delta: float) -> void:
	if get_in_reach():
		var progress = float(reload_timer.time_left / reload_timer.wait_time)
		progress_lights.update_progress(progress)
	#health_bar.scale.x = reload_timer.time_left / reload_timer.wait_time
	
	if target_list.size() > 0:
		if current_target != target_list[0]:
			current_target = target_list[0]
		if current_target == target_list[0] and get_in_reach() and reload_timer.is_stopped():
			reload_timer.start()
		if not in_reach:
			reload_timer.stop()
			progress_lights.reset_progress()
	else: 
		progress_lights.reset_progress()
		current_target = null
		reload_timer.stop()

func _on_Radius_Component_body_entered(body: Node) -> void:
	#print("I ",get_parent() , " detected in my Radius: ", target_group_name, body)
	if body.is_in_group(target_group_name):
		#print("I ",get_parent() , " want to attack: ", target_group_name, body)
		target_list.append(body)

func _on_Radius_Component_body_exited(body: Node) -> void:
	if body.is_in_group(target_group_name):
		target_list.erase(body)

func _on_Load_timer_timeout() -> void:
	if target_list.size() > 0:
		attack_pattern.attack(target_list[0], damage)

func _on_View_component_body_entered(body: Node) -> void:
	set_in_reach(true)
	print("in view", body, in_reach)

func _on_View_component_body_exited(body: Node) -> void:
	set_in_reach(false)
	print("not in view", body, in_reach)
	
func set_in_reach(value: bool):
	in_reach = value

func get_in_reach():
	return in_reach
	
