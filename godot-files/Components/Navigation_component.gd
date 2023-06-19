extends Spatial

export var MAX_SPEED := 10.0
export var show_path = true

var path = []
var map
var m 

func _ready() -> void:
	configure_path_material()
	
func _process(delta: float) -> void:
	if has_reached_win_tile():
		SignalBus.emit_signal("won")
	var direction = Vector3()
	var step_size = delta * MAX_SPEED
	
	if path.size() > 0:
		var destination = path[0]
		direction = destination - get_parent().translation

		if step_size > direction.length():
			step_size = direction.length()
			path.remove(0)
		
		get_parent().translation += direction.normalized() * step_size
		direction.y = 0
		if direction:
			var look_at_point = get_parent().translation + direction.normalized()
			get_parent().look_at(look_at_point, Vector3.UP)

func get_path_to_target_tile():
	var selected_tile = get_tree().get_nodes_in_group("selected_tile")
	if selected_tile != []:
		var target_tile = selected_tile[0]
		path = NavigationServer.map_get_path(map,get_parent().translation, target_tile.translation, true)
		selected_tile[0].remove_from_group("selected_tile")
		
		if show_path:
			draw_path(path)

func has_reached_win_tile():
	var win_tile = get_tree().get_nodes_in_group("win_tiles")
	var tile_pos = win_tile[0].translation
	return tile_pos.x == get_parent().translation.x and tile_pos.z == get_parent().translation.z

func setup_nav_server():
	var nav_mesh_instance = get_tree().get_nodes_in_group("navigation_mesh_instance")[0]
	# create a new navigation map
	map = NavigationServer.map_create()
	NavigationServer.map_set_up(map, Vector3.UP)
	NavigationServer.map_set_active(map, true)
	
	# create a new navigation region and add it to the map
	var region = NavigationServer.region_create()
	NavigationServer.region_set_transform(region, Transform())
	NavigationServer.region_set_map(region, map)
	
	# sets navigation mesh for the region
	var navigation_mesh = NavigationMesh.new()
	navigation_mesh = nav_mesh_instance.navmesh
	NavigationServer.region_set_navmesh(region, navigation_mesh)
	
	# wait for NavigationServer sync to adapt to made changes
	yield(get_tree(), "physics_frame")
	
func configure_path_material():
	m = SpatialMaterial.new()
	m.flags_unshaded = true
	m.flags_use_point_size = true
	m.albedo_color = Color.white
	
func draw_path(path_array):
	var im = get_tree().get_nodes_in_group("draw")[0]
	im.clear()
	im.set_material_override(m)
	im.begin(Mesh.PRIMITIVE_LINE_STRIP, null)
	for x in path:
		im.add_vertex(x)
	im.end()
