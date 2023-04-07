extends Node

# export(NodePath) var troop
signal tile_selected(vector)


# Called when the node enters the scene tree for the first time.
func _ready():
	for child in self.get_children():
		child.connect("tile_selected", self, "test_function")
		
func test_function(child):
	emit_signal("tile_selected", child)
