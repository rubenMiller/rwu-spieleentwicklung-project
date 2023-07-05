extends Control

var state = "running"

var my_style = StyleBoxFlat.new()

func _ready():

	# Set the "normal" style to be your newly created style.
	set("custom_styles/normal", my_style)

func _process(delta):
	if state != "running":
		get_tree().paused = true
	else:
		get_tree().paused = false
	#print(state)
	$MarginContainer/MainContainer/VBoxContainer/label_pausiert.visible = false
	$MarginContainer/MainContainer/VBoxContainer/label_win.visible = false
	$MarginContainer/MainContainer/VBoxContainer/label_lost.visible = false
	$MarginContainer/MainContainer/VBoxContainer/label_start.visible = false
	$MarginContainer/MainContainer/VBoxContainer2/VBoxContainer/Button_start.visible = false
	$MarginContainer/MainContainer/VBoxContainer2/VBoxContainer/Button_resume.visible = false
	$MarginContainer/MainContainer/VBoxContainer2/VBoxContainer/Button2.visible = true
	match state:
		"start":
			$MarginContainer/MainContainer/VBoxContainer2/VBoxContainer/Button_start.visible = true
			$MarginContainer/MainContainer/VBoxContainer/label_start.visible = true
			$MarginContainer/MainContainer/VBoxContainer2/VBoxContainer/Button2.visible = false
		"pause":
			$MarginContainer/MainContainer/VBoxContainer2/VBoxContainer/Button_resume.visible = true
			$MarginContainer/MainContainer/VBoxContainer/label_pausiert.visible = true
		"won":
			$MarginContainer/MainContainer/VBoxContainer/label_win.visible = true
		"lost":
			$MarginContainer/MainContainer/VBoxContainer/label_lost.visible = true
		

func _on_Button_button_down():
	# unpause
	self.visible = false
	state = "running"


func _on_Button2_button_down():
	# retry
	get_tree().reload_current_scene()
	state = "running"


func _on_Button3_button_down():
	# exit to levels
	get_tree().change_scene("res://Menues/LevelMenu/LevelMenu.tscn")


func _on_Button_start_button_down():
	state = "running"
	self.visible = false
