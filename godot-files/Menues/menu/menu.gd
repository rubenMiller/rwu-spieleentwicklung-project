extends Control


func _on_Button_button_down():
	get_tree().change_scene("res://Menues/LevelMenu/LevelMenu.tscn")


func _on_Button3_button_down():
	get_tree().quit()
