class_name WalkTiles
extends GridMap

export (Resource) var idle_tile 

var cells: Array = []
var _units := {}

onready var _navigation = $Navigation

func _ready() -> void:
	#_reinitialize()
	#visible = false
	cells = get_used_cells()
	
	print(cell_size)
	print(cells)
	print("Units:",_units)
	print(_navigation)
	
	
	
func _reinitialize() -> void:
	_units.clear()

	for child in _navigation.get_children():
		var unit := child as Unit
		if not unit:
			continue
		_units[unit.current_position] = unit
	
	
func tiles_on_points(points: Array):
	return
	
func _unhandled_input(event):
	if event is InputEventMouseButton && event.is_pressed():
		var world_click_pos = screen_point_to_ray()
		var map_cell_pos = world_to_map(world_click_pos)
		print(map_cell_pos)
		
	
func screen_point_to_ray():
	var space_state = get_world().direct_space_state
	
	var mouse_pos = get_viewport().get_mouse_position()
	var camera = get_tree().root.get_camera()
	var ray_origin = camera.project_ray_origin(mouse_pos)
	var ray_end = ray_origin + camera.project_ray_normal(mouse_pos) * 2000
	var ray_array = space_state.intersect_ray(ray_origin, ray_end)
	print(ray_array)
	if ray_array.has("position"):
		return ray_array["position"]
	return Vector3()
