extends Spatial

const SPEED = 10.0

#export (KinematicBody) var troops
#export (NodePath) var camera
export (NodePath) var troops
export (NodePath) var camera
#onready var troops: Spatial = $"../Navigation/Troops"
onready var navigation_mesh_instance: NavigationMeshInstance = $"../Navigation/NavigationMeshInstance"

var troop_selection
var map
var path := []
var show_path = true
var active_unit
var units := []

var camrot = 0.0
var m = SpatialMaterial.new()

func _ready():
	camera = get_node(camera)
	units = get_node(troops).get_children()
	set_process_input(true)
	set_process(true)
	m.flags_unshaded = true
	m.flags_use_point_size = true
	m.albedo_color = Color.white

	# use call deferred to make sure the entire SceneTree Nodes are setup
	# else yield on 'physics_frame' in a _ready() might get stuck
	call_deferred("setup_navserver")

func _physics_process(delta: float) -> void:
	for unit in units:
		if unit.isSelected:
			active_unit = unit
			#print(unit)
			#print(active_unit)
			var direction = Vector3()

			var step_size = delta * SPEED

			if path.size() > 0:
				var destination = path[0]
				direction = destination - active_unit.translation

				if step_size > direction.length():
					step_size = direction.length()
					path.remove(0)

				active_unit.move_and_slide(direction.normalized() * step_size)
				print(active_unit)
				direction.y = 0
				if direction:
					var look_at_point = active_unit.translation + direction.normalized()
					active_unit.look_at(look_at_point, Vector3.UP)
	
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
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		var from = camera.project_ray_origin(event.position)
		var to = from + camera.project_ray_normal(event.position) * 1000
		var target_point = NavigationServer.map_get_closest_point_to_segment(map, from, to)
		var optimize_path = true

		# Set the path between the robots current location and our target.
		
		for unit in units:
			if unit.isSelected:
				active_unit = unit
			print(unit.isSelected)
		print("current Position")
		print(active_unit)
		path = NavigationServer.map_get_path(map,active_unit.current_position, target_point, optimize_path)

		if show_path:
			draw_path(path)

	if event is InputEventMouseMotion:
		if event.button_mask & (BUTTON_MASK_MIDDLE + BUTTON_MASK_RIGHT):
			camrot += event.relative.x * 0.005
			get_node("CameraBase").set_rotation(Vector3(0, camrot, 0))
			print("Camera Rotation: ", camrot)

func draw_path(path_array):
	var im = get_node("Draw")
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
