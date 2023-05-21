extends Node

class_name NavServer

var map setget ,get_map
#onready var navigation_mesh_instance: NavigationMeshInstance = $"../NavigationMeshInstance"

func _ready() -> void:
	#call_deferred("setup_navserver")
	pass
	
func get_map():
	return map

func setup_navserver(navigation_mesh_instance):
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
	navigation_mesh = navigation_mesh_instance.navmesh
	NavigationServer.region_set_navmesh(region, navigation_mesh)
	
	# wait for NavigationServer sync to adapt to made changes
	#yield(get_tree(), "physics_frame")
	
	

