class_name Unit
extends KinematicBody

export var idleMaterial: Material
export var selectedMaterial: Material
export var MAX_SPEED := 10.0
export var show_path = true
export (NodePath) var im

export (NodePath) var attack_component_path
onready var attack_component = get_node(attack_component_path)

var m = SpatialMaterial.new()
var map
var path = []
var _velocity := Vector3.ZERO
var selected_tile := []

onready var current_position := global_transform.origin
onready var target_position := current_position
onready var isSelected = false 
onready var navigation_mesh_instance: NavigationMeshInstance = $"../../NavigationMeshInstance"
onready var walk_tiles: GridMap = $"../../WalkTiles"

# TODO Extract navigation component

func _ready():
	im = get_node(im)
	display_selected_unit()
	configure_path_material()

	call_deferred("setup_navserver")
	
	
	
	
func _process(delta: float) -> void:
	if has_reached_win_tile():
		SignalBus.emit_signal("won")
	get_path_to_target_tile()
	
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
			
			
func get_path_to_target_tile():
	selected_tile = get_tree().get_nodes_in_group("selected_tile")
	if selected_tile != []:
		
		if isSelected:
			var target_tile = selected_tile[0]
			path = NavigationServer.map_get_path(map,translation, target_tile.translation, true)
			selected_tile[0].remove_from_group("selected_tile")
			
			if show_path:
				draw_path(path)

func _on_SelectionArea_selection_toggled(selection):
	isSelected = selection
	display_selected_unit()
	attack_component.change_radius_visibility()
	im.clear()
	
func display_selected_unit():
	$Label3D.visible = isSelected
	if isSelected: $MeshInstance.material_override = selectedMaterial
	else: $MeshInstance.material_override = idleMaterial
	
func has_reached_win_tile():
	var win_tile = get_tree().get_nodes_in_group("win_tiles")
	var tile_pos = win_tile[0].translation
	return tile_pos.x == translation.x and tile_pos.z == translation.z

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

func configure_path_material():
	m.flags_unshaded = true
	m.flags_use_point_size = true
	m.albedo_color = Color.white
	
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


func _on_HealtComponent_i_am_dead():
	queue_free()
	
