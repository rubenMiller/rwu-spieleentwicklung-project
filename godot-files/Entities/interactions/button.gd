extends Area

export var channel := 0
export var stay_pressed := false
export (Resource) var green_signal_color
export (Resource) var red_signal_color

onready var is_pressed := false 
onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var signal_lights: Spatial = $signal_lights
onready var label: Label3D = $button_body/Label3D

var standing_list := []
var interaction_objects := []

func _ready() -> void:
	var group_name = "interaction_" + str(channel)
	interaction_objects = get_tree().get_nodes_in_group(group_name)
	label.text = str(channel)
	
func _on_button_body_entered(body: Node) -> void:
	standing_list.append(body)
	if body.is_in_group("troop") and standing_list.size() == 1:
		animation_player.play("Button_pressed")
		for light in signal_lights.get_children():
			light.mesh.material = green_signal_color
		for o in interaction_objects:
			o.on_interaction(true)
		
func _on_button_body_exited(body: Node) -> void:
	standing_list.erase(body)
	if body.is_in_group("troop") and standing_list.size() == 0 and not stay_pressed:
		animation_player.play_backwards("Button_pressed")
		for light in signal_lights.get_children():
			light.mesh.material = red_signal_color
		for o in interaction_objects:
			o.on_interaction(false)
		
