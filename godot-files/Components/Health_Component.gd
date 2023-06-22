extends Spatial

signal i_am_dead
signal shot(base_health, rest_health)

export var health := 1.0 
var rest_health := health 

func _ready():
	rest_health = health
	#$Label3D.text = str(rest_health)
	
	
func _process(_delta):
	if rest_health <= 0:
		emit_signal("i_am_dead")
		

func reduce_health(health_delta):
	if health_delta >= 0:
		rest_health = rest_health - int(health_delta)
	if health_delta < 0:
		rest_health = rest_health + int(health_delta)
	
	#$Label3D.text = str(rest_health)
	
	emit_signal("shot", health, rest_health)

