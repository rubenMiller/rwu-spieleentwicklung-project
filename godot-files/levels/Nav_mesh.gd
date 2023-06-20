extends NavigationMeshInstance


signal nav_mesh_changed(map)

func _ready() -> void:
	setup_nav_server()
	
func setup_nav_server():
	# create a new navigation map
	var map = NavigationServer.map_create()
	NavigationServer.map_set_up(map, Vector3.UP)
	NavigationServer.map_set_active(map, true)
	
	# create a new navigation region and add it to the map
	var region = NavigationServer.region_create()
	NavigationServer.region_set_transform(region, Transform())
	NavigationServer.region_set_map(region, map)
	
	# sets navigation mesh for the region
	var navigation_mesh = NavigationMesh.new()
	navigation_mesh = navmesh
	NavigationServer.region_set_navmesh(region, navigation_mesh)
	
	emit_signal("nav_mesh_changed", map)
	# wait for NavigationServer sync to adapt to made changes
	yield(get_tree(), "physics_frame")

