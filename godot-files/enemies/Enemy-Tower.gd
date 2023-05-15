extends KinematicBody

func _ready():
	pass 

func _on_HealtComponent_i_am_dead():
	queue_free()

