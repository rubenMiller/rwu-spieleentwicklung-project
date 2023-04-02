extends Spatial



func _ready():
	$UserInterface.hide()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and $UserInterface.visible:
		# warning-ignore:return_value_discarded
		get_tree().reload_current_scene()

func _on_Troop_Won():
	$UserInterface.show()
	
	
