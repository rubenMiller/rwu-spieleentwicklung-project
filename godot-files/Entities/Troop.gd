class_name Unit
extends KinematicBody

export var idleMaterial: Material
export var selectedMaterial: Material
export var MAX_SPEED := 10.0
export var show_path = true
export (NodePath) var im
export (NodePath) var camera 

var m = SpatialMaterial.new()
var map
var path = []
var _velocity := Vector3.ZERO

onready var current_position := global_transform.origin
onready var target_position := current_position
onready var isSelected = false 
onready var navigation_mesh_instance: NavigationMeshInstance = $"../../NavigationMeshInstance"
onready var tile_handler: Node = $"../../tile_handler"

func _ready():
	im = get_node(im)
	camera = get_node(camera)
	display_selected_unit()
	set_process_unhandled_input(isSelected)
	m.flags_unshaded = true
	m.flags_use_point_size = true
	m.albedo_color = Color.white

	call_deferred("setup_navserver")
	tile_handler.connect("tile_selected", self, "move") # aufruf der move funktion
	
func _process(delta: float) -> void:
	var direction = Vector3()
	var step_size = delta * MAX_SPEED
	if path.size() > 0:
		var destination = path[0]
		direction = destination - translation

		if step_size > direction.length():
			step_size = direction.length()
			path.remove(0)
			
		translation += direction.normalized() * step_size
		direction.y = 0
		if direction:
			var look_at_point = translation + direction.normalized()
			look_at(look_at_point, Vector3.UP)
			
func move(tile):
	if isSelected:
		path = NavigationServer.map_get_path(map,translation, tile.translation, true)

		if show_path:
			draw_path(path)

func _on_SelectionArea_selection_toggled(selection):
	isSelected = selection
	display_selected_unit()
	set_process_unhandled_input(isSelected)
	im.clear()
	
func display_selected_unit():
	$Label3D.visible = isSelected
	if isSelected: $MeshInstance.material_override = selectedMaterial
	else: $MeshInstance.material_override = idleMaterial

#func _unhandled_input(event):
#	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed and isSelected:
#		var from = camera.project_ray_origin(event.position)
#		var to = from + camera.project_ray_normal(event.position) * 1000
#		var target_point = NavigationServer.map_get_closest_point_to_segment(map, from, to)
#		var optimize_path = true
#
#		# Set the path between the robots current location and our target.
#		path = NavigationServer.map_get_path(map,translation, target_point, optimize_path)
#
#		if show_path and isSelected:
#			draw_path(path)

func setup_navserver():
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
	yield(get_tree(), "physics_frame")

func draw_path(path_array):
	im.clear()
	im.set_material_override(m)
	im.clear()
	im.begin(Mesh.PRIMITIVE_POINTS, null)
	im.add_vertex(path_array[0])
	im.add_vertex(path_array[path_array.size() - 1])
	im.end()
	im.begin(Mesh.PRIMITIVE_LINE_STRIP, null)
	for x in path:
		im.add_vertex(x)
	im.end()
