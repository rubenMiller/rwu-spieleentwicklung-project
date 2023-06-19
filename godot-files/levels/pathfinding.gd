extends Spatial

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene("res://Menues/otherMenu/otherMenu.tscn")
		
	if $Troops.get_child_count() <= 0:
		$UserInterface/Retry/Label_won.visible = false
		$UserInterface/Retry/Label_lost.visible = true
		$UserInterface.show()
		get_tree().change_scene("res://Menues/otherMenu/otherMenu.tscn")

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
	set_process(false)
	get_tree().change_scene("res://Menues/otherMenu/otherMenu.tscn")
	


func _on_Nav_mesh_navigation_mesh_changed() -> void:
	var troops = get_tree().get_nodes_in_group("troop")
	for troop in troops:
		
		troop.get_node("Navigation_component").setup_nav_server()
