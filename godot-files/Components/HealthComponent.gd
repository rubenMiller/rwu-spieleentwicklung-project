extends Spatial

signal i_am_dead
export var health = 1

func _process(delta):
	if health == 0:
		emit_signal("i_am_dead")
		

func reduceHealth(health_delta):
	if health_delta >= 0:
		health = health - int(health_delta)
	if health_delta < 0:
		health = health + int(health_delta)
