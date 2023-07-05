extends Control

var state = "pause"

func _process(delta):
	$MarginContainer/MainContainer/VBoxContainer/label_pausiert.visible = false
	$MarginContainer/MainContainer/VBoxContainer/label_win.visible = false
	$MarginContainer/MainContainer/VBoxContainer/label_lost.visible = false
	match state:
		"pause":
			$MarginContainer/MainContainer/VBoxContainer2/VBoxContainer/Button_resume.visible = true
			$MarginContainer/MainContainer/VBoxContainer/label_pausiert.visible = true
		"won":
			$MarginContainer/MainContainer/VBoxContainer2/VBoxContainer/Button_resume.visible = false
			$MarginContainer/MainContainer/VBoxContainer/label_win.visible = true
		"lost":
			$MarginContainer/MainContainer/VBoxContainer2/VBoxContainer/Button_resume.visible = false
			$MarginContainer/MainContainer/VBoxContainer/label_lost.visible = true
		

func _on_Button_button_down():
	# unpause
	self.visible = false


func _on_Button2_button_down():
	# retry
	get_tree().reload_current_scene()


func _on_Button3_button_down():
	# exit to levels
	get_tree().change_scene("res://Menues/LevelMenu/LevelMenu.tscn")
