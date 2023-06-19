extends Control


func _ready():
	var output_file = File.new()
	output_file.open("res://gamesave.save", File.READ)
	var data_dict = parse_json(output_file.get_line())
	if data_dict["level_1"] == "won":
		get_node("CenterContainer/VBoxContainer/Level2Button").disabled = false
	if data_dict["level_2"] == "won":
		get_node("CenterContainer/VBoxContainer/Level3Button").disabled = false
			#if data_dict["level_1"] == "lost" || data_dict["level_2"] == "lost" || data_dict["level_3"] == "lost":
		
	#var image = Image.new()
	#var err
	if data_dict["last_completed"] == "none":
		print("Loading standart image")
		get_node("CenterContainer/VBoxContainer/TextureRect").texture = load("res://.import/programming-or-googling.jpg-01626551c2f1b3de9fb5f3db8493a718.stex")

	elif data_dict[data_dict["last_completed"]] == "won":
		print("Loading won image")
		get_node("CenterContainer/VBoxContainer/TextureRect").texture = load("res://.import/you-won-meme.jpg-ed60b7b5240917e3e386c5abdaf3f220.stex")
	
	elif data_dict[data_dict["last_completed"]] == "lost":
		print("Loading lost image")
		get_node("CenterContainer/VBoxContainer/TextureRect").texture = load("res://.import/you-lost-meme.jpg-421f31efc4aff9b9c040e65c072c04cd.stex")


	output_file.close()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Level1Button_pressed():
	get_tree().change_scene("res://levels/level_1.tscn")


func _on_Level2Button_pressed():
	get_tree().change_scene("res://levels/level_2.tscn")


func _on_Level3Button_pressed():
	get_tree().change_scene("res://levels/level_3.tscn")


func _on_ExitButton_pressed():
	get_tree().quit()

