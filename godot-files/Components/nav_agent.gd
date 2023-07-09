extends NavigationAgent

export var MAX_SPEED := 3.0
export var show_path := true
onready var meshes: Spatial = $"../meshes"
onready var engine_sound: AudioStreamPlayer = $"../engine_sound"
onready var engine_stop: AudioStreamPlayer = $"../engine_stop"

onready var is_troop_selected := false

var _velocity := Vector3.ZERO
var path := []

func _ready() -> void:
	#set_radius(6)
	configure_path_material()
	SignalBus.connect("set_walk_target",self,"on_set_walk_target")
	set_target_location(get_parent().global_translation)

func _physics_process(delta: float) -> void:
	if is_navigation_finished():
		if engine_sound.playing:
			engine_sound.stop()
			engine_stop.play()
		return
	var direction = get_parent().global_translation.direction_to(get_next_location())
	_velocity = direction * MAX_SPEED
	var rotation = atan2(direction.x,direction.z)
	get_parent().move_and_slide(_velocity)
#	get_parent().global_rotation.y = rotation
	for troop in meshes.get_children():
		troop.global_rotation.y = lerp_angle(troop.global_rotation.y,rotation + PI, 0.15)
		#troop.global_rotation.y = rotation + PI
		troop.scale.x = 2
		troop.scale.y = 2
		troop.scale.z = 2

func on_set_walk_target(target_position):
	if is_troop_selected:
		engine_sound.play()
		set_target_location(target_position)
		var navigation = get_tree().get_nodes_in_group("navigation")[0]
		path = navigation.get_simple_path(get_parent().global_translation, target_position, true)
		if show_path:
			draw_path(path)
		
func configure_path_material():
	var m = SpatialMaterial.new()
	m.flags_unshaded = true
	m.flags_use_point_size = true
	#m.emission_energy = 0.1
	var multiplier = 3.0
	m.albedo_color = Color(0.875*multiplier,0.569*multiplier,0.075*multiplier, 1)
	#m.albedo_color = Color.darkgoldenrod
	return m
	
func draw_path(path_array):
	var im = get_tree().get_nodes_in_group("draw")[0]
	im.clear()
	var color = configure_path_material()
	im.set_material_override(color)
	im.begin(Mesh.PRIMITIVE_LINE_STRIP, null)
	for x in path_array:
		im.add_vertex(x)
	im.end()
	print("line drawn")

func _on_Troop_selection_changed(selection) -> void:
	is_troop_selected = selection
