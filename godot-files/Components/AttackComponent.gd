extends Node

export var target_group_name := ""
export (NodePath) var attack_pattern_path
export var damage := 1.0
export var fire_rate := 1.0

onready var reload_timer = $Load_timer
onready var health_bar = $Health_bar

var attack_pattern 
var target_list := []
var aimed_list := []
var current_target = null

var in_reach = false

func _ready():
	attack_pattern = get_node(attack_pattern_path)
	reload_timer.wait_time = fire_rate

func _physics_process(delta: float) -> void:
	health_bar.scale.x = reload_timer.time_left / reload_timer.wait_time
	
	if target_list.size() > 0:
		if current_target != target_list[0]:
			current_target = target_list[0]
		if current_target == target_list[0] and in_reach and reload_timer.is_stopped():
			reload_timer.start()
		if not in_reach:
			reload_timer.stop()
	else: 
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
	in_reach = true
	print("in view", body, in_reach)
	
	#if body.is_in_group(target_group_name):
		#print("in view", body)
		#aimed_list.append(body)

func _on_View_component_body_exited(body: Node) -> void:
	#if body.is_in_group(target_group_name):
		#aimed_list.erase(body)
	in_reach = false
	print("not in view", body, in_reach)
	
