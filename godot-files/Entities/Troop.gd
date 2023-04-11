class_name Unit
extends KinematicBody

export var idleMaterial: Material
export var selectedMaterial: Material
export var MAX_SPEED := 10.0

onready var navigation_mesh_instance: NavigationMeshInstance = $"../../NavigationMeshInstance"


var _velocity := Vector3.ZERO

onready var current_position := global_transform.origin
onready var target_position := current_position
onready var isSelected = false 

onready var _agent: NavigationAgent = $NavigationAgent

#onready var tile_handler = get_node("../tile_handler")
#onready var tile_handler: Node = $"../Navigation/tile_handler"
onready var tile_handler: Node = $"../../tile_handler"

const SPEED = 10.0

var camrot = 0.0
var m = SpatialMaterial.new()

var map
var im 
var path = []
export var show_path = true
export (NodePath) var draw 



export (NodePath) var camera 

func _ready():
	im = get_node(draw)
	camera = get_node(camera)
	display_selected_unit()
	set_process_input(true)
	m.flags_unshaded = true
	m.flags_use_point_size = true
	m.albedo_color = Color.white

	# use call deferred to make sure the entire SceneTree Nodes are setup
	# else yield on 'physics_frame' in a _ready() might get stuck
	call_deferred("setup_navserver")
	
	tile_handler.connect("tile_selected", self, "move") # aufruf der move funktion
	
func _process(delta: float) -> void:
#	if _agent.is_navigation_finished():
#		return
#
#	var direction := global_transform.origin.direction_to(_agent.get_next_location())
#	_velocity = direction * MAX_SPEED
#	_velocity = move_and_slide(_velocity)

	var direction = Vector3()

	# We need to scale the movement speed by how much delta has passed,
	# otherwise the motion won't be smooth.
	var step_size = delta * SPEED

	if path.size() > 0:
		# Direction is the difference between where we are now
		# and where we want to go.
		var destination = path[0]
		direction = destination - translation

		# If the next node is closer than we intend to 'step', then
		# take a smaller step. Otherwise we would go past it and
		# potentially go through a wall or over a cliff edge!
		if step_size > direction.length():
			step_size = direction.length()
			# We should also remove this node since we're about to reach it.
			path.remove(0)

		# Move the robot towards the path node, by how far we want to travel.
		# Note: For a KinematicBody, we would instead use move_and_slide
		# so collisions work properly.
		translation += direction.normalized() * step_size

		# Lastly let's make sure we're looking in the direction we're traveling.
		# Clamp y to 0 so the robot only looks left and right, not up/down.
		direction.y = 0
		if direction:
			# Direction is relative, so apply it to the robot's location to
			# get a point we can actually look at.
			var look_at_point = translation + direction.normalized()
			# Make the robot look at the point.
			look_at(look_at_point, Vector3.UP)
	
func move(target_tile):
	pass
#	if isSelected:
#		target_position = target_tile.global_transform.origin
#		_agent.set_target_location(target_position)
		
func _on_SelectionArea_selection_toggled(selection):
	isSelected = selection
	display_selected_unit()
	im.clear()
	
func display_selected_unit():
	$Label3D.visible = isSelected
	if isSelected: $MeshInstance.material_override = selectedMaterial
	else: $MeshInstance.material_override = idleMaterial
	
func _debug_information():
	
	print("------------------------------------------")
	print("Global Position:", global_transform.origin)
	print("distance to target:",_agent.distance_to_target())
	print("Velocity",_velocity)
	#set_process_unhandled_input(selection)
	
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

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_RIGHT and event.pressed and isSelected:
		var from = camera.project_ray_origin(event.position)
		var to = from + camera.project_ray_normal(event.position) * 1000
		var target_point = NavigationServer.map_get_closest_point_to_segment(map, from, to)
		var optimize_path = true

		# Set the path between the robots current location and our target.
		path = NavigationServer.map_get_path(map,translation, target_point, optimize_path)

		if show_path and isSelected:
			draw_path(path)


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
