extends Area

var target_list := []

func _on_Timer_timeout() -> void:
	queue_free()
	if target_list.size() > 0:
		for e in target_list:
			e.queue_free()
			#target_list.erase(e)


func _on_Impact_area_body_entered(body: Node) -> void:
	print(body)
	target_list.append(body)


func _on_Impact_area_body_exited(body: Node) -> void:
	target_list.erase(body)
