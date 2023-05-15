extends Spatial

onready var reload_timer = $Reload_timer
onready var health_bar = $Health_bar
var target_list = []

func _ready():
	pass 

func _process(delta):
	health_bar.scale.x = reload_timer.time_left / reload_timer.wait_time
	if not reload_timer.is_stopped():
		return
	
	if target_list.size():
		shoot_first_target()
		reload_timer.start()
		
func shoot_first_target():
	print("Going to shoot: ", target_list[0])
	print("target_list", target_list, "target_list")
	target_list[0].get_child(4).reduceHealth(1)
	print("Reduced Health by on for: ", target_list[0])

func _on_radius_body_entered(body):
	print("Body entered: ", body)
	target_list.append(body)
	
func _on_radius_body_exited(body):
	print("Body entered: ", body)
	target_list.erase(body)
