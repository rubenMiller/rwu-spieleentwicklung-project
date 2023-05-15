extends Node

export var target_group_name := ""
onready var reload_timer = $Reload_timer
onready var health_bar = $Health_bar
onready var radius = $radius

var target_list = []

func _ready():
	print(target_group_name)
	pass 

func _process(delta):
	health_bar.scale.x = reload_timer.time_left / reload_timer.wait_time
	if not reload_timer.is_stopped():
		return
	
	if target_list.size():
		shoot_first_target()
		reload_timer.start()
		
func shoot_first_target():
	#print("Going to shoot: ", target_list[0])
	#print("target_list", target_list, "target_list")
	target_list[0].get_child(0).reduceHealth(1)
	#print("Reduced Health by on for: ", target_list[0])

func _on_radius_body_entered(body):
	#print("Body entered: ", body)
	#print("something entered")
	#print(body.get_groups())
	#print(get_tree().get_nodes_in_group("Troops"))
	#if(target_group_name == "Towers"):
	print("Want to attack: ", target_group_name, " body: ", body)
		
	if body.is_in_group(target_group_name):
		#print("entered" + target_group_name)
		print("Adding to list from group: ", target_group_name)
		target_list.append(body)
	
func _on_radius_body_exited(body):
	#print("Body entered: ", body)
	if body.is_in_group(target_group_name):
		target_list.erase(body)
	
func change_radius_visibility():
	radius.visible = not radius.visible
