extends Node

export var target_group_name := ""
onready var reload_timer = $Load_timer
onready var health_bar = $Health_bar

var target_list := []
var current_target = null

func _ready():
	pass 

func _process(_delta):
	health_bar.scale.x = reload_timer.time_left / reload_timer.wait_time
	
	if target_list.size() > 0:
		if current_target != target_list[0]:
			current_target = target_list[0]
			reload_timer.start()
	else: 
		current_target = null
		reload_timer.stop()
		
func shoot_first_target():
	target_list[0].get_child(0).reduce_health(1)

func _on_Radius_Component_body_entered(body: Node) -> void:
	#print("I ",get_parent() , " detected in my Radius: ", target_group_name, body)
	if body.is_in_group(target_group_name):
		#print("I ",get_parent() , " want to attack: ", target_group_name, body)
		target_list.append(body)

func _on_Radius_Component_body_exited(body: Node) -> void:
	if body.is_in_group(target_group_name):
		target_list.erase(body)

func _on_Load_timer_timeout() -> void:
	shoot_first_target()
	reload_timer.start()
