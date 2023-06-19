extends Spatial

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		save_game("not_completed")
		get_tree().change_scene("res://Menues/otherMenu/otherMenu.tscn")
		
	if $Troops.get_child_count() <= 0:
		save_game("lost")
		get_tree().change_scene("res://Menues/otherMenu/otherMenu.tscn")

func _ready():
	SignalBus.connect("won", self, "_on_won")
	$UserInterface.hide()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and $UserInterface.visible:
		# warning-ignore:return_value_discarded
		get_tree().reload_current_scene()

func _on_won():
	save_game("won")
	get_tree().change_scene("res://Menues/otherMenu/otherMenu.tscn")
	
func save_game(change_state):
	print(name, "was comleted with: ", change_state)
	var output_file = File.new()
	output_file.open("res://gamesave.save", File.READ_WRITE)
	var data_dict = parse_json(output_file.get_line())
	data_dict["last_completed"] = name
	if data_dict[self.name] == "won":
		output_file.close()
		return
	data_dict[self.name] = change_state
	output_file.seek(0)
	output_file.store_line(to_json(data_dict))
	output_file.close()

func _on_nav_mesh_navigation_mesh_changed() -> void:
	var troops = get_tree().get_nodes_in_group("troop")
	for troop in troops:
		
		troop.get_node("Navigation_component").setup_nav_server()
