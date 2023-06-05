extends Spatial

func _process(delta):
	if $Troops.get_child_count() <= 0:
		$UserInterface/Retry/Label_won.visible = false
		$UserInterface/Retry/Label_lost.visible = true
		$UserInterface.show()

func _ready():
	SignalBus.connect("won", self, "_on_won")
	$UserInterface.hide()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and $UserInterface.visible:
		# warning-ignore:return_value_discarded
		get_tree().reload_current_scene()

func _on_won():
	$UserInterface/Retry/Label_won.visible = true
	$UserInterface/Retry/Label_lost.visible = false
	$UserInterface.show()
	
