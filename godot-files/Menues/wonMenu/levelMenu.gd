extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Level1Button_pressed():
	get_tree().change_scene("res://levels/level_1.tscn")


func _on_Level2Button_pressed():
	get_tree().change_scene("res://levels/level_2.tscn")


func _on_Level3Button_pressed():
	get_tree().change_scene("res://levels/level_3.tscn")


func _on_exitButton_pressed():
	get_tree().change_scene("res://Menues/mainMenu/mainMenu.tscn")
