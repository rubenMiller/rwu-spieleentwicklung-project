extends KinematicBody

export var idleMaterial: Material
export var selectedMaterial: Material

onready var isSelected = false
onready var tile_handler = get_node("../tile_handler")
onready var _agent: NavigationAgent = $NavigationAgent

var _velocity := Vector3.ZERO

func _ready():
	$Label3D.hide()
	$MeshInstance.material_override = idleMaterial
	_agent.set_target_location(global_transform.origin)
	tile_handler.connect("tile_selected", self, "move") # aufruf der move funktion
	
func _physics_process(_delta: float) -> void:
	if _agent.is_navigation_finished():
		#print(_agent.get_final_location())
		return
		
	var direction := global_transform.origin.direction_to(_agent.get_next_location())
	#direction.normalized()
	_velocity = direction * 10
	_velocity = move_and_slide(_velocity)
	
func move(child):
	if isSelected: _agent.set_target_location(child.global_transform.origin)

func _on_SelectionArea_selection_toggled(selection):
	#set_process_unhandled_input(selection)
	isSelected = selection
	
	$Label3D.visible = selection
	if selection: $MeshInstance.material_override = selectedMaterial
	else: $MeshInstance.material_override = idleMaterial
		
