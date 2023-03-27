extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal tile_selected(vector)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Area_input_event(camera, event, position, normal, shape_idx):
	var material = self.get_node("MeshInstance").get_surface_material(0)
	if event.is_action_pressed("mouse_left"):
		print("I am node at: ", global_transform.origin)
		emit_signal("tile_selected", global_transform.origin)
		print("signal emitted")
