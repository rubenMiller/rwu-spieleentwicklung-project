extends StaticBody

export var channel := 0
export (Resource) var green_signal_color
export (Resource) var red_signal_color

onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var signal_light: MeshInstance = $signal_light
onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer3D

func _ready() -> void:
	var group_name = "interaction_" + str(channel)
	add_to_group(group_name)
	
	for label in $labels.get_children():
		label.text = str(channel)

func on_interaction(enabled):
	if enabled:
		animation_player.play("Door_1_open")
		audio_stream_player.play(28.5)
		signal_light.mesh.material = green_signal_color
	else:
		animation_player.play_backwards("Door_1_open")
		audio_stream_player.play(28.5)
		signal_light.mesh.material = red_signal_color

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	var nav_mesh = get_tree().get_nodes_in_group("navigation_mesh_instance")[0]
	nav_mesh.update_mesh()
