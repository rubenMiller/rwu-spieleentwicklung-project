extends Node

export var target_group_name := ""
onready var reload_timer = $Reload_timer
onready var health_bar = $Health_bar


var target_list = []

func _ready():
	pass 

func _process(_delta):
	health_bar.scale.x = reload_timer.time_left / reload_timer.wait_time
	if not reload_timer.is_stopped():
		return
	
	if target_list.size():
		shoot_first_target()
		reload_timer.start()
		
func shoot_first_target():
	target_list[0].get_child(0).reduceHealth(1)

func _on_Radius_Component_body_entered(body: Node) -> void:
	print("I ",get_parent() , " detected in my Radius: ", target_group_name, body)
	#print(body, " wants to attack: ", target_group_name, " body: ", body)
	if body.is_in_group(target_group_name):
		print("I ",get_parent() , " want to attack: ", target_group_name, body)
		target_list.append(body)

func _on_Radius_Component_body_exited(body: Node) -> void:
		if body.is_in_group(target_group_name):
			target_list.erase(body)
