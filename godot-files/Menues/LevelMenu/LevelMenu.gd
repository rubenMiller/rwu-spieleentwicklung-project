extends Control


func _ready():
	var output_file = File.new()
	var err = output_file.open("res://gamesave.save", File.READ)
	if err == 7:
		#  ERR_FILE_NOT_FOUND 
		print("The save file is not found")
		create_save_file()
	
	var data_dict = parse_json(output_file.get_line())
	if data_dict["level_1"] == "won":
		$MarginContainer/MainContainer/VBoxContainer2/VBoxContainer/Button2.disabled = false
	if data_dict["level_2"] == "won":
		$MarginContainer/MainContainer/VBoxContainer2/VBoxContainer/Button3.disabled = false
		
	output_file.close()


func create_save_file():
	var data_dict = {
		"last_completed":"none",
		"level_1":"not_completed",
		"level_2":"not_completed",
		"level_3":"not_completed"
		}
	var output_file = File.new()
	output_file.open("res://gamesave.save", File.WRITE)
	output_file.store_string(JSON.print(data_dict))



func _on_Button_button_down():
	get_tree().change_scene("res://levels/level_1.tscn")


func _on_Button2_button_down():
	get_tree().change_scene("res://levels/level_2.tscn")


func _on_Button3_button_down():
	get_tree().change_scene("res://levels/level_3.tscn")


func _on_Button4_button_down():
	get_tree().change_scene("res://Menues/menu/menu.tscn")
