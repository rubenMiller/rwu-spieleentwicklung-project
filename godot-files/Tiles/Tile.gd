extends KinematicBody

signal tile_selected(vector)

func _ready():
	pass # Replace with function body.


func _on_Area_input_event(camera, event, position, normal, shape_idx):
	var material = self.get_node("MeshInstance").get_surface_material(0)
	if event.is_action_pressed("mouse_left"):
		print("I am node at: ", global_transform.origin)
		emit_signal("tile_selected", self)
		print("signal emitted")
