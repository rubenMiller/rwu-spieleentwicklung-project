extends Area

var target_list := []

func _ready() -> void:
	$Timer.start()
	
func _on_Timer_timeout() -> void:
	if target_list.size() > 0:
		for e in target_list:
			e.get_child(0).reduce_health(1)
			#target_list.erase(e)
	queue_free()


func _on_Impact_area_body_entered(body: Node) -> void:
	target_list.append(body)


func _on_Impact_area_body_exited(body: Node) -> void:
	target_list.erase(body)


