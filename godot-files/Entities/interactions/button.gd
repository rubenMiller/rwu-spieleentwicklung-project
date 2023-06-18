extends Area


export var channel := 0
export var stay_pressed := false
export (Resource) var idle_material 
export (Resource) var pressed_material 

onready var is_pressed := false 
onready var mesh = $MeshInstance


var standing_list := []
var interaction_objects := []

func _ready() -> void:
	
	mesh.material_override = idle_material
	
	var group_name = "interaction_" + str(channel)
	interaction_objects = get_tree().get_nodes_in_group(group_name)

func _physics_process(delta: float) -> void:
	pass
		
func _on_button_body_entered(body: Node) -> void:
	standing_list.append(body)
	if body.is_in_group("troop") and standing_list.size() == 1:
		mesh.material_override = pressed_material
		for o in interaction_objects:
			o.on_interaction(true)
		
		
func _on_button_body_exited(body: Node) -> void:
	standing_list.erase(body)
	if body.is_in_group("troop") and standing_list.size() == 0 and not stay_pressed:
		mesh.material_override = idle_material
		for o in interaction_objects:
			o.on_interaction(false)
		
