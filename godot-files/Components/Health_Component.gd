extends Spatial

signal i_am_dead

onready var current_health = get_parent().health

func _ready():
	pass
	#$Label3D.text = str(rest_health)
	
	
func _process(_delta):
	if current_health <= 0:
		emit_signal("i_am_dead")
	if current_health <= 3:
		$"../meshes/troop_4".visible = false
	if current_health <= 2:
		$"../meshes/troop_3".visible = false
	if current_health <= 1:
		$"../meshes/troop_2".visible = false
		

func reduce_health(health_delta):
	current_health -= abs(int(health_delta))

	


