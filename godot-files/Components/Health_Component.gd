extends Spatial

signal i_am_dead
export var health = 1

func _process(_delta):
	if health <= 0:
		emit_signal("i_am_dead")
		

func reduce_health(health_delta):
	if health_delta >= 0:
		health = health - int(health_delta)
	if health_delta < 0:
		health = health + int(health_delta)
	
	$Label3D.text = str(health)
