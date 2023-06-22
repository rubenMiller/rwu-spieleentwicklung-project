extends NavigationMeshInstance

signal nav_mesh_changed(map)

var map
var region
var navigation_mesh

func _ready() -> void:
	setup_nav_server()
	
func setup_nav_server():
	# create a new navigation map
	map = NavigationServer.map_create()
	NavigationServer.map_set_up(map, Vector3.UP)
	NavigationServer.map_set_active(map, true)
	
	# create a new navigation region and add it to the map
	region = NavigationServer.region_create()
	NavigationServer.region_set_transform(region, Transform())
	NavigationServer.region_set_map(region, map)
	
	update_map()
	
	# wait for NavigationServer sync to adapt to made changes
	yield(get_tree(), "idle_frame")
	
	emit_signal("nav_mesh_changed", map)
	print("nav server updated")
	
func update_map():
	# sets navigation mesh for the region
	navigation_mesh = NavigationMesh.new()
	navigation_mesh = navmesh
	NavigationServer.region_set_navmesh(region, navigation_mesh)
	
func update_mesh():
	bake_navigation_mesh(false)
	yield(get_tree(), "physics_frame")
	yield(get_tree(), "physics_frame")
	yield(get_tree(), "physics_frame")
	yield(get_tree(), "physics_frame")
	yield(get_tree(), "physics_frame")
	yield(get_tree(), "physics_frame")
	yield(get_tree(), "physics_frame")
