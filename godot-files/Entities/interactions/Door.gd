extends StaticBody

onready var mesh_instance: MeshInstance = $MeshInstance
export (Resource) var folder
var enabled = false
var nav_mesh
onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var collision_shape: CollisionShape = $CollisionShape

func _ready() -> void:
	nav_mesh = get_tree().get_nodes_in_group("navigation_mesh_instance")[0]
	#mesh_instance.material/0 = 
	#print(nav_mesh)

func on_interaction(value):
	enabled = value
	
	if enabled:
		animation_player.play("Door_1_open")
		#collision_shape.translation.y = -2
		#nav_mesh.update_mesh()
		print("door opened")
	if not enabled:
		animation_player.play_backwards("Door_1_open")
		#collision_shape.translation.y = 3
		#nav_mesh.update_mesh()
		print("door closed")


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	print("animation finished")
	nav_mesh.update_mesh()
