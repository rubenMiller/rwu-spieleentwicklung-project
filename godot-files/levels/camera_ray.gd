extends Camera


const ray_length = 1000
var map

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == BUTTON_RIGHT and event.pressed:
		var from = project_ray_origin(event.position)
		var to = from + project_ray_normal(event.position) * 1000
		#map = get_tree().get_nodes_in_group("navigation_mesh_instance")[0].map
		var target_point = NavigationServer.map_get_closest_point_to_segment(map, from, to)
		
		SignalBus.emit_signal("walk_target", target_point)	
		print(target_point)

func _on_nav_mesh_nav_mesh_changed(map_) -> void:
	#print("changed map")
	map = map_
