extends Spatial

signal i_am_dead

onready var current_health = get_parent().health

func _process(_delta):
	if current_health <= 0:
		emit_signal("i_am_dead")
	if current_health <= 3:
		$"../meshes/troop_4".visible = false
		$"../troop_4_coll".disabled = true
	if current_health <= 2:
		$"../meshes/troop_3".visible = false
		$"../troop_3_coll".disabled = true
	if current_health <= 1:
		$"../meshes/troop_2".visible = false
		$"../troop_2_coll".disabled = true
		
func reduce_health(health_delta):
	current_health -= abs(int(health_delta))
