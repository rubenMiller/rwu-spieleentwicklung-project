extends Spatial

export (Resource) var progress_color_disabled
export (Resource) var progress_color_enabled
export (Resource) var radius_color_highlighted

onready var audio_stream_player_3d: AudioStreamPlayer = $"../../loading_sound"

onready var view_component: Area = $"../../View_component"

onready var progress = 1.0
onready var lights:= get_children()

func _ready() -> void:
	for light in lights:
		light.mesh.material = progress_color_disabled
	
	audio_stream_player_3d.seek(1.0)
		
func _process(delta: float) -> void:
	for n in get_child_count():
		if 1.0 - progress > n/float(get_child_count()):
			get_child(n).mesh.material = progress_color_enabled
		else: 
			get_child(n).mesh.material = progress_color_disabled
			
	#print(stepify(1.0 - progress, 0.1))
	if stepify(1.0 - progress, 0.01) == 0.1:
		audio_stream_player_3d.play()
	if stepify(1.0 - progress, 0.01) == 0.2:
		audio_stream_player_3d.play()
	if stepify(1.0 - progress, 0.01) == 0.4:
		audio_stream_player_3d.play()
	if stepify(1.0 - progress, 0.01) == 0.6:
		audio_stream_player_3d.play()
	if stepify(1.0 - progress, 0.01) == 0.8:
		audio_stream_player_3d.play()
		
	if 1.0 - progress > 0.0:
		view_component.mesh.material_override = radius_color_highlighted
	else: 
		view_component.mesh.material_override = null
			
func reset_progress():
	progress = 1.0
	
func update_progress(value):
	progress = value
#	if fmod(progress,1.0/float(get_child_count())) == 0:
#		audio_stream_player_3d.play(0.0)
