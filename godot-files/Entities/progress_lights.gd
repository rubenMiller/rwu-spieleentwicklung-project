extends Spatial

export (Resource) var progress_color_disabled
export (Resource) var progress_color_enabled
export (Resource) var radius_color_highlighted

onready var view_component: Area = $"../../View_component"

onready var progress = 1.0
onready var lights:= get_children()

func _ready() -> void:
	for light in lights:
		light.mesh.material = progress_color_disabled
		
func _process(delta: float) -> void:
	for n in get_child_count():
		if 1.0 - progress > n/float(get_child_count()):
			get_child(n).mesh.material = progress_color_enabled
		else: 
			get_child(n).mesh.material = progress_color_disabled
	
	if 1.0 - progress > 0.0:
		view_component.mesh.material_override = radius_color_highlighted
	else: 
		view_component.mesh.material_override = null
			
func reset_progress():
	progress = 1.0
	
func update_progress(value):
	progress = value
