extends Spatial

signal i_am_dead

onready var current_health = get_parent().health

func _process(_delta):
	if current_health <= 0:
		emit_signal("i_am_dead")
	if current_health <= 3:
		$"../meshes/TroopColor3".visible = false
		$"../CollisionShape3".disabled = true
		setTranslationTo3meshes()
	if current_health <= 2:
		$"../meshes/TroopColor4".visible = false
		$"../CollisionShape4".disabled = true
		setTranslationTo2meshes()
	if current_health <= 1:
		$"../meshes/TroopColor2".visible = false
		$"../CollisionShape2".disabled = true
		setTranslationTo1mesh()
		
func reduce_health(health_delta):
	current_health -= abs(int(health_delta))


func setTranslationTo3meshes():
	# sin(30) und cos(30)
	$"../meshes/TroopColor2".translation.x = -0.5
	$"../meshes/TroopColor2".translation.z = 0.866
	$"../CollisionShape2".translation.x = -0.5
	$"../CollisionShape2".translation.z = 0.866
	
	$"../meshes/TroopColor4".translation.x = -0.5
	$"../meshes/TroopColor4".translation.z = -0.866
	$"../CollisionShape4".translation.x = -0.5
	$"../CollisionShape4".translation.z = -0.866
	
func setTranslationTo2meshes():
	$"../meshes/TroopColor2".translation.x = -1
	$"../meshes/TroopColor2".translation.z = 0
	$"../CollisionShape2".translation.x = -1
	$"../CollisionShape2".translation.z = 0
	
func setTranslationTo1mesh():
	$"../meshes/TroopColor1".translation.x = 0
	$"../meshes/TroopColor1".translation.z = 0
	$"../CollisionShape1".translation.x = 0
	$"../CollisionShape1".translation.z = 0
