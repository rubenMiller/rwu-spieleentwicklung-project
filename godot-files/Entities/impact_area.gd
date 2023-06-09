extends Area

onready var timer = $Timer

var target_list := []
var damage := 1.0
var air_time := 1.0

func _ready() -> void:
	timer.wait_time = air_time
	timer.start()
	
func _on_Timer_timeout() -> void:
	if target_list.size() > 0:
		for e in target_list:
			e.get_node("Health_Component").reduce_health(damage)
			#target_list.erase(e)
	queue_free()


func _on_Impact_area_body_entered(body: Node) -> void:
	target_list.append(body)


func _on_Impact_area_body_exited(body: Node) -> void:
	target_list.erase(body)


